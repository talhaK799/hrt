import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? messageId;
  String? fromUserId;
  String? toUserId;
  String? textMessage;
  String? imageUrl;
  String? voiceUrl;
  FieldValue? sendAt;
  DateTime? sendat;
  String? type;

  Message({
    this.fromUserId,
    this.messageId,
    this.sendAt,
    this.textMessage,
    this.imageUrl,
    this.toUserId,
    this.type,
  });

  Message.fromJson(json, id) {
    this.messageId = id;
    this.fromUserId = json["fromUserId"];
    this.toUserId = json["toUserId"];
    this.imageUrl = json["imageUrl"] ?? "";
    this.textMessage = json["textMessage"] ?? "";
    this.sendat = DateTime.parse(json["sendAt"].toDate().toString());
    this.type = json["type"];
  }

  toJson() {
    return {
      "fromUserId": this.fromUserId,
      "toUserId": this.toUserId,
      "textMessage": this.textMessage,
      "imageUrl": this.imageUrl,
      "sendAt": this.sendAt,
      "type": this.type,
    };
  }
}
