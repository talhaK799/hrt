import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/models/radio_button.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class ConversationProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();

  TextEditingController messageController = TextEditingController();
  AppUser user = AppUser();
  Message message = Message();
  List<Matches> matches = [];
  List<AppUser> matchedUsers = [];

  ConversationProvider() {
    getMatches();
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

  

  List<Chat> chats = [
    Chat(
      name: 'Group',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
      isGroup: true,
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
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
