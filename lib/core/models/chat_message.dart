class Message {
  String? messageId;
  String? fromUserId;
  String? toUserId;
  String? textMessage;
  String? imageUrl;
  String? voiceUrl;

  DateTime? sendAt;
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
    this.sendAt = json["sendAt"].toDate();
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
