import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/models/radio_button.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loaders/red_hart.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_provider.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/chatting/chatting_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'create_group/create_group_screen.dart';

class ConversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationProvider(),
      child: Consumer<ConversationProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: RedHartLoader(),
          child: Scaffold(
              backgroundColor:
                  model.state == ViewState.busy ? whiteColor : primaryColor,
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 50, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chat', style: subHeadingTextWhite),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.to(CreateGroupScreen());
                            // Get.to(
                            // ChatInfoScreen(),
                            // );
                          },
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
                          /// Matched Users List
                          ///
                          model.matchedUsers.isNotEmpty
                              ? Container(
                                  height: 0.15.sh,
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: model.matchedUsers.length,
                                    // model.matchedUsers.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              'chat user Id ${model.matchedUsers[index].id!}');
                                          Get.to(
                                            ChattingScreen(
                                              toUserId:
                                                  model.matchedUsers[index].id!,
                                              conversation: Conversation(),
                                            ),
                                          );
                                        },
                                        child: model.matchedUsers[index].images!
                                                .isNotEmpty
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    model.matchedUsers[index]
                                                        .images!.first),
                                                maxRadius: 35.r,
                                              )
                                            : CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    '$staticAsset/person.png'),
                                                maxRadius: 35.r,
                                              ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: 15.w,
                                    ),
                                  ),
                                )
                              : model.state == ViewState.busy
                                  ? Container()
                                  : Container(
                                      color: whiteColor,
                                      width: double.infinity,
                                      height: 0.15.sh,
                                      child: Center(
                                        child: Text(
                                          'No Matches Found',
                                          style: subHeadingText1.copyWith(
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                          Text(
                            'All',
                            style: subHeadingTextStyle2,
                          ),
                          sizeBox20,
                          model.conversations.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: model.conversations.length,
                                    itemBuilder: (context, index) {
                                      return _normalChat(
                                        model,
                                        index,
                                        () => Get.to(
                                          ChattingScreen(
                                            toUserId: model.conversations[index]
                                                    .toUserId ??
                                                '',
                                            conversation:
                                                model.conversations[index],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 15.h,
                                    ),
                                  ),
                                )
                              : model.state == ViewState.busy
                                  ? Container()
                                  : Expanded(
                                      child: Container(
                                        color: whiteColor,
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            'No Conversations Found',
                                            style: subHeadingText1.copyWith(
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }

  _disconnectionSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        builder: (context) {
          return Consumer<ConversationProvider>(
              builder: (context, model, child) {
            return Container(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 100,
                bottom: 30,
              ),
              child: Column(children: [
                Text(
                  'Do you want to disconnect from Josef?',
                  textAlign: TextAlign.center,
                  style: bodyTextStyle,
                ),
                sizeBox20,
                Text(
                  'If you disconnect, Josef will no longer be able to message or access your chat history.',
                  textAlign: TextAlign.center,
                  style: buttonTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                sizeBox30,
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: model.buttons.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => model.selectButton(index),
                      child: _selecions(
                        model.buttons[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => sizeBox20,
                ),
                sizeBox30,
                CustomButton(
                  title: 'LEAVE',
                  onTap: () {},
                ),
                sizeBox20,
                CustomButton(
                  title: 'Back',
                  textColor: primaryColor,
                  color: pinkColor,
                  onTap: () {},
                ),
              ]),
            );
          });
        });
  }

  _selecions(RadioButton button) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          button.title!,
          style: bodyTextStyle,
        ),
        Container(
          width: 15.w,
          height: 15.h,
          decoration: BoxDecoration(
            color: button.isSelected == true ? primaryColor : pinkColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  _leaveGroupBottomsheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(children: [
              Text(
                'Are you sure you want to leave this group XYZ',
                textAlign: TextAlign.center,
                style: bodyTextStyle,
              ),
              sizeBox20,
              Text(
                'A member of the group should add you backagain if you change your mind',
                textAlign: TextAlign.center,
                style: buttonTextStyle.copyWith(
                  color: Colors.grey,
                ),
              ),
              sizeBox30,
              CustomButton(
                title: 'LEAVE',
                onTap: () {},
              ),
              sizeBox20,
              CustomButton(
                title: 'Back',
                textColor: primaryColor,
                color: pinkColor,
                onTap: () {},
              ),
            ]),
          );
        });
  }

  _normalChat(ConversationProvider model, int index, onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: model.conversations[index].isGroupChat == true
          ? model.conversations[index].imageUrl == null
              ? CircleAvatar(
                  radius: 35.r,
                  backgroundImage: AssetImage('$staticAsset/person.png'),
                )
              : CircleAvatar(
                  radius: 35.r,
                  backgroundImage:
                      NetworkImage(model.conversations[index].imageUrl!))
          : model.conversations[index].appUser == null
              ? Container(
                  color: whiteColor,
                )
              : model.conversations[index].appUser!.images == null
                  ? CircleAvatar(
                      radius: 35.r,
                      backgroundImage: AssetImage(
                        '$staticAsset/person.png',
                      ),
                    )
                  : CircleAvatar(
                      radius: 35.r,
                      backgroundImage: NetworkImage(
                        model.conversations[index].appUser!.images!.first,
                      ),
                    ),
      title: Text(
        "${model.conversations[index].isGroupChat == true ? model.conversations[index].name : model.conversations[index].appUser == null ? " " : model.conversations[index].appUser!.name ?? 'user'}",
        style: subHeadingTextStyle2,
      ),
      subtitle: Text(
        model.conversations[index].isGroupChat == true
            ? ""
            : model.conversations[index].lastMessage ?? '',
        style: subtitleText.copyWith(color: greyColor2),
      ),
      trailing: Column(
        children: [
          Text(
            model.conversations[index].isGroupChat == true
                ? ""
                : onlyTime.format(
                    model.conversations[index].lastMessageat ?? DateTime.now()),
            style: miniText,
          ),
        ],
      ),
    );
  }
}
