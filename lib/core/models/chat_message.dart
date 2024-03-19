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
  List<String>? readingMemebers = [];

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
    this.readingMemebers,
  });

  Message.fromJson(json, id) {
    this.messageId = id;
    this.fromUserId = json["fromUserId"];
    this.toUserId = json["toUserId"];
    this.imageUrl = json["imageUrl"] ?? "";
    this.textMessage = json["textMessage"] ?? "";
    this.sendat =
        // DateTime.parse(
        json["sendAt"].toDate();
    // )
    // ??
    // DateTime.now();
    this.type = json["type"];
    this.isReaded = json["isReaded"] ?? false;
    if (json["readingMemebers"] != null) {
      readingMemebers = [];
      json["readingMemebers"].forEach((element) {
        readingMemebers!.add(element);
      });
    } else {
      readingMemebers = [];
    }
    ;
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
      "readingMemebers": this.readingMemebers ?? [],
    };
  }
}
