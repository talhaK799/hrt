import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/chatting_screen/chatting_provider.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/conversation_screen.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_chatting_screen.dart';
import 'package:provider/provider.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChattingProvider(),
      child: Consumer<ChattingProvider>(builder: (context, model, child) {
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

                        ///
                        /// Online Users List
                        ///
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
                        sizeBox20,
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return model.chats[index].isGroup == true

                                  ///
                                  ///Groups
                                  ///
                                  ? Slidable(
                                      endActionPane: ActionPane(
                                        extentRatio: 0.2,
                                        motion: BehindMotion(),
                                        children: [
                                          SlidableAction(
                                            backgroundColor: pinkColor,
                                            autoClose: true,
                                            icon: Icons.person,
                                            onPressed: (context) {},
                                          ),
                                          SlidableAction(
                                            backgroundColor: pinkColor,
                                            autoClose: true,
                                            icon: Icons.close_sharp,
                                            onPressed: (context) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25,
                                                              vertical: 40),
                                                      child: Column(children: [
                                                        Text(
                                                          'Are you sure you want to leave this group XYZ',
                                                          style: bodyTextStyle,
                                                        ),
                                                        sizeBox20,
                                                        Text(
                                                          'A member of the group should add you backagain if you change your mind',
                                                          style: buttonTextStyle
                                                              .copyWith(
                                                            color: greyColor,
                                                          ),
                                                        ),
                                                        sizeBox20,
                                                        CustomButton(
                                                          title: 'LEAVE',
                                                          onTap: () {},
                                                        ),
                                                        sizeBox20,
                                                        CustomButton(
                                                          title: 'Back',
                                                          textColor:
                                                              primaryColor,
                                                          color: pinkColor,
                                                          onTap: () {},
                                                        ),
                                                      ]),
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                      dragStartBehavior:
                                          DragStartBehavior.start,
                                      child: _normalChat(
                                        model,
                                        index,
                                        () => Get.to(
                                          GroupChattingScreen(),
                                        ),
                                      ),
                                    )

                                  ///
                                  /// Normal Chats
                                  ///
                                  : _normalChat(
                                      model,
                                      index,
                                      () => Get.to(
                                        ConversationScreen(),
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
      }),
    );
  }

  _normalChat(ChattingProvider model, int index, onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      //  () {
      //   model.chats[index].isGroup == true
      //       ? Get.to(
      //           GroupChattingScreen(),
      //         )
      //       : Get.to(
      //           ConversationScreen(),
      //         );
      // },
      leading: CircleAvatar(
        radius: 35.r,
        backgroundImage: AssetImage(
          '$dynamicAsset/profile.png',
        ),
      ),
      title: Text(
        model.chats[index].name!,
        style: subHeadingTextStyle2,
      ),
      subtitle: Text(
        model.chats[index].desscription!,
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
  }
}
