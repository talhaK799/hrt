import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

import '../../../../../core/services/auth_service.dart';

class ChattingProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  

  TextEditingController messageController = TextEditingController();
  AppUser toUser = AppUser();
  Message message = Message();

  Conversation conversationTo = Conversation();
  Conversation conversationFrom = Conversation();
  Conversation conversation = Conversation();

  Stream<QuerySnapshot>? messageStream;
  List<Matches> matches = [];
  List<AppUser> matchedUsers = [];

  ChattingProvider(UserId) {
    message = Message();
    toUser = AppUser();

    getUser(UserId);
  }

  getUser(UserId) async {
    setState(ViewState.busy);
    toUser = await db.getAppUser(UserId);
    setState(ViewState.idle);
    if (toUser.id != null) {
      getAllMessages(UserId);
    }
  }

  List<Message> messages = [];
  sendMessage() {
    print('message : ${message.textMessage}');
    if (message.textMessage!.isNotEmpty || message.textMessage != null) {
      ///
      /// message from
      ///

      conversationFrom.id = currentUser.appUser.id;
      conversationFrom.lastMessage = message.textMessage;
      conversationFrom.lastMessageAt = DateTime.now();
      conversationFrom.imageUrl = currentUser.appUser.images!.first;
      conversationFrom.name = currentUser.appUser.name;
      conversationFrom.isMessageSeen = false;
      conversationFrom.noOfUnReadMsgs = 0;

      ///
      /// message to
      ///
      conversationTo.id = toUser.id;
      conversationTo.lastMessage = message.textMessage;
      conversationTo.lastMessageAt = DateTime.now();
      conversationTo.name = toUser.name;
      conversationTo.imageUrl = toUser.images!.first;
      conversationTo.isMessageSeen = true;
      conversationTo.noOfUnReadMsgs = 0;

      ///
      /// messages
      ///
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = DateTime.now();
      message.type = "text";
      db.addNewUserMessage(conversationFrom, conversationTo, message);
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
