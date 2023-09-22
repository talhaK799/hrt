import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_profile_tile.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_screen.dart';
import 'package:hart/ui/screens/profile_screen/premium_setting/premium_screen.dart';

import '../../../core/constants/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            60,
            24,
            40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        '$dynamicAsset/image.png',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              sizeBox20,
              Text(
                'Andreo',
                style: descriptionTextStyle,
              ),
              sizeBox10,
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Text(
                  '23 man straight',
                  style: buttonTextStyleGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Text(
                  'Currently in Spain',
                  style: buttonTextStyleGrey,
                ),
              ),
              Text(
                'Basic member',
                style: buttonTextStyleGrey,
              ),
              sizeBox30,
              CustomProfileTile(
                title: 'Premium Settings',
                textColor: whiteColor,
                color: primaryColor,
                iconColor: whiteColor,
                icon: 'premium.png',
                isWhite: false,
                onTap: () {
                  Get.to(
                    PremiumScreen(),
                  );
                },
              ),
              CustomProfileTile(
                onTap: () {
                  Get.to(
                    KingHartScreen(),
                  );
                },
                title: 'Spanks',
                color: pinkColor,
                textColor: primaryColor,
                iconColor: primaryColor,
                icon: 'kings.png',
                isWhite: false,
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'Uplift',
                color: pinkColor,
                textColor: primaryColor,
                iconColor: primaryColor,
                icon: 'kings.png',
                isWhite: false,
              ),
              sizeBox10,
              CustomProfileTile(
                onTap: () {},
                title: 'Pair Profile with my partner',
                icon: 'edit.png',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'Edit Profile',
                icon: 'edit.png',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'Search Setting',
                icon: 'edit.png',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'App Setting',
                icon: 'edit.png',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'Share My Profile',
                icon: 'edit.png',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'Notifications',
                icon: 'edit.png',
              ),
              Text(
                'HART',
                style: subHeadingTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
              sizeBox10,
              CustomProfileTile(
                onTap: () {},
                title: 'Our Community',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'About',
              ),
              CustomProfileTile(
                onTap: () {},
                title: 'Notifications',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
