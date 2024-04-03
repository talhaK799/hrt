import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? messageId;
  String? fromUserId;
  String? toUserId;
  String? textMessage;
  String? imageUrl;
  File? file;
  String? voiceUrl;
  FieldValue? sendAt;
  DateTime? sendat;
  String? type;
  bool? isReaded;
  bool isSent = false;
  bool? isOneTime = false;
  bool? isOpened = false;
  List<String>? readingMemebers = [];
  List<String>? seenByMembers = [];

  Message({
    this.file,
    this.fromUserId,
    this.messageId,
    this.sendAt,
    this.textMessage,
    this.imageUrl,
    this.toUserId,
    this.type,
    this.isReaded,
    this.isSent = false,
    this.isOneTime = false,
    this.readingMemebers,
    this.seenByMembers,
    this.isOpened = false,
  });

  Message.fromJson(json, id) {
    isSent = false;
    this.messageId = id;
    this.fromUserId = json["fromUserId"];
    this.toUserId = json["toUserId"];
    this.imageUrl = json["imageUrl"] ?? "";
    this.textMessage = json["textMessage"] ?? "";
    this.sendat = json["sendAt"].toDate();
    this.type = json["type"];
    this.isReaded = json["isReaded"] ?? false;
    this.isOpened = json["isOpened"] ?? false;
    this.isOneTime = json["insOneTime"] ?? false;
    if (json["readingMemebers"] != null) {
      readingMemebers = [];
      json["readingMemebers"].forEach((element) {
        readingMemebers!.add(element);
      });
    } else {
      readingMemebers = [];
    }
    if (json["seenByMembers"] != null) {
      seenByMembers = [];
      json["seenByMembers"].forEach((element) {
        seenByMembers!.add(element);
      });
    } else {
      seenByMembers = [];
    }
  }

  toJson() {
    return {
      "fromUserId": this.fromUserId,
      "toUserId": this.toUserId,
      "textMessage": this.textMessage,
      "imageUrl": this.imageUrl,
      "sendAt": this.sendAt,
      "type": this.type,
      "isReaded": this.isReaded ?? false,
      "isOpened": this.isOpened ?? false,
      "insOneTime": this.isOneTime ?? false,
      "readingMemebers": this.readingMemebers ?? [],
      "seenByMembers": this.seenByMembers ?? [],
    };
  }
}
