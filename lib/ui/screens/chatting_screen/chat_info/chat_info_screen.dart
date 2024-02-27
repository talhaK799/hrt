import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';

import 'package:hart/ui/screens/chatting_screen/create_group/create_group_screen.dart';
import 'package:provider/provider.dart';

import 'chat_info_provider.dart';

class ChatInfoScreen extends StatelessWidget {
  AppUser user;
  Conversation conversation;
  ChatInfoScreen({
    required this.user,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatInfoProvider(conversation),
      child: Consumer<ChatInfoProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: user.name,
                  ),
                  sizeBox30,
                  GestureDetector(
                    onTap: () {
                      // Get.to(
                      //   CreateGroupScreen(),
                      // );
                      Navigator.push(
                        context,
                        PageFromRight(
                          page: CreateGroupScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create Group Chat',
                          style: bodyTextStyle,
                        ),
                        Image.asset(
                          '$staticAsset/arrow.png',
                          scale: 3,
                        ),
                      ],
                    ),
                  ),
                  sizeBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mute Notification',
                        style: bodyTextStyle,
                      ),
                      Switch(
                        activeColor: primaryColor,
                        value: model.isMute,
                        thumbColor: MaterialStatePropertyAll(whiteColor),
                        inactiveTrackColor: greyColor,
                        onChanged: (val) {
                          model.changeMute(val);
                        },
                      ),
                    ],
                  ),
                  // sizeBox20,
                  // Text(
                  //   'Disconnect',
                  //   style: bodyTextStyle.copyWith(
                  //     color: primaryColor,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // sizeBox30,
                  // sizeBox10,
                  // Text(
                  //   'Members',
                  //   style: buttonTextStyle.copyWith(
                  //     color: greyColor2,
                  //   ),
                  // ),
                  // sizeBox20,
                  // ListView.separated(
                  //   primary: false,
                  //   padding: EdgeInsets.all(0),
                  //   shrinkWrap: true,
                  //   itemCount: 2,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       onTap: () {},
                  //       leading: CircleAvatar(
                  //         radius: 35.r,
                  //         backgroundImage: AssetImage(
                  //           '$dynamicAsset/profile.png',
                  //         ),
                  //       ),
                  //       title: Text(
                  //         'Rose',
                  //         style: subHeadingTextStyle2,
                  //       ),
                  //       subtitle: Text(
                  //         'Lorem ipsum dolor sit amet consectet.',
                  //         style: subtitleText,
                  //       ),
                  //       trailing: Image.asset(
                  //         '$staticAsset/arrow.png',
                  //         scale: 3,
                  //       ),
                  //     );
                  //   },
                  //   separatorBuilder: (context, index) => SizedBox(
                  //     height: 15.h,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
