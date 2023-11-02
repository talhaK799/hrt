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

  Conversation conversationTo = Conversation();
  Conversation conversationFrom = Conversation();
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
    messageStream = db.getRealTimeMessages(conversation.conversationId);
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
    /// conversation From
    ///
    conversationFrom.conversationId = conversation.conversationId ?? uuid.v4();
    conversation.conversationId = conversationFrom.conversationId;
    conversationFrom.lastMessage = message.textMessage;
    conversationFrom.lastMessageAt = DateTime.now();
    conversationFrom.fromUserId = currentUser.appUser.id;
    conversationFrom.toUserId = toUser.id;
    conversationFrom.isMessageSeen = false;
    conversationFrom.noOfUnReadMsgs = 0;
    conversationFrom.name = toUser.name;
    conversationFrom.isGroupChat = false;
    conversationFrom.isMessageSeen = false;
    conversationFrom.leftedUsers = [];
    conversationFrom.joinedUsers = [];

    ///
    /// Conversation To
    ///

    isSelect = false;
    notifyListeners();

    conversationTo.conversationId = conversationFrom.conversationId;
    conversationTo.lastMessage = message.textMessage;
    conversationTo.lastMessageAt = DateTime.now();
    conversationTo.fromUserId = toUser.id;
    conversationTo.toUserId = currentUser.appUser.id;
    conversationTo.isMessageSeen = false;
    conversationTo.noOfUnReadMsgs = 0;
    conversationTo.name = toUser.name;
    conversationTo.isGroupChat = false;
    conversationTo.isMessageSeen = false;
    conversationTo.leftedUsers = [];
    conversationTo.joinedUsers = [];

    print('message : ${message.textMessage}');
    if (message.textMessage != null && image == null) {
      ///
      /// messages
      ///
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = DateTime.now();
      message.type = 'text';
      messages.add(message);
      notifyListeners();

      db.newMessages(conversationFrom, conversationTo, message,
          currentUser.appUser.id!, toUser.id!);
      if (messages.isEmpty) {
        getAllMessages();
      }

      notifyListeners();

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
      messages.add(message);
      notifyListeners();

      db.newMessages(conversationFrom, conversationTo, message,
          currentUser.appUser.id!, toUser.id!);
      if (messages.isEmpty) {
        getAllMessages();
      }

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
    isSelect = false;
    notifyListeners();

    print('message : ${message.textMessage}');
    if (message.textMessage != null && image == null) {
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = conversation.conversationId;
      message.sendAt = DateTime.now();
      message.type = 'text';
      messages.insert(0, message);
      notifyListeners();
      db.sendGroupMessage(conversation, message);

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
      messages.add(message);
      notifyListeners();
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
