import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

import '../../../../../core/services/auth_service.dart';

class ChattingProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();

  TextEditingController messageController = TextEditingController();
  AppUser user = AppUser();
  Message message = Message();

  Stream<QuerySnapshot>? messageStream;
  List<Matches> matches = [];
  List<AppUser> matchedUsers = [];

  ChattingProvider() {}
  // List<ChatMessage> messages = [
  //   ChatMessage(
  //     text:
  //         'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
  //     isSender: true,
  //   ),
  //   ChatMessage(
  //     text:
  //         'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
  //   ),
  //   ChatMessage(
  //     text:
  //         'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
  //     isSender: true,
  //   ),
  //   ChatMessage(
  //     text:
  //         'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
  //   )
  // ];

  List<Message> messages = [];
  sendMessage() {
    print('message : ${message.textMessage}');
    if (message.textMessage!.isNotEmpty || message.textMessage != null) {
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = "HG9RTh47bacHyJrx773i96LX5eO2";
      message.sendAt = DateTime.now();
      message.type = "text";
      db.addNewUserMessage(message.fromUserId!, message.toUserId!, message);
      // _databaseService.updateUserMessageReceived(true, conversationTo.id);
      print("new message added");
      messageController.clear();
      message = Message();
      notifyListeners();
    } else {
      print("message is null");
    }
  }

  getAllMessages(String toUserId) async {
    print("ToUserId => $toUserId");
    setState(ViewState.busy);
    messageStream = db.getRealTimeChat(currentUser.appUser.id!, toUserId);
    messageStream!.listen(
      (event) {
        messages = [];
        if (event.docs.length > 0) {
          event.docs.forEach((element) {
            messages.add(Message.fromJson(element.data(), element.id));
            print('Message from stream');
          });
          notifyListeners();
        } else {
          messages = [];
          notifyListeners();
        }
      },
    );
    setState(ViewState.idle);
  }
}
