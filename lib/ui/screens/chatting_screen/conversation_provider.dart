import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/models/radio_button.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class ConversationProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();

  Stream<QuerySnapshot>? stream;

  TextEditingController messageController = TextEditingController();
  AppUser user = AppUser();
  Message message = Message();
  List<Matches> matches = [];
  List<Matches> acceptedMatches = [];
  List<AppUser> matchedUsers = [];

  ConversationProvider() {
    getMatches();
    getConversations();
  }

  getMatches() async {
    matchedUsers = [];
    matches = [];
    acceptedMatches = [];
    setState(ViewState.busy);
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    matches = await db.getProgressedRequest(currentUser.appUser.id!);
    for (var i = 0; i < matches.length; i++) {
      if (matches[i].likedUserId == currentUser.appUser.id) {
        print("Match found");
        acceptedMatches.add(matches[i]);

        notifyListeners();
      } else if (matches[i].likedByUserId == currentUser.appUser.id) {
        acceptedMatches.add(matches[i]);
      } else {
        print("Match not found");
      }
    }

    for (var i = 0; i < acceptedMatches.length; i++) {
      if (acceptedMatches[i].likedUserId == currentUser.appUser.id) {
        acceptedMatches[i].otherUserId = acceptedMatches[i].likedByUserId;
      } else if (acceptedMatches[i].likedByUserId == currentUser.appUser.id) {
        acceptedMatches[i].otherUserId = acceptedMatches[i].likedUserId;
      }
    }
    for (var m in acceptedMatches) {
      user = await db.getAppUser(m.otherUserId);
      matchedUsers.add(user);
      user = AppUser();
      notifyListeners();
    }
    setState(ViewState.idle);
  }

  getConversations() async {
    setState(ViewState.busy);
    stream = await db.getAllConverationList(currentUser.appUser.id!);
    stream!.listen((event) {
      conversations = [];
      if (event.docs.length > 0) {
        event.docs.forEach((element) {
          conversations.add(
            Conversation.fromJson(element.data()),
          );

          notifyListeners();

          print("Conversation == > ${conversations.first.toJson()}");
        });
      } else {
        conversations = [];
        notifyListeners();
      }
    });
    setState(ViewState.busy);
    if (conversations.isNotEmpty) {
      for (var i = 0; i < conversations.length; i++) {
        conversations[i].appUser = AppUser();
        conversations[i].appUser =
            await db.getAppUser(conversations[i].toUserId);
      }
    }
    setState(ViewState.idle);
  }

  List<Conversation> conversations = [];
  List<Chat> chats = [
    Chat(
      name: 'Group',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
      isGroup: true,
    ),
    // Chat(
    //   name: 'Joseph',
    //   desscription: 'Lorem ipsum dolor sit amet consectet.',
    // ),
    // Chat(
    //   name: 'Joseph',
    //   desscription: 'Lorem ipsum dolor sit amet consectet.',
    // ),
    // Chat(
    //   name: 'Joseph',
    //   desscription: 'Lorem ipsum dolor sit amet consectet.',
    // ),
    // Chat(
    //   name: 'Joseph',
    //   desscription: 'Lorem ipsum dolor sit amet consectet.',
    // ),
    // Chat(
    //   name: 'Joseph',
    //   desscription: 'Lorem ipsum dolor sit amet consectet.',
    // ),
  ];

  List<RadioButton> buttons = [
    RadioButton(
      title: 'Not my type',
    ),
    RadioButton(
      title: 'Fake/spam',
    ),
    RadioButton(
      title: 'Under age',
    ),
    RadioButton(
      title: 'Offensive',
    ),
    RadioButton(
      title: 'Soliciting',
    ),
  ];

  selectButton(index) {
    for (var i = 0; i < buttons.length; i++) {
      if (index == i) {
        buttons[i].isSelected = true;
      } else {
        buttons[i].isSelected = false;
      }
    }
    notifyListeners();
  }
}
