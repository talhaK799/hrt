import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/file_picker_service.dart';
import 'package:hart/core/services/firebase_storage_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/services/auth_service.dart';

class ChattingProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  final storage = FirebaseStorageService();
  final filePicker = FilePickerService();

  TextEditingController messageController = TextEditingController();
  AppUser toUser = AppUser();
  Message message = Message();

  // Conversation conversationTo = Conversation();
  // Conversation conversationFrom = Conversation();
  Conversation conversation = Conversation();

  Stream<QuerySnapshot>? messageStream;
  bool isSelect = false;
  File? image;
  List<Matches> matches = [];
  List<AppUser> matchedUsers = [];

  ChattingProvider(userId, conversation) {
    this.conversation = conversation;
    this.conversation.isGroupChat = this.conversation.isGroupChat ?? false;
    message = Message();
    toUser = AppUser();
    this.conversation.isGroupChat == false ? getUser(userId) : null;
    this.conversation.isGroupChat == true ? getAllMessages() : getAllMessages();
  }

  getUser(userId) async {
    setState(ViewState.busy);
    print(userId);

    toUser = await db.getAppUser(userId);

    setState(ViewState.idle);
    // getAllMessages();
    // if (this.conversation.conversationId != null && toUser.id != null) {
    //   getAllMessages(this.conversation.conversationId!);
    // }
  }

  List<Message> messages = [];

  // sendMessage() async {
  //   // message.textMessage = '';

  //   ///
  //   /// message from
  //   ///

  //   isSelect = false;
  //   notifyListeners();
  //   conversationFrom.id = currentUser.appUser.id;
  //   conversationFrom.lastMessage = message.textMessage;
  //   conversationFrom.lastMessageAt = DateTime.now();
  //   conversationFrom.imageUrl = currentUser.appUser.images!.first;
  //   conversationFrom.name = currentUser.appUser.name;
  //   conversationFrom.isMessageSeen = false;
  //   conversationFrom.noOfUnReadMsgs = 0;

  //   ///
  //   /// message to
  //   ///
  //   conversationTo.id = toUser.id;
  //   conversationTo.lastMessage = message.textMessage;
  //   conversationTo.lastMessageAt = DateTime.now();
  //   conversationTo.name = toUser.name;
  //   conversationTo.imageUrl = toUser.images!.first;
  //   conversationTo.isMessageSeen = true;
  //   conversationTo.noOfUnReadMsgs = 0;

  //   print('message : ${message.textMessage}');
  //   if (message.textMessage != null && image == null) {
  //     ///
  //     /// messages
  //     ///
  //     message.fromUserId = currentUser.appUser.id;
  //     message.toUserId = toUser.id;
  //     message.sendAt = DateTime.now();
  //     message.type = 'text';
  //     print('Text message');

  //     await db.addNewUserMessage(conversationFrom, conversationTo, message);

  //     // message.type = "text";
  //     // _databaseService.updateUserMessageReceived(true, conversationTo.id);
  //     print("new message added");

  //     messageController.clear();
  //     message = Message();
  //     notifyListeners();
  //   } else if (image != null) {
  //     message.fromUserId = currentUser.appUser.id;
  //     message.toUserId = toUser.id;
  //     message.sendAt = DateTime.now();

  //     message.imageUrl = await storage.uploadImage(image!, 'Chat Images');
  //     print('image url : ${message.imageUrl}');
  //     message.type = 'image';
  //     await db.addNewUserMessage(conversationFrom, conversationTo, message);

  //     print('image sent');
  //     messageController.clear();
  //     image = null;
  //     message = Message();
  //     notifyListeners();
  //   } else {
  //     print("message is null");
  //   }
  // }

  getAllMessages() async {
    setState(ViewState.busy);
    messageStream = await db.getRealTimeMessages(conversation.conversationId);
    setState(ViewState.idle);
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
  }

  // selectImage() {
  //   isSelect = !isSelect;
  //   notifyListeners();
  // }

  pickImage() async {
    image = await filePicker.pickImage();

    if (image != null) {
      isSelect = !isSelect;
    }

    notifyListeners();
  }

  pickImageFromGallery() async {
    image = await filePicker.pickImageWithCompressionFromCamera();

    if (image != null) {
      isSelect = !isSelect;
    }

    notifyListeners();
  }

  /// ================================================= ///
  /// =============== Normal Chat ===================== ///
  /// ================================================= ///

  var uuid = Uuid();

  sendNewMessage() async {
    // message.textMessage = '';

    ///
    /// message from
    ///

    isSelect = false;
    notifyListeners();
    conversation.conversationId = conversation.conversationId ?? uuid.v4();
    conversation.lastMessage = message.textMessage;
    conversation.lastMessageAt = DateTime.now();
    conversation.fromUserId = currentUser.appUser.id;
    conversation.toUserId = toUser.id;
    conversation.isMessageSeen = false;
    conversation.noOfUnReadMsgs = 0;
    conversation.name = toUser.name;

    print('message : ${message.textMessage}');
    if (message.textMessage != null && image == null) {
      ///
      /// messages
      ///
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = DateTime.now();
      message.type = 'text';
      print('Text message');
      print("Conversation id ===> ${this.conversation.conversationId}");

      // await db.addNewUserMessage(conversationFrom, conversationTo, message);

      print("Conversation ===> ${conversation.toJson()}");
      db.newMessages(
          conversation, message, currentUser.appUser.id!, toUser.id!);

      // message.type = "text";
      // _databaseService.updateUserMessageReceived(true, conversationTo.id);
      print("new message added");

      messageController.clear();
      message = Message();
      notifyListeners();
    } else if (image != null) {
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = DateTime.now();

      message.imageUrl = await storage.uploadImage(image!, 'Chat Images');
      print('image url : ${message.imageUrl}');
      message.type = 'image';
      // await db.addNewUserMessage(conversationFrom, conversationTo, message);
      db.newMessages(
          conversation, message, currentUser.appUser.id!, toUser.id!);

      print('image sent');
      messageController.clear();
      image = null;
      message = Message();
      notifyListeners();
    } else {
      print("message is null");
    }
  }

  /// ================================================= ///
  /// ================ Group Chat ===================== ///
  /// ================================================= ///
  ///
  sendGroupMessage() async {
    // message.textMessage = '';

    ///
    /// message from
    ///

    isSelect = false;
    notifyListeners();
    // conversation.conversationId = conversation.conversationId ?? uuid.v4();
    // conversation.lastMessage = message.textMessage;
    // conversation.lastMessageAt = DateTime.now();
    // conversation.fromUserId = currentUser.appUser.id;
    // conversation.toUserId = toUser.id;
    // conversation.isMessageSeen = false;
    // conversation.noOfUnReadMsgs = 0;
    // conversation.name = toUser.name;

    print('message : ${message.textMessage}');
    if (message.textMessage != null && image == null) {
      ///
      /// messages
      ///
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = conversation.conversationId;
      message.sendAt = DateTime.now();
      message.type = 'text';
      print('Text message');
      print("Conversation id ===> ${this.conversation.conversationId}");

      // await db.addNewUserMessage(conversationFrom, conversationTo, message);

      print("Conversation ===> ${conversation.toJson()}");
      db.sendGroupMessage(conversation, message);

      // message.type = "text";
      // _databaseService.updateUserMessageReceived(true, conversationTo.id);
      print("new message added");

      messageController.clear();
      message = Message();
      notifyListeners();
    } else if (image != null) {
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = DateTime.now();

      message.imageUrl = await storage.uploadImage(image!, 'Chat Images');
      print('image url : ${message.imageUrl}');
      message.type = 'image';
      db.sendGroupMessage(conversation, message);

      print('image sent');
      messageController.clear();
      image = null;
      message = Message();
      notifyListeners();
    } else {
      print("message is null");
    }
  }
}
