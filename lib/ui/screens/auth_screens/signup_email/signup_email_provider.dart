// import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/view_models/base_view_model.dart';

class SignUpwithEmailProvider extends BaseViewModel {
  // bool isSelected = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // GeneratePassword _genPs = GeneratePassword();
  final formKey = GlobalKey<FormState>();
  // HiveService hive = HiveService();
  bool isVisible = false;
  bool isConfirVisibe = false;
  AppUser appuser = AppUser();
  bool isSystem = true;
  bool isSelf = false;
  String? type;
  double passwordLength = 8.0;
  bool? upperCase = false, loweCase = false, number = false, symbol = false;
  String email = "";
  String otp = "";

  

  

  

  toggleVisibilty() {
    isVisible = !isVisible;
    notifyListeners();
  }

  toggleConfirmVisibilty() {
    isConfirVisibe = !isConfirVisibe;
    notifyListeners();
  }

  system() {
    isSystem = true;
    isSelf = false;
    notifyListeners();
  }

  self() {
    isSystem = false;
    isSelf = true;
    notifyListeners();
  }



  

  

  changeSlider(val) {
    passwordLength = val;
    notifyListeners();
  }

  selectRadio(val) {
    type = val;
    notifyListeners();
  }
}