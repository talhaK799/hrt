import 'dart:async';
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
import 'package:no_screenshot/no_screenshot.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/services/auth_service.dart';

class ChattingProvider extends BaseViewModel {
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  final storage = FirebaseStorageService();
  final filePicker = FilePickerService();

  final _noScreenshot = NoScreenshot.instance;

  TextEditingController messageController = TextEditingController();
  AppUser toUser = AppUser();
  Message message = Message();
  Conversation conversationTo = Conversation();
  Conversation conversationFrom = Conversation();
  Conversation conversation = Conversation();
  Stream<QuerySnapshot>? messageStream;
  StreamSubscription<QuerySnapshot>? messageStreamSubscription;
  bool isSelect = false;

  File? image;
  List<Matches> matches = [];
  List<AppUser> matchedUsers = [];
  bool isShowImagePreview = false;
  AppUser blockingUser = AppUser();

  ChattingProvider(userId, conversation) {
    print('chat user  $userId===> ');
    this.conversation = conversation;

    // print("conversations list ====> ${this.conversation.leftedUsers!.length}");
    this.conversation.isGroupChat = this.conversation.isGroupChat ?? false;
    message = Message();
    toUser = AppUser();
    this.conversation.isGroupChat == false ? getUser(userId) : null;
    this.conversation.isGroupChat == true ? getAllMessages() : getAllMessages();
    disableScreenShot();
    // notifyListeners();
  }

  disableScreenShot() async {
    await _noScreenshot.screenshotOff();
    print('screen shots are disabled');
  }

  getUser(userId) async {
    setState(ViewState.busy);
    print(userId);

    toUser = await db.getAppUser(userId);

    setState(ViewState.idle);
    // notifyListeners();
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
    // conversation.conversationId = toUser.id;
    if (conversation.conversationId != null) {}
    setState(ViewState.busy);
    messageStream = db.getRealTimeMessages(conversation.conversationId);
    setState(ViewState.idle);
    messageStreamSubscription = messageStream!.listen(
      (event) async {
        messages = [];
        if (event.docs.length > 0) {
          event.docs.forEach((element) {
            messages.add(Message.fromJson(element.data(), element.id));
          });
          for (var msg in messages) {
            /// single user conversation
            if (msg.toUserId == currentUser.appUser.id) {
              msg.readingMemebers = [];
              print('messages toUser  ===> ${msg.toUserId}');
              msg.isReaded = true;
              db.readMessages(conversation.conversationId, msg);

              /// Group converstion
            } else if (msg.toUserId == conversation.conversationId) {
              print('messages toUser group ===> ${msg.toUserId}');
              if (!msg.readingMemebers!.contains(currentUser.appUser.id)) {
                msg.readingMemebers!.add(currentUser.appUser.id!);
                db.readGroupMessages(conversation.conversationId, msg);
              }
            }
          }
          notifyListeners();
        } else {
          messages = [];
          notifyListeners();
        }
      },
    );

    // notifyListeners();
  }

  disposestream() {
    // super.dispose();.
    messageStreamSubscription?.cancel();
    messageStream = null;
  }

  removeImage() {
    isSelect = false;
    image = null;
    message.file = null;
    isShowImagePreview = false;
    notifyListeners();
  }

  pickImage() async {
    image = await filePicker.pickImage();

    if (image != null) {
      isShowImagePreview = true;
      message.file = image;
      isSelect = !isSelect;
    }

    notifyListeners();
  }

  pickImageFromGallery() async {
    image = await filePicker.pickImageWithCompressionFromCamera();

    if (image != null) {
      message.file = image;
      isSelect = !isSelect;
    }

    notifyListeners();
  }

  /// ================================================= ///
  /// =============== Normal Chat ===================== ///
  /// ================================================= ///

  var uuid = Uuid();

  sendNewMessage() async {
    if (messages.isEmpty) {
      toUser.isFirstTimeChat = false;
      db.updateUserProfile(toUser);
    }
    // message.textMessage = '';

    ///
    /// conversation From
    ///
    conversationFrom.conversationId = conversation.conversationId ?? uuid.v4();
    conversation.conversationId = conversationFrom.conversationId;
    conversationFrom.lastMessage = message.textMessage;
    conversationFrom.lastMessageAt = FieldValue.serverTimestamp();
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
    conversationTo.lastMessageAt = FieldValue.serverTimestamp();
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
      message.sendAt = FieldValue.serverTimestamp();
      message.type = 'text';
      message.isReaded = false;
      // message.readingMemebers = null;
      // messages.add(message);
      messages.insert(0, message);
      isShowImagePreview = false;
      notifyListeners();

      db.newMessages(conversationFrom, conversationTo, message,
          currentUser.appUser.id!, toUser.id!);
      if (messages.isEmpty) {
        await getAllMessages();
      }

      // notifyListeners();

      messageController.clear();
      message = Message();
      notifyListeners();
    } else if (image != null) {
      message.isSent = true;
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = FieldValue.serverTimestamp();
      message.file = image;

      message.isReaded = false;
      // message.readingMemebers = null;
      message.type = 'image';
      // messages.add(message);
      messages.insert(0, message);
      isShowImagePreview = false;
      // message.file = null;
      message.imageUrl = await storage.uploadImage(image!, 'Chat Images');
      notifyListeners();

      db.newMessages(conversationFrom, conversationTo, message,
          currentUser.appUser.id!, toUser.id!);
      if (messages.isEmpty) {
        getAllMessages();
      }

      message.isSent = false;

      messageController.clear();
      image = null;
      message = Message();
      // notifyListeners();
    } else {
      print("message is null");
    }
  }

  /// ================================================= ///
  /// ================ Group Chat ===================== ///
  /// ================================================= ///
  sendGroupMessage() async {
    isSelect = false;
    notifyListeners();
    conversation.lastMessage = message.textMessage;
    conversation.lastMessageAt = FieldValue.serverTimestamp();

    if (message.textMessage != null && image == null) {
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = conversation.conversationId;
      message.sendAt = FieldValue.serverTimestamp();
      message.readingMemebers = [];
      // message.isReaded = null;
      message.type = 'text';
      // messages.add(message);
      messages.insert(0, message);
      // notifyListeners();
      db.sendGroupMessage(conversation, message);

      messageController.clear();
      message = Message();
      notifyListeners();
    } else if (image != null) {
      message.isSent = true;
      message.fromUserId = currentUser.appUser.id;
      message.toUserId = toUser.id;
      message.sendAt = FieldValue.serverTimestamp();
      message.file = image;
      message.type = 'image';
      message.readingMemebers = [];
      // message.isReaded = null;
      // messages.add(message);
      messages.insert(0, message);
      isShowImagePreview = false;
      // message.file = null;

      message.imageUrl = await storage.uploadImage(image!, 'Chat Images');
      // notifyListeners();
      db.sendGroupMessage(conversation, message);

      message.isSent = false;
      setState(ViewState.idle);

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
