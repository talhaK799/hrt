import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';

import 'profile_screen/profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  init() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(
      () =>
          // RootScreen()
          // OnboardingScreen(),
          ProfileScreen(),
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                child: Image.asset(
                  '$staticAsset/Splash Screen.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }
}
