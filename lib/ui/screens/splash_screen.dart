import 'package:flutter/material.dart';
import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/dynamic_link_handler.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/auth_screens/auth_screens.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/phone_login_screen.dart';
import 'dart:async';

import 'package:hart/ui/screens/root_screen/root_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = locator<AuthService>();
  String _id = '';
  final link = locator<DynamicLinkHandler>();
  final _location = locator<LocationService>();
  init() async {
    // printKeyHash();

    await Future.delayed(Duration(seconds: 2));

    _id = await link.initDeepLinks() ?? 'no user';
    print('sharing id $_id');
    // Position position = await _location.determinePosition();
    // print(
    //     'this is the current location ${_location.currentLocation!.latitude} === ${_location.currentLocation!.longitude}');

    // Get.to(
    //   AuthScreen(),
    // );

    if (_auth.isLogin) {
      // if (_auth.appUser.isEmailVerified == false) {
      //   Get.offAll(EmailVerificationScreen());
      // } else
      if (_auth.appUser.isPhoneNoVerified == false) {
        Get.offAll(
          PhoneLoginScreen(),
        );
      } else {
        Get.offAll(RootScreen());
      }
    } else {
      Get.offAll(AuthScreen());
    }
  }

  // void printKeyHash() async {
  //   String? key = await FlutterFacebookKeyhash.getFaceBookKeyHash ??
  //       'Unknown platform version';
  //   print('key hash ===> $key');
  // }

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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 1,
                  child: SvgPicture.asset(
                    '$staticAsset/Elipse.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    child: Image.asset("$staticAsset/splashLogo.png"),
                  ),
                  sizeBox30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'Welcome! It’s time to have fun!',
                      textAlign: TextAlign.center,
                      style: headingText,
                    ),
                  ),
                  sizeBox30,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Find your connection with Hart\nShare some useful information to ensure\nyou never match with aloof members.',
                      textAlign: TextAlign.center,
                      style: descriptionTextStyle.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
