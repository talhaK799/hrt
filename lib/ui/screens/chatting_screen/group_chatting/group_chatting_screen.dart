import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_chatting_provider.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_info_screens/group_details/group_detail_screen.dart';
import 'package:provider/provider.dart';

class GroupChattingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupChattingProvider(),
      child: Consumer<GroupChattingProvider>(builder: (context, model, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(32, 50, 32, 16),
                child: CustomBackButton(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 72, 24, 16),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      GroupDetailScreen(),
                    );
                  },
                  title: Text(
                    'Group',
                    style: subHeadingTextStyle,
                  ),
                  subtitle: Text(
                    'Laiba, Andreo, Micheal ...',
                    style: miniText.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      '$staticAsset/more.png',
                      scale: 3.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  color: whiteColor,
                  child: SizedBox(
                    width: 1.sw,
                    height: 1.sh,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 150),
              //   child: Container(
              //     height: 1.sh,
              //     padding: EdgeInsets.fromLTRB(24, 24, 24, 90),
              //     decoration: BoxDecoration(
              //       color: whiteColor,
              //     ),
              //     child: ListView.separated(
              //       shrinkWrap: true,
              //       reverse: true,
              //       itemCount: model.messages.length,
              //       itemBuilder: (context, index) {
              //         return Column(
              //           children: [
              //             Container(
              //               margin: model.messages[index].isSender == true
              //                   ? EdgeInsets.only(
              //                       right: 100,
              //                     )
              //                   : EdgeInsets.only(
              //                       left: 100,
              //                     ),
              //               padding: EdgeInsets.all(15),
              //               decoration: BoxDecoration(
              //                   color: model.messages[index].isSender!
              //                       ? greyColor
              //                       : primaryColor,
              //                   borderRadius: BorderRadius.circular(12.r)),
              //               child: Align(
              //                 alignment: model.messages[index].isSender == true
              //                     ? Alignment.topRight
              //                     : Alignment.topLeft,
              //                 child: Text(
              //                   model.messages[index].text!,
              //                   style: subtitleText.copyWith(
              //                     fontSize: 12.sp,
              //                     color: model.messages[index].isSender!
              //                         ? blackColor
              //                         : whiteColor,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             sizeBox10,
              //             Row(
              //               mainAxisAlignment:
              //                   model.messages[index].isSender == true
              //                       ? MainAxisAlignment.start
              //                       : MainAxisAlignment.end,
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 40),
              //                   child: Text(
              //                     '12 : 49',
              //                     style: miniText.copyWith(
              //                       color: greyColor2,
              //                     ),
              //                   ),
              //                 ),
              //                 sizeBoxw10,
              //                 model.messages[index].isSender == false
              //                     ? Image.asset(
              //                         '$staticAsset/Check.png',
              //                         scale: 3,
              //                       )
              //                     : Container(),
              //               ],
              //             )
              //           ],
              //         );
              //       },
              //       separatorBuilder: (context, index) => SizedBox(
              //         height: 15.h,
              //       ),
              //     ),
              //   ),
              // ),

              ///
              /// Text field
              ///
              _chatFeild(),
            ],
          ),
        );
      }),
    );
  }

  _chatFeild() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 1.sw,
              height: 65.h,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: greyColor,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(32.r),
                  border: Border.all(color: whiteColor3)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                '$staticAsset/voice.png',
                scale: 3,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 15, 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    '$staticAsset/camera.png',
                    scale: 3.5,
                  ),
                  sizeBoxw10,
                  Image.asset(
                    '$staticAsset/send.png',
                    scale: 3.5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: TextFormField(
                style: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 45,
                      right: 80,
                    ),
                    hintText: 'Type Something',
                    hintStyle: subHeadingTextStyle.copyWith(
                      color: greyColor2,
                    ),
                    // suffixIcon: Row(
                    //   children: [
                    //     Image.asset(
                    //       '$staticAsset/camera.png',
                    //       scale: 3,
                    //     ),
                    //     Image.asset(
                    //       '$staticAsset/send.png',
                    //       scale: 3,
                    //     ),
                    //   ],
                    // ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
