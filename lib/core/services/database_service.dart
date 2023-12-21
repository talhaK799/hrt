import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/models/spank.dart';
import 'package:hart/core/models/subscripton.dart';
import 'package:hart/core/models/uplift.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  /// Register app user
  registerAppUser(AppUser user) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('app_user')
          .doc(user.id)
          .set(user.toJson())
          .then((value) => debugPrint('user registered successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  addRequest(Matches match) async {
    // debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('Matches')
          .add(match.toJson())
          .then((value) => debugPrint('Match published'));
      return true;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/matchUser');
      debugPrint(s.toString());
      return false;
    }
  }

  getAllRequest(String currentUserId) async {
    List<Matches> list = [];
    try {
      final snapshot = await _db
          .collection("Matches")
          .where("isProgressed", isEqualTo: false)
          .where("likedUserId", isEqualTo: currentUserId)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          list.add(Matches.fromJson(element.data(), element.id));
        });
      }
    } catch (e) {
      print("Exception@addNewRequests ==> $e");
    }
    return list;
  }

  getProgressedRequest() async {
    List<Matches> list = [];
    try {
      final snapshot = await _db
          .collection("Matches")
          .where("isAccepted", isEqualTo: true)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          list.add(Matches.fromJson(element.data(), element.id));
        });
      }
    } catch (e) {
      print("Exception@addNewRequests ==> $e");
    }
    return list;
  }

  // addNewMatch(String userId, UserMatch match) async {
  //   try {
  //     final snapshot = await _db
  //         .collection("All_Matches")
  //         .doc(userId)
  //         .collection("My_Matched")
  //         .doc(match.userId)
  //         .get();
  //     if (!snapshot.exists) {
  //       await _db
  //           .collection("All_Matches")
  //           .doc(userId)
  //           .collection("My_Matched")
  //           .doc(match.userId)
  //           .set(match.toJson());
  //     }

  //     return true;
  //   } catch (e) {
  //     print("Exception@addNewMatch ==> $e");
  //     return false;
  //   }
  // }

  // getAllMatches(String currentUserId) async {
  //   List<Matches> list = [];
  //   try {
  //     final snapshot = await _db
  //         .collection("Matches")
  //         .where("isAccepted", isEqualTo: true)
  //         .where("likedUserId", isEqualTo: currentUserId,)
  //         .get();
  //     if (snapshot.docs.length > 0) {
  //       snapshot.docs.forEach((element) {
  //         list.add(Matches.fromJson(element.data(), element.id));
  //       });
  //       print('match data ===> ${list.first.likedByUserId}');
  //     }
  //   } catch (e) {
  //     print("Exception@getAllMatches ==> $e");
  //   }
  //   return list;
  // }

  updateRequest(Matches request) async {
    try {
      await _db.collection("Matches").doc(request.id).update(request.toJson());
      return true;
    } catch (e) {
      print("Exception@addNewRequests ==> $e");
      return false;
    }
  }

  getRequest(String otherUserId, String currentUserId) async {
    try {
      final snapshot = await _db
          .collection("Matches")
          .where("isProgressed", isEqualTo: false)
          .where("likedUserId", isEqualTo: currentUserId)
          .where("likedByUserId", isEqualTo: otherUserId)
          .get();
      return Matches.fromJson(
          snapshot.docs.first.data(), snapshot.docs.first.id);
    } catch (e) {
      print("Exception@addNewRequests ==> $e");
      return Matches();
    }
  }

  /// Get User from database using this funciton
  getAppUser(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('app_user').doc(id).get();
      debugPrint('Client Data: ${snapshot.data()}');
      if (snapshot.data() == null) {
        return AppUser();
      } else {
        return AppUser.fromJson(snapshot.data(), snapshot.id);
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser ==> error -> $e');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  checkUser(AppUser user) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: ${user.id}');
    try {
      final snapshot = await _db.collection('app_user').doc(user.id).get();
      print("exists: ${snapshot.exists}");
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  updateUserProfile(AppUser appUser) async {
    // print("appuaser premiume check: ${appUser.isPremiumUser}");
    print("appuaser id check: ${appUser.id}");
    try {
      await _db.collection('app_user').doc(appUser.id).update(appUser.toJson());
      return true;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAppUser ==>$e');
      debugPrint(s.toString());
      return false;
    }
  }

  updateClientFcm(token, id) async {
    await _db.collection("app_user").doc(id).update(
      {'fcmToken': token},
    ).then((value) => debugPrint('fcm updated successfully'));
  }

  getIdentity() async {
    List<InfoItem> list = [];
    try {
      final snapshot = await _db.collection('Identity').get();
      for (var element in snapshot.docs) {
        list.add(
          InfoItem.fromJson(element.data(), element.id),
        );
        print('List data ===> ${element.data()}');
      }

      return list;
    } catch (e) {
      print('error occure while getting the data======>$e');
    }
  }

  getDesires() async {
    List<InfoItem> list = [];
    try {
      final snapshot = await _db.collection('Desires').get();
      for (var element in snapshot.docs) {
        list.add(
          InfoItem.fromJson(element.data(), element.id),
        );
        print('List data ===> ${element.data()}');
      }

      return list;
    } catch (e) {
      print('error occure while getting the data======>$e');
    }
  }

  getPersonalities() async {
    List<InfoItem> list = [];
    try {
      final snapshot = await _db.collection('Personalities').get();
      for (var element in snapshot.docs) {
        list.add(
          InfoItem.fromJson(element.data(), element.id),
        );
        print('List data ===> ${element.data()}');
      }

      return list;
    } catch (e) {
      print('error occure while getting the data======>$e');
    }
  }

  getAllUsers(AppUser appUser) async {
    List<AppUser> list = [];
    print('getting all AppUsers ${appUser.id}');
    try {
      final snapshot = await _db
          .collection('app_user')
          .orderBy("uplift", descending: true)
          // .where(
          //   "id",
          //   isNotEqualTo: appUser.id,
          //   // whereNotIn: appUser.likedUsers,
          // )
          // .where("id", whereNotIn: appUser.disLikedUsers)
          .get();

      print('getting all AppUsers 2');
      for (var user in snapshot.docs) {
        print('id===>  ${user.id}');
        list.add(
          AppUser.fromJson(user.data(), user.id),
        );
        // print('users --> ${user.data().keys}');
      }
      return list;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUsers==>$e');
      debugPrint(s.toString());
      return [];
    }
  }

  getMatchedUsers(AppUser appUser) async {
    List<AppUser> list = [];
    print("likedUsers: ${appUser.likedUsers!.length}");
    try {
      final snapshot = appUser.likedUsers!.isEmpty
          ? await _db
              .collection('app_user')
              // .where("id", whereIn: appUser.likedUsers)
              .get()
          : await _db
              .collection('app_user')
              .where("id", whereIn: appUser.likedUsers)
              .get();
      for (var user in snapshot.docs) {
        list.add(
          AppUser.fromJson(user.data(), user.id),
        );
        // print('users --> ${user.data().keys}');
      }
      return list;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUsers==>$e');
      debugPrint(s.toString());
      return list;
    }
  }

  /// ========================================================== ///
  /// ==================== Chat Section ======================== ///
  /// ========================================================== ///

  // ///
  // /// add new message
  // ///
  // addNewUserMessage(
  //     Conversation messageFrom, Conversation messageTo, Message message) async {
  //   try {
  //     ///
  //     /// From User message
  //     ///
  //     await _db
  //         .collection("Conversations")
  //         .doc("${messageFrom.id}")
  //         .collection("Chats")
  //         .doc("${messageTo.id}")
  //         .collection("messages")
  //         .add(message.toJson());

  //     await _db
  //         .collection("Conversations")
  //         .doc("${messageFrom}")
  //         .collection("Chats")
  //         .doc("${messageTo.id}")
  //         .set(messageTo.toJson());

  //     ///
  //     /// to user message
  //     ///
  //     await _db
  //         .collection("Conversations")
  //         .doc("${messageTo.id}")
  //         .collection("Chats")
  //         .doc("${messageFrom.id}")
  //         .collection("messages")
  //         .add(message.toJson());

  //     await _db
  //         .collection("Conversations")
  //         .doc("${messageTo.id}")
  //         .collection("Chats")
  //         .doc("${messageFrom.id}")
  //         .set(messageFrom.toJson());
  //   } catch (e) {
  //     print('Exception@DatabaseServices/addNewMessage ==> $e');
  //   }
  // }

  // Stream<QuerySnapshot>? getRealTimeChat(
  //     String currentUserId, String toUserId) {
  //   print("Current User id ==> $currentUserId");
  //   print("to user id ==> $toUserId");
  //   try {
  //     Stream<QuerySnapshot> messageSnapshot = _db
  //         .collection("Conversations")
  //         .doc(currentUserId)
  //         .collection("Chats")
  //         .doc(toUserId)
  //         .collection("messages")
  //         .orderBy('sendAt', descending: true)
  //         .snapshots();
  //     return messageSnapshot;
  //   } catch (e) {
  //     print('Exception@GetUserMessagesStream=>$e');
  //     return null;
  //   }
  // }

  // Stream<QuerySnapshot>? getAllConverationList(String id) {
  //   try {
  //     Stream<QuerySnapshot> conversationSnapshot = _db
  //         .collection("Conversations")
  //         .doc(id)
  //         .collection('Chats')
  //         .orderBy("lastMessageAt", descending: true)
  //         .snapshots();
  //     return conversationSnapshot;
  //   } catch (e) {
  //     print("Exception@database/GetAllConversationList ==> $e");
  //     return null;
  //   }
  // }

  //  messageSeen(String fromUserId, String toUserId) async {
  //   try {
  //     await _db
  //         .collection("Conversations")
  //         .doc("${fromUserId}")
  //         .collection("Chats")
  //         .doc("${toUserId}")
  //         .update(
  //       {
  //         "isMessageSeen": true,
  //         "noOfUnReadMsgs": 0,
  //       },
  //     );
  //   } catch (e) {
  //     print("Exception@Datbase/MessageSeen==>$e");
  //   }
  // }

  // checkUnReadMsgs(String fromUserId, String toUserId) async {
  //   try {
  //     final snapshot = await _db
  //         .collection("Conversations")
  //         .doc(toUserId)
  //         .collection('Chats')
  //         .doc(fromUserId)
  //         .get();
  //     if (snapshot.exists) {
  //       return Conversation.fromJson(snapshot.data());
  //     } else {
  //       return Conversation();
  //     }
  //   } catch (e) {
  //     print("Exception@Database/checkUnReadMsgs ==> $e");
  //     return Conversation();
  //   }
  // }
  // updateClientFcm(token, id) async {
  //   await _db.collection("app_user").doc(id).update({'fcmToken': token}).then(
  //       (value) => debugPrint('fcm updated successfully'));
  // }

  /// ====================== Chat new algorithm ============================///
  ///
  ///
  /// add new message
  ///
  newMessages(Conversation conversationFrom, Conversation conversationTo,
      Message message, String currentUserId, String toUserId) async {
    try {
      ///
      /// Check previous conversation
      ///
      final snapshot = await _db
          .collection("Conversations")
          .doc("${currentUserId}")
          .collection("MyConversation")
          .doc("${toUserId}")
          .get();

      if (snapshot.exists) {
        Conversation createdConversation =
            Conversation.fromJson(snapshot.data());
        conversationFrom.conversationId = createdConversation.conversationId;
        await _db
            .collection("Conversations")
            .doc("${currentUserId}")
            .collection("MyConversation")
            .doc("${toUserId}")
            .update({
          "lastMessage": conversationFrom.lastMessage,
        });
      } else {
        ///
        /// my converstion list
        ///
        await _db
            .collection("Conversations")
            .doc("${currentUserId}")
            .collection("MyConversation")
            .doc("${toUserId}")
            .set(conversationFrom.toJson());
      }

      ///
      /// Check previous conversation
      ///
      final snap = await _db
          .collection("Conversations")
          .doc("${toUserId}")
          .collection("MyConversation")
          .doc("${currentUserId}")
          .get();

      if (snap.exists) {
        Conversation createdConversation = Conversation.fromJson(snap.data());
        conversationTo.conversationId = createdConversation.conversationId;
        await _db
            .collection("Conversations")
            .doc("${toUserId}")
            .collection("MyConversation")
            .doc("${currentUserId}")
            .update({
          "lastMessage": conversationTo.lastMessage,
        });
      } else {
        ///
        /// to user converstion list
        ///
        await _db
            .collection("Conversations")
            .doc("${toUserId}")
            .collection("MyConversation")
            .doc("${currentUserId}")
            .set(conversationTo.toJson());
      }

      ///
      /// Messages
      ///

      await _db
          .collection("messages")
          .doc("${conversationTo.conversationId}")
          .collection("realtime-messages")
          .add(message.toJson());
    } catch (e) {
      print('Exception@DatabaseServices/addNewMessage ==> $e');
    }
  }

  Stream<QuerySnapshot>? getAllConverationList(String id) {
    try {
      Stream<QuerySnapshot> conversationSnapshot = _db
          .collection("Conversations")
          .doc(id)
          .collection('MyConversation')
          .orderBy("lastMessageAt", descending: true)
          .snapshots();
      return conversationSnapshot;
    } catch (e) {
      print("Exception@database/GetAllConversationList ==> $e");
      return null;
    }
  }

  Stream<QuerySnapshot>? getRealTimeMessages(currentUserId) {
    try {
      Stream<QuerySnapshot> messageSnapshot = _db
          .collection("messages")
          .doc(currentUserId)
          .collection("realtime-messages")
          .orderBy('sendAt', descending: true)
          .snapshots();
      return messageSnapshot;
    } catch (e) {
      print('Exception@GetUserMessagesStream=>$e');
      return null;
    }
  }

  createGroup(Conversation conversation, Message message) async {
    try {
      await _db
          .collection("Conversations")
          .doc("${conversation.fromUserId}")
          .collection("MyConversation")
          .doc("${conversation.groupId}")
          .set(conversation.toJson());

      ///
      /// Messages
      ///

      await _db
          .collection("messages")
          .doc("${conversation.conversationId}")
          .collection("realtime-messages")
          .add(message.toJson());
      return true;
    } catch (e) {
      print('Exception@DatabaseServices/addNewMessage ==> $e');
      return false;
    }
  }

  updateGroup(Conversation conversation, Message message) async {
    // print("appuaser premiume check: ${appUser.isPremiumUser}");
    print('user id==> ${conversation.fromUserId}');
    print('group id==> ${conversation.groupId}');
    try {
      await _db
          .collection('Conversations')
          .doc(conversation.fromUserId)
          .collection("MyConversation")
          .doc("${conversation.groupId}")
          .update(conversation.toJson());

      ///
      /// Messages
      ///

      await _db
          .collection("messages")
          .doc("${conversation.conversationId}")
          .collection("realtime-messages")
          .add(message.toJson());
      return true;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/GroupUpdate ==>$e');
      debugPrint(s.toString());
      return false;
    }
  }

  //   getGroupMembers(String id) {
  //     List<String> members=[];
  //   try {
  //      _db
  //         .collection("Conversations")
  //         .doc(id)
  //         .collection('MyConversation')
  //         // .orderBy("lastMessageAt", descending: true)
  //         .snapshots();

  //     return ;
  //   } catch (e) {
  //     print("Exception@database/GetAllConversationList ==> $e");
  //     return null;
  //   }
  // }

  sendGroupMessage(Conversation conversation, Message message) async {
    try {
      await _db
          .collection("messages")
          .doc("${conversation.conversationId}")
          .collection("realtime-messages")
          .add(message.toJson());
      return true;
    } catch (e) {
      print('Exception@DatabaseServices/addNewMessage ==> $e');
      return false;
    }
  }

  /// ========================================================== ///
  /// ==================== Payment Section ======================== ///
  /// ========================================================== ///

  buySpanks(Spanks spanks) async {
    try {
      await _db.collection('Spanks').add(spanks.toJson()).then(
            (value) => debugPrint('Spanks Bought'),
          );
      return true;
    } catch (e) {
      print('Exception@DatabaseServices/buySpanks ==> $e');
      return false;
    }
  }

  upliftUser(UPlift uPlift) async {
    try {
      await _db
          .collection('Uplift')
          .doc(uPlift.userId)
          .set(uPlift.toJson())
          .then(
            (value) => debugPrint('User uplifted'),
          );
      return true;
    } catch (e) {
      print('Exception@DatabaseServices/upliftUser ==> $e');
      return false;
    }
  }

  checkPremiumExpire(AppUser appUser) async {
    try {
      final snapshot = await _db
          .collection('Payments')
          .doc(appUser.id)
          .collection('My Payments')
          .doc(appUser.paymentId)
          .get();
      return Subscription.fromJson(snapshot.data(), snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/checkPremiumExpire $e');
      debugPrint(s.toString());
      return Subscription();
    }
  }

  checkUpliftUser(AppUser user) async {
    try {
      final snapshot = await _db.collection('Uplift').doc(user.id).get();
      print("exist: ${snapshot.exists}");
      if (snapshot.exists) {
        return UPlift.fromJson(snapshot.data(), snapshot.id);
      } else {
        return UPlift();
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/checkUplift $e');
      debugPrint(s.toString());
      return UPlift();
    }
  }

  buySubscriptionPlan(Subscription subscription) async {
    try {
      String id = '';
      await _db
          .collection('Payments')
          .doc(subscription.userId)
          .collection('My Payments')
          .add(subscription.toJson())
          .then((value) {
        debugPrint(' Plan bought successfully>> id : ${value.id} ');
        id = value.id;
      });
      return id;
    } catch (e) {
      print('Exception@DatabaseServices/buySubscriptionPlan ==> $e');
      return null;
    }
  }
}
