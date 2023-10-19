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
  List<AppUser> matchedUsers = [];

  ConversationProvider() {
    getMatches();
    getConversations();
  }

  getMatches() async {
    setState(ViewState.busy);
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    matches = await db.getAllMatches(currentUser.appUser.id!);
    for (var m in matches) {
      user = await db.getAppUser(m.likedByUserId);
      matchedUsers.add(user);
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  getConversations() async {
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
