import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/models/likedUser.dart';

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

  likeUser(LikedUser user) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('Likes')
          .doc(user.id)
          .set(user.toJson())
          .then((value) => debugPrint('user Liked successfully'));
      return true;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/likeUser');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Get User from database using this funciton
  getAppUser(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('app_user').doc(id).get();
      debugPrint('Client Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data()!, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  updateUserProfile(AppUser appUser) async {
    // print("appuaser premiume check: ${appUser.isPremiumUser}");
    try {
      await _db.collection('app_user').doc(appUser.id).update(appUser.toJson());
      return true;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAppUser ==>$e');
      debugPrint(s.toString());
      return false;
    }
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

  getAllUsers() async {
    List<AppUser> list = [];
    try {
      final snapshot = await _db.collection('app_user').get();
      for (var user in snapshot.docs) {
        list.add(
          AppUser.fromJson(user.data(), user.id),
        );
        // print('users --> ${user.data().keys}');
      }
      return list;
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUsers');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  // updateClientFcm(token, id) async {
  //   await _db.collection("app_user").doc(id).update({'fcmToken': token}).then(
  //       (value) => debugPrint('fcm updated successfully'));
  // }
}
