import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/screens/chatting_screen/chat_info/chat_info_screen.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/chatting/chatting_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ChattingScreen extends StatelessWidget {
  String toUserId;
  Conversation conversation;
  ChattingScreen({
    required this.toUserId,
    required this.conversation,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChattingProvider(toUserId, conversation),
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
                    leading: CircleAvatar(
                      radius: 35.r,
                      backgroundImage: AssetImage('$dynamicAsset/person.png'),
                    ),
                    title: Text(
                      conversation.isGroupChat == true
                          ? model.conversation.name!
                          : model.toUser.name!,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.sh,
                          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
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
                      Container(
                        color: whiteColor,
                        width: 1.sw,
                        child: _chatFeild(model, context),
                      )
                    ],
                  ),
                ),

                ///
                /// Text field
                ///

                ///
                /// Send Image
                ///
                model.isSelect ? sendImageContainer(model) : Container(),
              ],
            ),
          ),
        );
      }),
    );
  }

  sendImageContainer(ChattingProvider model) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            bottom: 80,
            left: 32,
            right: 32,
            top: 0,
          ),
          child: Stack(
            children: [
              Container(
                height: 0.45.sh,
                decoration: BoxDecoration(
                    color: greyColor2,
                    image: model.image != null
                        ? DecorationImage(
                            image: FileImage(model.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12.r)),
                width: 1.sw,
                alignment: Alignment.bottomCenter,
                child: model.image == null
                    ? ElevatedButton(
                        onPressed: () {
                          model.pickImage();
                        },
                        child: Text('Pick Image'),
                      )
                    : Container(),
              ),
              model.image != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            model.image = null;

                            model.setState(ViewState.idle);
                          },
                          icon: Icon(
                            Icons.close,
                          ),
                          color: whiteColor,
                        ),
                      ),
                    )
                  : Container(),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Text('Pick Image'),
              //   ),
              // )
            ],
          ),
        ),
      ],
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
          padding: model.messages[index].type == 'image'
              ? EdgeInsets.all(3)
              : EdgeInsets.all(15),
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
          child: model.messages[index].type == 'text'
              ? Align(
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
                  ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                          image: NetworkImage(
                            model.messages[index].imageUrl!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    model.messages[index].textMessage!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
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
                          )
                        : Container(),
                  ],
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
                // validator: (val) {
                //   if (val!.isNotEmpty) {

                //     model.setState(ViewState.idle);
                //   }
                // },
                style: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                controller: model.messageController,
                onChanged: (val) {
                  model.message.textMessage = val;
                  model.setState(ViewState.idle);
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
                    onTap: () => model.selectImage(),
                    child: Image.asset(
                      '$staticAsset/camera.png',
                      scale: 4,
                    ),
                  ),
                  sizeBoxw10,
                  model.messageController.text.isNotEmpty || model.image != null
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            model.conversation.isGroupChat == true
                                ? model.sendGroupMessage()
                                : model.sendNewMessage();
                            // model.sendMessage();
                          },
                          child: Image.asset(
                            '$staticAsset/send.png',
                            scale: 4,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
