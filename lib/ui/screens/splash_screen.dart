import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/screens/auth_screens/auth_screens.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  init() async {
    // await Future
    // Get.offAll(RootScreen());
  }

  @override
  void initState() {
    // init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: GestureDetector(
          onTap: () => Get.offAll(AuthScreen()),
          child: Stack(
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
                padding: EdgeInsets.only(top: 0.4.sh),
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
      ),
    );
  }
}
