import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hart/core/constants/style.dart';
import '../../core/models/onboarding.dart';

// import 'package:flutter_svg/flutter_svg.dart';

class CustomOnboardingCard extends StatelessWidget {
  final Onboarding? onboarding;
  CustomOnboardingCard({this.onboarding});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(flex: 10),
        Container(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 100,
          ),
          child: Text(
            onboarding!.title!,
            style: headingText,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.only(left: 30.w, right: 120),
          child: Text(
            onboarding!.description!,
            style: onboardinDescription,
            textAlign: TextAlign.start,
          ),
        ),
        Spacer(
          flex: 6,
        ),
      ],
    );
  }
}
