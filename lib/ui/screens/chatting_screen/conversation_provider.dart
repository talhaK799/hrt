import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
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
  List<AppUser> likedUsers = [];
  List<Matches> acceptedMatches = [];
  List<AppUser> matchedUsers = [];

  ConversationProvider() {
    init();
  }

  init() async {
    // Future.delayed(Duration(seconds: 5));
    await getConversations();
    await getMatches();
  }

  getMatches() async {
    matchedUsers = [];
    this.likedUsers = [];
    acceptedMatches = [];
    setState(ViewState.busy);
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    this.likedUsers = await db.getMatchedUsers(currentUser.appUser);
    await Future.delayed(Duration(seconds: 5));
    for (var i = 0; i < this.likedUsers.length; i++) {
      this.likedUsers[i].isSelected = false;
      if (this.likedUsers[i].likedUsers!.contains(currentUser.appUser.id)) {
        print('current user ${i + 1} likes <===> ${this.likedUsers[i].id}');
        for (var element in conversations) {
          if (!matchedUsers.contains(this.likedUsers[i]) &&
              element.appUser!.id != this.likedUsers[i].id) {
            matchedUsers.add(likedUsers[i]);
          } else {
            matchedUsers.remove(likedUsers[i]);
          }
        }
      }
    }
    setState(ViewState.idle);
  }

  getConversations() async {
    print('current id ${currentUser.appUser.id}');
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
        getUsers();
      } else {
        conversations = [];
        notifyListeners();
      }
    });
  }

  dispose() {
    super.dispose();
    stream = null;
    notifyListeners();
  }

  getUsers() async {
    // setState(ViewState.busy);
    if (conversations.isNotEmpty) {
      for (var i = 0; i < conversations.length; i++) {
        conversations[i].appUser = AppUser();
        if (conversations[i].isGroupChat == false) {
          conversations[i].appUser =
              await db.getAppUser(conversations[i].toUserId);
          print("User data ===> ${conversations[i].appUser!.toJson()}");

          // await Future.delayed(Duration(seconds: 5));
        }
      }
    }
    // setState(ViewState.idle);
  }

  List<Conversation> conversations = [];

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
