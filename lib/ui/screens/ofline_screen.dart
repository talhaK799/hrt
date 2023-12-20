import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:lottie/lottie.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.transparent,
              child: Lottie.asset(
                'assets/animations/red_10sec.json',
                repeat: true,
                frameRate: FrameRate.max,
              ),
            ),
          ),
          // Icon(
          //   Icons.wifi_off_sharp,
          //   color: primaryColor,
          //   size: 60,
          // ),
          sizeBox30,
          Text(
            'Something Went Wrong',
            style: headingText.copyWith(
              color: blackColor,
            ),
          ),
          sizeBox20,
          Text(
            'We are having issues loading this page',
            style: buttonTextStyle.copyWith(
              color: blackColor,
            ),
          ),
          sizeBox30,
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: blackColor,
                  ),
                ),
                child: Text(
                  'Connect to stable internet',
                  style: subHeadingText1.copyWith(
                    color: blackColor,
                    fontSize: 16.sp,
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
