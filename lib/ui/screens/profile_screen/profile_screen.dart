import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/custom_profile_tile.dart';
import 'package:hart/ui/screens/profile_screen/About/about_screen.dart';
import 'package:hart/ui/screens/profile_screen/Help/help_screen.dart';
import 'package:hart/ui/screens/profile_screen/Notifications/notification_screen.dart';
import 'package:hart/ui/screens/profile_screen/app_setting/app_setting_screen.dart';
import 'package:hart/ui/screens/profile_screen/edit_profile/edit_profile_screen.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_screen.dart';
import 'package:hart/ui/screens/profile_screen/our_community/community_screen.dart';
import 'package:hart/ui/screens/profile_screen/pair_profile/pair_profile_screen.dart';
import 'package:hart/ui/screens/profile_screen/premium_setting/premium_screen.dart';
import 'package:hart/ui/screens/profile_screen/profile_provider.dart';
import 'package:hart/ui/screens/profile_screen/uplift_screen/uplisft_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
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
                        image: model.currentUser.images!.isEmpty
                            ? DecorationImage(
                                image: AssetImage(
                                  '$dynamicAsset/image.png',
                                ),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(
                                  model.currentUser.images!.first,
                                ),
                                fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    sizeBox20,
                    Text(
                      model.currentUser.name!,
                      style: descriptionTextStyle,
                    ),
                    sizeBox10,
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        '${model.currentUser.age} man ${model.currentUser.identity}',
                        style: buttonTextStyleGrey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        'Currently in ${model.country}',
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
                      onTap: () {
                        Get.to(
                          UpliftScreen(),
                        );
                      },
                      title: 'Uplift',
                      color: pinkColor,
                      textColor: primaryColor,
                      iconColor: primaryColor,
                      icon: 'uplift.png',
                      isWhite: false,
                    ),
                    sizeBox10,
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          PairProfileScreen(),
                        );
                      },
                      title: 'Pair Profile with my partner',
                      icon: 'pair.png',
                    ),
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          EditProfileScreen(),
                        );
                      },
                      title: 'Edit Profile',
                      icon: 'edit.png',
                    ),
                    CustomProfileTile(
                      onTap: () {},
                      title: 'Search Setting',
                      icon: 'searchpro.png',
                    ),
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          AppSettingsScreen(),
                        );
                      },
                      title: 'App Setting',
                      icon: 'setting.png',
                    ),
                    CustomProfileTile(
                      onTap: () {},
                      title: 'Share My Profile',
                      icon: 'share.png',
                    ),
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          NotificationScreen(),
                        );
                      },
                      title: 'Notifications',
                      icon: 'notifications.png',
                    ),
                    Text(
                      'HART',
                      style: subHeadingTextStyle.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    sizeBox10,
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          CommunityScreen(),
                        );
                      },
                      title: 'Our Community',
                    ),
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          AboutScreen(),
                        );
                      },
                      title: 'About',
                    ),
                    CustomProfileTile(
                      onTap: () {
                        Get.to(
                          HelpScreen(),
                        );
                      },
                      title: 'Help',
                    ),
                    CustomProfileTile(
                      onTap: () {
                        model.logout();
                      },
                      title: 'Logout',
                      textColor: redColor,
                      iconColor: redColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
