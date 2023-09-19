import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/conversation_screen.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(32, 50, 32, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chat',
                    style: subHeadingTextWhite,
                  ),
                  GestureDetector(
                    child: Image.asset(
                      '$staticAsset/more.png',
                      scale: 3.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Matches',
                      style: subHeadingTextStyle2,
                    ),
                    Container(
                      height: 0.15.sh,
                      child: ListView.separated(
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            radius: 35.r,
                            backgroundImage: AssetImage(
                              '$dynamicAsset/profile.png',
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 15.w,
                        ),
                      ),
                    ),
                    Text(
                      'All',
                      style: subHeadingTextStyle2,
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.to(
                                ConversationScreen(),
                              );
                            },
                            leading: CircleAvatar(
                              radius: 35.r,
                              backgroundImage: AssetImage(
                                '$dynamicAsset/profile.png',
                              ),
                            ),
                            title: Text(
                              'Rose',
                              style: subHeadingTextStyle2,
                            ),
                            subtitle: Text(
                              'Lorem ipsum dolor sit amet consectet.',
                              style: subtitleText,
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  '04 : 30',
                                  style: miniText,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
