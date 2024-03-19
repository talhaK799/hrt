import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_loaders/red_hart.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
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
      child: Consumer<ConversationProvider>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            progressIndicator: RedHartLoader(),
            child: Scaffold(
                backgroundColor:
                    //  model.currentUser.matchedUsers.isEmpty
                    //     ? whiteColor
                    //     :
                    primaryColor,
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
                              // Get.to(CreateGroupScreen());
                              Navigator.push(
                                context,
                                PageFromRight(
                                  page: CreateGroupScreen(),
                                ),
                              );
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
                        child: model.state == ViewState.busy
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Matches',
                                    style: subHeadingTextStyle2,
                                  ),

                                  ///
                                  /// Matched Users List
                                  ///
                                  model.currentUser.matchedUsers.isNotEmpty
                                      ? Container(
                                          height: 0.15.sh,
                                          child: ListView.separated(
                                            physics: BouncingScrollPhysics(),
                                            // shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: model.currentUser
                                                .matchedUsers.length,
                                            // model.matchedUsers.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  // print(
                                                  //     'chat user Id ${model.currentUser.matchedUsers[index].id!}');

                                                  Navigator.push(
                                                    context,
                                                    PageFromRight(
                                                      page: ChattingScreen(
                                                        toUserId: model
                                                            .currentUser
                                                            .matchedUsers[index]
                                                            .id!,
                                                        conversation:
                                                            Conversation(
                                                          leftedUsers: [],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  model.filterMatches();
                                                  // Get.to(
                                                  //   ChattingScreen(
                                                  //     toUserId: model
                                                  //         .currentUser
                                                  //         .matchedUsers[index]
                                                  //         .id!,
                                                  //     conversation:
                                                  //         Conversation(),
                                                  //   ),
                                                  // );

                                                  // if (model.firstTime == false) {
                                                  //   model.currentUser.matchedUsers
                                                  //       .removeAt(index);
                                                  //   model
                                                  //       .setState(ViewState.idle);
                                                  // }
                                                },
                                                child: model
                                                        .currentUser
                                                        .matchedUsers[index]
                                                        .images!
                                                        .isNotEmpty
                                                    ? CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(model
                                                                .currentUser
                                                                .matchedUsers[
                                                                    index]
                                                                .images!
                                                                .first),
                                                        maxRadius: 35.r,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            '$staticAsset/person.png'),
                                                        maxRadius: 35.r,
                                                      ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => SizedBox(
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
                                                  style:
                                                      subHeadingText1.copyWith(
                                                          fontSize: 16.sp),
                                                ),
                                              ),
                                            ),
                                  Text(
                                    'All',
                                    style: subHeadingTextStyle2,
                                  ),
                                  sizeBox20,
                                  model.currentUser.conversations.isNotEmpty
                                      ? Expanded(
                                          child: ListView.separated(
                                            padding: EdgeInsets.zero,
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: model.currentUser
                                                .conversations.length,
                                            itemBuilder: (context, index) {
                                              return _normalChat(
                                                model,
                                                index,
                                                () => Navigator.push(
                                                  context,
                                                  PageFromRight(
                                                    page: ChattingScreen(
                                                      toUserId: model
                                                              .currentUser
                                                              .conversations[
                                                                  index]
                                                              .toUserId ??
                                                          '',
                                                      conversation: model
                                                          .currentUser
                                                          .conversations[index],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => SizedBox(
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
                                                    style: subHeadingText1
                                                        .copyWith(
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
        },
      ),
    );
  }

  _normalChat(ConversationProvider model, int index, onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: model.currentUser.conversations[index].isGroupChat == true
          ? model.currentUser.conversations[index].imageUrl == null
              ? CircleAvatar(
                  radius: 35.r,
                  backgroundImage: AssetImage('$staticAsset/person.png'),
                )
              : CircleAvatar(
                  radius: 35.r,
                  backgroundImage: NetworkImage(
                      model.currentUser.conversations[index].imageUrl!))
          : model.currentUser.conversations[index].appUser == null
              ? Container(
                  color: whiteColor,
                )
              : model.currentUser.conversations[index].appUser!.images == null
                  ? CircleAvatar(
                      radius: 35.r,
                      backgroundImage: AssetImage(
                        '$staticAsset/person.png',
                      ),
                    )
                  : CircleAvatar(
                      radius: 35.r,
                      backgroundImage: NetworkImage(
                        model.currentUser.conversations[index].appUser!.images!
                            .first,
                      ),
                    ),
      title: Text(
        "${model.currentUser.conversations[index].isGroupChat == true ? model.currentUser.conversations[index].name : model.currentUser.conversations[index].appUser == null ? " " : model.currentUser.conversations[index].appUser!.name ?? 'user'}",
        style: subHeadingTextStyle2,
      ),
      subtitle: Text(
        // model.currentUser.conversations[index].isGroupChat == true
        //     ? model.currentUser.conversations[index].lastMessage??""
        // :
        model.currentUser.conversations[index].lastMessage ?? '',
        style: subtitleText.copyWith(color: greyColor2),
      ),
      trailing: Column(
        children: [
          Text(
            // model.currentUser.conversations[index].isGroupChat == true
            //     ? onlyTime.format(
            //         model.currentUser.conversations[index].lastMessageat ??
            //             DateTime.now())
            // :
            onlyTime.format(
                model.currentUser.conversations[index].lastMessageat ??
                    DateTime.now()),
            style: miniText,
          ),
        ],
      ),
    );
  }
}
