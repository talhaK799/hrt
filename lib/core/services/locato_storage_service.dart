import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  /// 3

  ///
  /// List of const keys
  ///
  static const String onboardingCountKey = 'onBoardingCount';
  static const String notificationsCountKey = 'notificationsCount';
  static const String users = 'users';
  static const String matches = 'matches';
  static const String chats = 'chats';

  ///
  /// Setters and getters
  ///
  int get onBoardingPageCount => _getFromDisk(onboardingCountKey) ?? 0;
  set setOnBoardingPageCount(int count) =>
      _saveToDisk(onboardingCountKey, count);

  int get setNotificationsCount => _getFromDisk(notificationsCountKey) ?? 0;
  set setNotificationsCount(int count) =>
      _saveToDisk(notificationsCountKey, count);

  ///
  /// number of Users
  ///
  int get getdataLength => _getFromDisk(users) ?? 0;
  set setdataLength(int count) => _saveToDisk(users, count);

  ///
  /// number of Requests
  ///

  int get getmatches => _getFromDisk(users) ?? 0;
  set setmatches(int count) => _saveToDisk(users, count);

  ///
  /// number of chattingUsers
  ///

  int get getChats => _getFromDisk(chats) ?? 0;
  set setChats(int count) => _saveToDisk(chats, count);

  ///
  ///initializing instance
  ///
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  updateSelectedLanguage(String langCode) async {
    await init();
    await _preferences!.setString('lang_code', langCode);
  }

  getSelectedLanguage() async {
    await init();
    return _preferences!.getString("lang_code") ?? 'en';
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    debugPrint(
        '(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    debugPrint(
        '(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
    if (content == null) {
      _preferences!.remove(key);
    }
  }

  // static Future<LocalStorageService> getInstance() async {
  //   if (_instance == null) {
  //     _instance = LocalStorageService();
  //   }
  //   if (_preferences == null) {
  //     _preferences = await SharedPreferences.getInstance();
  //   }
  //   return _instance!;
  // }
}
