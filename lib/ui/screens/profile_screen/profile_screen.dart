import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/ui/custom_widgets/custom_profile_tile.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/profile_screen/About/about_screen.dart';
import 'package:hart/ui/screens/profile_screen/Notifications/notification_screen.dart';
import 'package:hart/ui/screens/profile_screen/app_setting/app_setting_screen.dart';
import 'package:hart/ui/screens/profile_screen/edit_profile/edit_profile_screen.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_screen.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';
import 'package:hart/ui/screens/profile_screen/pair_profile/pair_profile_screen.dart';
import 'package:hart/ui/screens/profile_screen/premium_setting/premium_screen.dart';
import 'package:hart/ui/screens/profile_screen/profile_provider.dart';
import 'package:hart/ui/screens/profile_screen/profile_view/profile_view_screen.dart';
import 'package:hart/ui/screens/profile_screen/uplift_screen/uplisft_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: greyColor,
                          image: model.currentUser.images == null
                              ? DecorationImage(
                                  image: AssetImage(
                                    '$dynamicAsset/image.png',
                                  ),
                                  fit: BoxFit.cover)
                              : model.currentUser.images!.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        model.currentUser.images!.first,
                                      ),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: AssetImage(
                                        '$dynamicAsset/image.png',
                                      ),
                                      fit: BoxFit.cover),
                          // borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              PageFromRight(page: ProfileViewScreen()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: greyColor,
                          ),
                          child: Icon(Icons.preview_outlined),
                        ),
                      ),
                    ],
                  ),
                  sizeBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.currentUser.nickName ?? 'User',
                        style: descriptionTextStyle,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(context,
                              PageFromRight(page: EditProfileScreen()));
                        },
                        child: Image.asset(
                          '$staticAsset/edit2.png',
                          scale: 3,
                        ),
                      ),
                    ],
                  ),
                  sizeBox10,
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      '${model.currentUser.age ?? ""} ${model.currentUser.lookingFor != null || model.currentUser.lookingFor!.isNotEmpty ? model.currentUser.lookingFor![0] : ""} ${model.currentUser.identity ?? ""}',
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
                    model.currentUser.isPremiumUser == true
                        ? 'Premium member'
                        : 'Basic member',
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
                      if (model.currentUser.isPremiumUser == true) {
                        Navigator.push(
                            context, PageFromRight(page: PremiumScreen()));
                      } else {
                        Navigator.push(
                            context, PageFromRight(page: MaestroScreen()));
                      }
                    },
                  ),
                  sizeBox10,
                  CustomProfileTile(
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: KingHartScreen()));
                    },
                    title: 'Spanks',
                    isSpank: true,
                    color: pinkColor,
                    textColor: primaryColor,
                    iconColor: primaryColor,
                    icon: 'Hand.png',
                    isWhite: false,
                  ),
                  sizeBox10,
                  CustomProfileTile(
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: UpliftScreen()));
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
                    isMaestro: true,
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: MaestroScreen()));
                    },
                    title: 'Become a Maestro',
                    color: pinkColor,
                    textColor: primaryColor,
                    iconColor: primaryColor,
                    isWhite: false,
                  ),
                  sizeBox20,
                  Divider(
                    color: greyColor2,
                  ),
                  CustomProfileTile(
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: PairProfileScreen()));
                    },
                    title: 'Pair Profile with my partner',
                    icon: 'pair.png',
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                  CustomProfileTile(
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: EditProfileScreen()));
                    },
                    title: 'Edit Profile',
                    icon: 'edit.png',
                  ),
                  // Divider(
                  //   color: greyColor2,
                  // ),
                  // CustomProfileTile(
                  //   onTap: () {},
                  //   title: 'Search Setting',
                  //   icon: 'searchpro.png',
                  // ),
                  Divider(
                    color: greyColor2,
                  ),
                  CustomProfileTile(
                    onTap: () {
                      // Get.to(
                      //   AppSettingsScreen(),
                      // );
                      Navigator.push(
                          context, PageFromRight(page: AppSettingsScreen()));
                    },
                    title: 'General Settings',
                    icon: 'setting.png',
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                  CustomProfileTile(
                    onTap: () {
                      model.shareLink();
                    },
                    title: 'Share My Profile',
                    icon: 'share.png',
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                  CustomProfileTile(
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: NotificationScreen()));
                    },
                    title: 'Notifications',
                    icon: 'notifications.png',
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                  sizeBox20,
                  Text(
                    'HART',
                    style: subHeadingTextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  sizeBox20,
                  Divider(
                    color: greyColor2,
                  ),
                  sizeBox10,
                  // CustomProfileTile(
                  //   onTap: () {
                  //     Get.to(
                  //       CommunityScreen(),
                  //     );
                  //   },
                  //   title: 'Our Community',
                  // ),
                  // Divider(
                  //   color: greyColor2,
                  // ),
                  CustomProfileTile(
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: AboutScreen()));
                    },
                    title: 'About',
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                  CustomProfileTile(
                    onTap: () {
                      model.launchAppUrl();
                    },
                    title: 'hart-app.com',
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                  // CustomProfileTile(
                  //   onTap: () {
                  //     Get.to(
                  //       HelpScreen(),
                  //     );
                  //   },
                  //   title: 'Help',
                  // ),
                  // Divider(
                  //   color: greyColor2,
                  // ),
                  CustomProfileTile(
                    onTap: () {
                      model.logout(context);
                    },
                    title: 'Logout',
                    textColor: redColor,
                    iconColor: redColor,
                  ),
                  Divider(
                    color: greyColor2,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
