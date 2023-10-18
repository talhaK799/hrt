class Conversation {
  String? id;
  String? name;
  String? lastMessage;
  DateTime? lastMessageAt;
  String? imageUrl;
  bool? isMessageSeen;
  int? noOfUnReadMsgs;

  Conversation({
    this.id,
    this.lastMessage,
    this.name,
    this.imageUrl,
    this.lastMessageAt,
    this.isMessageSeen,
    this.noOfUnReadMsgs,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['lastMessage'] = lastMessage;
    data['lastMessageAt'] = lastMessageAt;
    data["imageUrl"] = imageUrl;
    data["isMessageSeen"] = isMessageSeen;
    data["noOfUnReadMsgs"] = noOfUnReadMsgs;
    return data;
  }

  Conversation.fromJson(json) {
    this.id = json["id"];
    this.name = json['name'];
    this.lastMessageAt = json['lastMessageAt'].toDate();
    this.lastMessage = json['lastMessage'];
    this.imageUrl = json['imageUrl'];
    this.isMessageSeen = json["isMessageSeen"] ?? false;
    this.noOfUnReadMsgs = json["noOfUnReadMsgs"] ?? 0;
  }
}
