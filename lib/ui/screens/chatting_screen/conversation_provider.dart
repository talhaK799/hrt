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
  bool firstTime = true;
  Stream<QuerySnapshot>? stream;
  TextEditingController messageController = TextEditingController();
  AppUser user = AppUser();
  Message message = Message();
  List<Matches> acceptedMatches = [];
  List<AppUser> likedUsers = [];

  ConversationProvider() {
    init();
  }

  init() async {
    // Future.delayed(Duration(seconds: 5));
    // currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    if (currentUser.matchedUsers.isEmpty && currentUser.conversations.isEmpty) {
      setState(ViewState.busy);
    }
    await getConversations();
    await getMatches();
    currentUser.appUser.onlineTime = DateTime.now();
    db.updateUserProfile(currentUser.appUser);
    setState(ViewState.idle);
  }

  filterMatches() async {
    List<AppUser> matchedUsers = [];
    await Future.delayed(Duration(seconds: 2));
    for (var i = 0; i < likedUsers.length; i++) {
      likedUsers[i].isSelected = false;
      if (likedUsers[i].likedUsers!.contains(currentUser.appUser.id)) {
        print('${likedUsers[i].id} likes $i ===> ${currentUser.appUser.id}');
        if (currentUser.conversations.isNotEmpty) {
          for (var j = 0; j < currentUser.conversations.length; j++) {
            if (currentUser.conversations[j].isGroupChat == false) {
              if (likedUsers[i].id ==
                  currentUser.conversations[j].appUser!.id) {
                print(
                    'match user ==> ${likedUsers[i].id}======>${currentUser.conversations[j].appUser!.id} ');
                if (matchedUsers.contains(likedUsers[i])) {
                  matchedUsers.remove(likedUsers[i]);
                }
                break;
              } else {
                if (!matchedUsers.contains(likedUsers[i])) {
                  matchedUsers.add(likedUsers[i]);
                }
              }
            }
          }
        } else {
          if (!matchedUsers.contains(likedUsers[i])) {
            matchedUsers.add(likedUsers[i]);
          }
        }
      }
    }
    currentUser.matchedUsers = matchedUsers;
    notifyListeners();
  }

  getMatches() async {
    if (currentUser.matchedUsers.isEmpty && currentUser.isChatloaded == false) {
      setState(ViewState.busy);
      await Future.delayed(Duration(seconds: 1));
      currentUser.isChatloaded = true;
    }
    // currentUser.likedUsers = [];
    // acceptedMatches = [];
    // currentUser.matchedUsers = [];
    likedUsers = [];

    likedUsers = await db.getMatchedUsers(currentUser.appUser);
    print("Liked users ===> ${likedUsers.length}");
    await filterMatches();

    notifyListeners();

    try {
      // currentUser.matches = [];
      // for (var i = 0; i < likedUsers.length; i++) {
      //   likedUsers[i].isSelected = false;
      //   if (likedUsers[i].likedUsers!.contains(currentUser.appUser.id)) {
      //     print('User Matched');
      //     print('Is chat created ===> ${likedUsers[i].isFirstTimeChat}');
      //     // if (!currentUser.matchedUsers.contains(likedUsers[i])) {
      //     if (likedUsers[i].isFirstTimeChat == true) {
      //       currentUser.matchedUsers.add(likedUsers[i]);
      //     } else {
      //       currentUser.matchedUsers.remove(likedUsers[i]);
      //       notifyListeners();
      //     }
      //     // }
      //     // for (var element in currentUser.conversations) {
      //     //   if (!currentUser.matchedUsers.contains(likedUsers[i]) &&
      //     //       element.toUserId != likedUsers[i].id) {
      //     //     currentUser.matchedUsers.add(likedUsers[i]);
      //     //   } else {
      //     //     currentUser.matchedUsers.remove(likedUsers[i]);

      //     //     notifyListeners();
      //     //   }
      //     // }
      //   }
      // }
      // filterMatches();

      print("Match users ===> ${currentUser.matchedUsers.length}");

      notifyListeners();
    } catch (e) {
      print("Error @ getMatches $e");
    }
  }

  getConversations() async {
    print('current id ${currentUser.appUser.id}');
    try {
      stream = db.getAllConverationList(currentUser.appUser.id!);
      stream!.listen((event) {
        currentUser.conversations = [];
        if (event.docs.length > 0) {
          event.docs.forEach((element) {
            // if (!currentUser.conversations
            //     .contains(Conversation.fromJson(element.data()))) {
            currentUser.conversations
                .add(Conversation.fromJson(element.data()));
            notifyListeners();
            // }
          });
          getUsers();
        } else {
          currentUser.conversations = [];
          notifyListeners();
        }
      });
      notifyListeners();
    } catch (e) {
      print("Error @ getConversations $e");
    }
  }

  dispose() {
    super.dispose();
    stream = null;
    // notifyListeners();
  }

  getUsers() async {
    // setState(ViewState.busy);
    if (currentUser.conversations.isNotEmpty) {
      for (var i = 0; i < currentUser.conversations.length; i++) {
        if (currentUser.conversations[i].isGroupChat == false) {
          currentUser.conversations[i].appUser = AppUser();
          if (currentUser.conversations[i].isGroupChat == false) {
            currentUser.conversations[i].appUser =
                await db.getAppUser(currentUser.conversations[i].toUserId);
          }
        }
      }
    }
    notifyListeners();
    filterMatches();
  }

  // List<Conversation> conversations = [];

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
