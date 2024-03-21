import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/chatting/chatting_provider.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_info_screens/group_details/group_detail_screen.dart';
import 'package:hart/ui/screens/chatting_screen/user_details/user_detail_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../chat_info/chat_info_screen.dart';

class ChattingScreen extends StatefulWidget {
  final String toUserId;
  final Conversation conversation;
  ChattingScreen({
    required this.toUserId,
    required this.conversation,
  });

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    // Provider.of<ChattingProvider>(context, listen: false).disposestream();
    super.dispose();
  }

  void _init() async {
    // print(
    // "conversations list ====> ${widget.conversation.leftedUsers!.length}");
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ChattingProvider(widget.toUserId, widget.conversation),
      child: Consumer<ChattingProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: PopScope(
            canPop: true,
            onPopInvoked: (didPop) {
              model.disposestream();
              // Get.back();
            },
            child: Scaffold(
              backgroundColor: primaryColor,
              body: Stack(
                children: [
                  ////
                  /// App Bar
                  ///
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(32, 50, 32, 16),
                  //   child: CustomBackButton(),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 42, 14, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if(model.state==ViewState.idle){
                              model.disposestream();
                            Get.back();
                            }
                            
                          },
                          child: Image.asset(
                            '$staticAsset/Back.png',
                            scale: 2.8,
                          ),
                        ),
                        // CustomBackButton(
                        //   data: model.toUser.isFirstTimeChat,
                        // ),
                        Expanded(
                          child: ListTile(
                            leading: model.conversation.isGroupChat == true
                                ? CircleAvatar(
                                    radius: 35.r,
                                    backgroundImage:
                                        AssetImage('$staticAsset/person.png'),
                                  )
                                : model.toUser.images != null
                                    ? GestureDetector(
                                        onTap: () {
                                          // Get.to(UserDetailScreen(
                                          //   user: model.toUser,
                                          // ));
                                          Navigator.push(
                                            context,
                                            PageFromRight(
                                              page: UserDetailScreen(
                                                user: model.toUser,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 35.r,
                                          backgroundImage: NetworkImage(
                                            '${model.toUser.images!.first}',
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        child: CircleAvatar(
                                          radius: 35.r,
                                          backgroundImage: AssetImage(
                                              '$staticAsset/person.png'),
                                        ),
                                      ),
                            title: Text(
                              widget.conversation.isGroupChat == true
                                  ? "${model.conversation.name}"
                                  : "${model.toUser.name}",
                              style: subHeadingTextStyle,
                            ),
                            // subtitle: Text(
                            //   'online',
                            //   style: miniText.copyWith(
                            //     color: whiteColor,
                            //   ),
                            // ),
                            trailing: widget.conversation.leftedUsers!
                                    .contains(model.currentUser.appUser.id)
                                ? null
                                : GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      model.conversation.isGroupChat == true
                                          ?
                                          // Get.to(
                                          //     GroupDetailScreen(
                                          //       group: model.conversation,
                                          //     ),
                                          //   )

                                          Navigator.push(
                                              context,
                                              PageFromRight(
                                                page: GroupDetailScreen(
                                                  group: model.conversation,
                                                ),
                                              ),
                                            )
                                          : Navigator.push(
                                              context,
                                              PageFromRight(
                                                page: ChatInfoScreen(
                                                  user: model.toUser,
                                                  conversation:
                                                      model.conversation,
                                                ),
                                              ),
                                            );
                                      //  Get.to(
                                      //   ChatInfoScreen(
                                      //     user: model.toUser,
                                      //     conversation: model.conversation,
                                      //   ),
                                      // );
                                    },
                                    child: Image.asset(
                                      '$staticAsset/more.png',
                                      scale: 3.5,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ////
                  /// Chats
                  ///
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.sh,
                            padding: EdgeInsets.fromLTRB(24, 0, 14, 0),
                            decoration: BoxDecoration(
                              color: whiteColor,
                            ),
                            child: model.state == ViewState.idle
                                ? ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: model.messages.length,
                                    itemBuilder: (context, index) {
                                      return model.messages[index].type ==
                                              "text"
                                          ? TextMessageCard(
                                              message: model.messages[index],
                                              user: model.currentUser.appUser,
                                              conversaion: model.conversation,
                                            )
                                          : model.messages[index].type ==
                                                      "added" ||
                                                  model.messages[index].type ==
                                                      "created"
                                              ? JoinORLeaveGroup(
                                                  message: model
                                                              .currentUser
                                                              .appUser
                                                              .isGroupAdmin ==
                                                          true
                                                      ? "Group Created"
                                                      : "You were Added",
                                                )
                                              : model.messages[index].type ==
                                                      "image"
                                                  ? ImageMessageCard(
                                                      message:
                                                          model.messages[index],
                                                      appUser: model
                                                          .currentUser.appUser,
                                                      conversaion:
                                                          model.conversation,
                                                    )
                                                  : Container();
                                      // return _chatMessage(model, index);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 15.h,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'No messages',
                                      style: subHeadingText1,
                                    ),
                                  ),
                          ),
                        ),
                        widget.conversation.isGroupChat == true
                            ? widget.conversation.leftedUsers!
                                    .contains(model.currentUser.appUser.id)
                                // ||
                                // model.currentUser.appUser.blockedUsers!
                                //     .contains(widget.conversation.toUserId)
                                // ||
                                // model.conversation.appUser!.blockedUsers!.contains(model.currentUser.appUser.id)
                                ? Container(
                                    padding: EdgeInsets.all(30),
                                    alignment: Alignment.center,
                                    width: 1.sw,
                                    color: whiteColor,
                                    child: Text(
                                      'you cannot chat any more',
                                      style: bodyTextStyle.copyWith(
                                          color: primaryColor),
                                    ),
                                  )
                                : Container(
                                    color: whiteColor,
                                    width: 1.sw,
                                    child: _chatFeild(model, context),
                                  )

                            : model.currentUser.appUser.blockedUsers
                                        .contains(model.toUser.id) ||
                                    model.toUser.blockedUsers

                                        .contains(model.currentUser.appUser.id)
                                ? Container(
                                    padding: EdgeInsets.all(30),
                                    alignment: Alignment.center,
                                    width: 1.sw,
                                    color: whiteColor,
                                    child: Text(
                                      model.currentUser.appUser.blockedUsers
                                              .contains(
                                                  widget.conversation.toUserId)
                                          ? "the conversation has been blocked "
                                          : 'you cannot chat any more',
                                      style: bodyTextStyle.copyWith(
                                          color: primaryColor),
                                    ),
                                  )
                                : Container(
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
                  model.message.file != null
                      ? sendImageContainer(model)
                      : Container(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  imagePickingBottomSheet(context, ChattingProvider model) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      CustomButton(
                        title: 'Gallery',
                        onTap: () {
                          Get.back();
                          model.pickImage();
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        title: 'Camera',
                        onTap: () {
                          Get.back();
                          model.pickImageFromGallery();
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  sendImageContainer(ChattingProvider model) {
    return model.isShowImagePreview == false
        ? Container()
        : Column(
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
                          image: model.message.file != null
                              ? DecorationImage(
                                  image: FileImage(model.message.file!),
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
                    model.message.file != null
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
                                  model.removeImage();
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
                  ],
                ),
              ),
            ],
          );
  }

  _chatFeild(ChattingProvider model, context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: Platform.isAndroid
            ? EdgeInsets.symmetric(horizontal: 20)
            : EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 15,
              ),
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
            // Container(
            //   padding: EdgeInsets.fromLTRB(30, 20, 0, 30),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //   ),
            //   child: Image.asset(
            //     '$staticAsset/voice.png',
            //     scale: 3.5,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 10),
              child: TextFormField(
                // validator: (val) {
                //   if (val!.isNotEmpty) {

                //     model.setState(ViewState.idle);
                //   }
                // },
                style: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (val) {
                  model.messageController.text.isNotEmpty || model.image != null
                      ? model.conversation.isGroupChat == true
                          ? model.sendGroupMessage()
                          : model.sendNewMessage()
                      : null;
                },
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
                    // onTap: () => model.selectImage(),
                    onTap: () {
                      imagePickingBottomSheet(context, model);
                    },
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

class ImageMessageCard extends StatelessWidget {
  final Message message;
  final AppUser appUser;
  final Conversation conversaion;
  ImageMessageCard({
    required this.message,
    required this.appUser,
    required this.conversaion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: message.fromUserId == appUser.id
              ? EdgeInsets.only(
                  left: 100,
                )
              : EdgeInsets.only(
                  right: 100,
                ),
          padding:
              message.type == 'image' ? EdgeInsets.all(3) : EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: message.fromUserId == appUser.id ? primaryColor : greyColor,
            borderRadius: message.fromUserId == appUser.id
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
          child: message.type == 'text'
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    message.textMessage!,
                    style: subtitleText.copyWith(
                      fontSize: 15.sp,
                      color: message.fromUserId == appUser.id
                          ? whiteColor
                          : blackColor,
                    ),
                  ))
              : Container(
                  height: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 200,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          // image: message.file != null
                          //     ? DecorationImage(
                          //         image: FileImage(
                          //           message.file!,
                          //         ),
                          //         fit: BoxFit.cover,
                          //       )
                          //     : DecorationImage(
                          //         image: NetworkImage(
                          //           message.imageUrl!,

                          //         ),
                          //         fit: BoxFit.cover,
                          //       ),
                        ),
                        child: message.file != null
                            ? Image.file(
                                message.file!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                message.imageUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Return the image widget if it's fully loaded.
                                  }
                                  return Container(
                                    height: 0.35.sh,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Center(
                                      // Display a linear progress indicator until the image is fully loaded.
                                      child: CircularProgressIndicator(
                                        color: message.fromUserId == appUser.id
                                            ? whiteColor
                                            : primaryColor,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      message.textMessage != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                message.textMessage!,
                                style: subtitleText.copyWith(
                                  fontSize: 15.sp,
                                  color: message.fromUserId == appUser.id
                                      ? whiteColor
                                      : blackColor,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
        ),
        sizeBox10,
        Row(
          mainAxisAlignment: message.fromUserId == appUser.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                onlyTime.format(message.sendat ?? DateTime.now()),
                style: miniText.copyWith(
                  color: greyColor2,
                ),
              ),
            ),
            sizeBoxw10,
            15.horizontalSpace,
            conversaion.isGroupChat == true
                ? message.fromUserId == appUser.id
                    ? conversaion.joinedUsers!.length ==
                            message.readingMemebers!.length
                        ? Image.asset(
                            "$staticAsset/Check.png",
                            scale: 3.5,
                          )
                        : Image.asset(
                            "$staticAsset/Check2.png",
                            scale: 3.5,
                          )
                    : Container()
                : message.fromUserId == appUser.id
                    ? message.isReaded == true
                        ? Image.asset(
                            "$staticAsset/Check.png",
                            scale: 3.5,
                          )
                        : Image.asset(
                            "$staticAsset/Check2.png",
                            scale: 3.5,
                          )
                    : Container()
          ],
        )
      ],
    );
  }
}

class TextMessageCard extends StatelessWidget {
  final Message message;
  final AppUser user;
  final Conversation conversaion;
  TextMessageCard({
    required this.message,
    required this.user,
    required this.conversaion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Align(
        alignment: (message.fromUserId != user.id
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Column(
          crossAxisAlignment: message.fromUserId != user.id
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: message.fromUserId == user.id ? primaryColor : greyColor,
                borderRadius: message.fromUserId == user.id
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
              child: Text(
                message.textMessage ?? "",
                style: subtitleText.copyWith(
                  fontSize: 15.sp,
                  color:
                      message.fromUserId == user.id ? whiteColor : blackColor,
                ),
              ),
            ),
            // sizeBox10,
            Row(
              mainAxisAlignment: message.fromUserId == user.id
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  onlyTime.format(message.sendat ?? DateTime.now()),
                  style: miniText.copyWith(
                    color: greyColor2,
                  ),
                ),
                15.horizontalSpace,
                conversaion.isGroupChat == true
                    ? message.fromUserId == user.id
                        ? conversaion.joinedUsers!.length ==
                                message.readingMemebers!.length
                            ? Image.asset(
                                "$staticAsset/Check.png",
                                scale: 3.5,
                              )
                            : Image.asset(
                                "$staticAsset/Check2.png",
                                scale: 3.5,
                              )
                        : Container()
                    : message.fromUserId == user.id
                        ? message.isReaded == true
                            ? Image.asset(
                                "$staticAsset/Check.png",
                                scale: 3.5,
                              )
                            : Image.asset(
                                "$staticAsset/Check2.png",
                                scale: 3.5,
                              )
                        : Container()
              ],
            ),
            // sizeBoxw10
          ],
        ),
      ),
    );
  }
}

class JoinORLeaveGroup extends StatelessWidget {
  final String message;

  JoinORLeaveGroup({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 7),
          Expanded(child: Divider(thickness: 1)),
          SizedBox(width: 7),
          Text("$message"),
          SizedBox(width: 7),
          Expanded(child: Divider(thickness: 1)),
          SizedBox(width: 7),
        ],
      ),
    );
  }
}
