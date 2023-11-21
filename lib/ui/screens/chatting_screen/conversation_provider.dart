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
import 'package:hart/core/services/locato_storage_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class ConversationProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  final localStorage = locator<LocalStorageService>();

  Stream<QuerySnapshot>? stream;

  TextEditingController messageController = TextEditingController();
  AppUser user = AppUser();
  Message message = Message();
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
    if (currentUser.likedUsers.isEmpty) {
      setState(ViewState.busy);
      await Future.delayed(Duration(seconds: 5));
    }
    // currentUser.likedUsers = [];
    // acceptedMatches = [];

    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    currentUser.likedUsers = await db.getMatchedUsers(currentUser.appUser);

    setState(ViewState.idle);

    for (var i = 0; i < currentUser.likedUsers.length; i++) {
      currentUser.likedUsers[i].isSelected = false;
      if (currentUser.likedUsers[i].likedUsers!
          .contains(currentUser.appUser.id)) {
        print(
            'current user ${i + 1} likes <===> ${currentUser.likedUsers[i].id}');
        for (var element in conversations) {
          if (!matchedUsers.contains(currentUser.likedUsers[i]) &&
              element.appUser!.id != currentUser.likedUsers[i].id) {
            matchedUsers.add(currentUser.likedUsers[i]);
          } else {
            matchedUsers.remove(currentUser.likedUsers[i]);

            notifyListeners();
          }
        }
      }
    }
    notifyListeners();
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
