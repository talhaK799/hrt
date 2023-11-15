import 'package:hart/core/models/app_user.dart';

class CustomAuthResult {
  bool? status;
  String? errorMessage;
  var user;
  AppUser? appuser;

  CustomAuthResult({this.status, this.errorMessage, this.user});
}
