import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/screens/chatting_screen/chat_info/chat_info_screen.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/chatting/chatting_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ChattingScreen extends StatelessWidget {
  String toUserId;
  ChattingScreen({
    required this.toUserId,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChattingProvider(toUserId),
      child: Consumer<ChattingProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            backgroundColor: primaryColor,
            body: Stack(
              children: [
                ////
                /// App Bar
                ///
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 50, 32, 16),
                  child: CustomBackButton(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 72, 24, 16),
                  child: ListTile(
                    leading: model.toUser.images!.isEmpty
                        ? CircleAvatar(
                            radius: 35.r,
                            backgroundImage:
                                AssetImage('$dynamicAsset/person.png'),
                          )
                        : CircleAvatar(
                            radius: 35.r,
                            backgroundImage:
                                NetworkImage(model.toUser.images!.first),
                          ),
                    title: Text(
                      model.toUser.name!,
                      style: subHeadingTextStyle,
                    ),
                    subtitle: Text(
                      'online',
                      style: miniText.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.to(
                          ChatInfoScreen(),
                        );
                      },
                      child: Image.asset(
                        '$staticAsset/more.png',
                        scale: 3.5,
                      ),
                    ),
                  ),
                ),

                ////
                /// Chats
                ///
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Container(
                    height: 1.sh,
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 90),
                    decoration: BoxDecoration(
                      color: whiteColor,
                    ),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: model.messages.length,
                      itemBuilder: (context, index) {
                        return _chatMessage(model, index);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.h,
                      ),
                    ),
                  ),
                ),

                ///
                /// Text field
                ///
                _chatFeild(model, context),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.only(bottom: 80, left: 32, right: 32),
                //     child: Stack(
                //       children: [
                //         Container(
                //           height: 0.45.sh,
                //           decoration: BoxDecoration(
                //               color: greyColor2,
                //               image: DecorationImage(
                //                 image: AssetImage('$dynamicAsset/image.png'),
                //                 fit: BoxFit.cover,
                //               ),
                //               borderRadius: BorderRadius.circular(12.r)),
                //           width: 1.sw,
                //           alignment: Alignment.bottomCenter,
                //           child: ElevatedButton(
                //             onPressed: () {},
                //             child: Text('Pick Image'),
                //           ),
                //         ),
                //         // Align(
                //         //   alignment: Alignment.bottomCenter,
                //         //   child: ElevatedButton(
                //         //     onPressed: () {},
                //         //     child: Text('Pick Image'),
                //         //   ),
                //         // )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _chatMessage(ChattingProvider model, int index) {
    return Column(
      children: [
        Container(
          margin:
              model.messages[index].fromUserId == model.currentUser.appUser.id
                  ? EdgeInsets.only(
                      left: 100,
                    )
                  : EdgeInsets.only(
                      right: 100,
                    ),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color:
                model.messages[index].fromUserId == model.currentUser.appUser.id
                    ? primaryColor
                    : greyColor,
            borderRadius:
                model.messages[index].fromUserId == model.currentUser.appUser.id
                    ? BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              model.messages[index].textMessage!,
              style: subtitleText.copyWith(
                fontSize: 15.sp,
                color: model.messages[index].fromUserId ==
                        model.currentUser.appUser.id
                    ? whiteColor
                    : blackColor,
              ),
            ),
          ),
        ),
        sizeBox10,
        Row(
          mainAxisAlignment:
              model.messages[index].fromUserId == model.currentUser.appUser.id
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                onlyTime.format(model.messages[index].sendAt!),
                style: miniText.copyWith(
                  color: greyColor2,
                ),
              ),
            ),
            sizeBoxw10,
            // model.messages[index].isSender == false
            //     ? Image.asset(
            //         '$staticAsset/Check.png',
            //         scale: 3,
            //       )
            //     :
            Container(),
          ],
        )
      ],
    );
  }

  _chatFeild(ChattingProvider model, context) {
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
                scale: 3.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: TextFormField(
                style: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                controller: model.messageController,
                onChanged: (val) {
                  model.message.textMessage = val;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 35,
                      right: 83,
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
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 15, 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // showModalBottomSheet(
                      //     context: context,
                      //     useSafeArea: true,
                      //     isScrollControlled: true,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(
                      //         20.0,
                      //       ),
                      //     ),
                      //     builder: (context) {
                      //       return Consumer<ChattingProvider>(
                      //           builder: (context, model, child) {
                      //         return Container(
                      //           padding: EdgeInsets.only(
                      //             left: 25,
                      //             right: 25,
                      //             top: 100,
                      //             bottom: 30,
                      //           ),
                      //           child: Column(children: [
                      //             CustomButton(
                      //               title: 'Pick Image',
                      //               textColor: primaryColor,
                      //               color: pinkColor,
                      //               onTap: () {},
                      //             ),
                      //           ]),
                      //         );
                      //       });
                      //     });
                    },
                    child: Image.asset(
                      '$staticAsset/camera.png',
                      scale: 4,
                    ),
                  ),
                  sizeBoxw10,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      model.sendMessage();
                    },
                    child: Image.asset(
                      '$staticAsset/send.png',
                      scale: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
