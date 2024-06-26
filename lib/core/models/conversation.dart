// class Conversation {
//   String? id;
//   String? name;
//   String? groupAdmin;
//   String? lastMessage;
//   DateTime? lastMessageAt;
//   String? imageUrl;
//   bool? isMessageSeen;
//   int? noOfUnReadMsgs;

//   Conversation({
//     this.id,
//     this.lastMessage,
//     this.name,
//     this.groupAdmin,
//     this.imageUrl,
//     this.lastMessageAt,
//     this.isMessageSeen,
//     this.noOfUnReadMsgs,
//   });

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['name'] = name;
//     data['name'] = name;
//     data['groupAdmin'] = groupAdmin;
//     data['lastMessage'] = lastMessage;
//     data['lastMessageAt'] = lastMessageAt;
//     data["imageUrl"] = imageUrl;
//     data["isMessageSeen"] = isMessageSeen;
//     data["noOfUnReadMsgs"] = noOfUnReadMsgs;
//     return data;
//   }

//   Conversation.fromJson(json) {
//     this.id = json["id"];
//     this.name = json['name'];
//     this.name = json['name'];
//     this.groupAdmin = json['groupAdmin'];
//     this.lastMessageAt = json['lastMessageAt'].toDate();
//     this.lastMessage = json['lastMessage'];
//     this.imageUrl = json['imageUrl'];
//     this.isMessageSeen = json["isMessageSeen"] ?? false;
//     this.noOfUnReadMsgs = json["noOfUnReadMsgs"] ?? 0;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hart/core/models/app_user.dart';

class Conversation {
  String? conversationId;
  String? lastMessage;
  FieldValue? lastMessageAt;
  DateTime? lastMessageat;
  bool? isMessageSeen;
  int? noOfUnReadMsgs;
  bool? isGroupChat;
  List<String>? joinedUsers = [];
  List<String>? leftedUsers = [];
  String? fromUserId;
  String? toUserId;
  String? groupId;
  String? name;
  String? groupAdmin;
  String? imageUrl;
  AppUser? appUser;

  Conversation({
    this.conversationId,
    this.lastMessage,
    this.lastMessageAt,
    this.isMessageSeen,
    this.noOfUnReadMsgs,
    this.isGroupChat,
    this.joinedUsers,
    this.leftedUsers,
    this.toUserId,
    this.fromUserId,
    this.appUser,
    this.groupId,
    this.imageUrl,
    this.name,
    this.groupAdmin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['conversationId'] = conversationId;
    data['lastMessage'] = lastMessage;
    data['lastMessageAt'] = lastMessageAt;
    data["isMessageSeen"] = isMessageSeen;
    data["noOfUnReadMsgs"] = noOfUnReadMsgs;
    data["fromUserId"] = fromUserId;
    data["toUserId"] = toUserId;
    data["imageUrl"] = imageUrl;
    data['name'] = name;
    data['groupAdmin'] = groupAdmin;
    data["joinedUsers"] = joinedUsers;
    data["leftedUsers"] = leftedUsers;
    data["groupId"] = groupId;
    data["isGroupChat"] = isGroupChat;
    return data;
  }

  Conversation.fromJson(json) {
    this.conversationId = json["conversationId"];
    this.lastMessageat =
        // lastMessageAt != null
        // ? DateTime.parse(
        json['lastMessageAt'] == null
            ? DateTime.now()
            : json['lastMessageAt'].toDate();
    // )
    // : DateTime.now();
    this.imageUrl = json['imageUrl'];
    this.name = json['name'] ?? 'Group';
    this.groupAdmin = json['groupAdmin'] ?? 'Group';
    this.lastMessage = json['lastMessage'] ?? "";
    this.isMessageSeen = json["isMessageSeen"] ?? false;
    this.noOfUnReadMsgs = json["noOfUnReadMsgs"] ?? 0;
    this.fromUserId = json["fromUserId"] ?? "";
    this.toUserId = json["toUserId"] ?? "";
    this.groupId = json['groupId'] ?? "";
    this.isGroupChat = json['isGroupChat'] ?? false;
    if (json["leftedUsers"] != null) {
      leftedUsers = [];
      json["leftedUsers"].forEach((id) {
        leftedUsers!.add(id);
      });
    } else {
      leftedUsers = [];
    }
    if (json["joinedUsers"] != null) {
      joinedUsers = [];
      json["joinedUsers"].forEach((id) {
        joinedUsers!.add(id);
      });
    } else {
      joinedUsers = [];
    }
  }
}
