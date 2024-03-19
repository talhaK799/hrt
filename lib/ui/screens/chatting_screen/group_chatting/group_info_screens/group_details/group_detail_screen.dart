import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_info_screens/add_people/add_people_screen.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_info_screens/group_details/group_detail_provider.dart';
import 'package:hart/ui/screens/chatting_screen/user_details/user_detail_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/models/app_user.dart';

class GroupDetailScreen extends StatelessWidget {
  Conversation group;
  GroupDetailScreen({required this.group});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupDetailProvider(group),
      child: Consumer<GroupDetailProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: 'Group',
                    ),
                    sizeBox30,
                    GestureDetector(
                      onTap: () {
                        // Get.to(
                        //   AddPeopleScreen(
                        //     group: group,
                        //   ),
                        // );
                        model.addpeople(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add people',
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
                          inactiveTrackColor: greyColor,
                          value: model.isMute,
                          onChanged: (val) {
                            model.changeMute(val);
                          },
                        ),
                      ],
                    ),
                    sizeBox20,
                    GestureDetector(
                      onTap: () {
                        leavegroup(
                          context,
                          model,
                        );
                      },
                      child: Text(
                        'Leave',
                        style: bodyTextStyle.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    sizeBox30,
                    sizeBox10,
                    Text(
                      'Members',
                      style: buttonTextStyle.copyWith(
                        color: greyColor2,
                      ),
                    ),
                    sizeBox20,
                    ListView.separated(
                      primary: false,
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: model.groupMembers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          onLongPress: () {
                            model.groupMembers[index].id ==
                                    model.group.groupAdmin
                                ? () {}
                                : model.currentUser.appUser.id ==
                                        model.group.groupAdmin
                                    ? _removeUser(context, model, index)
                                    : () {};
                          },
                          onTap: () {
                            // Get.to(
                            //   UserDetailScreen(user: model.groupMembers[index]),
                            // );
                            Navigator.push(
                              context,
                              PageFromRight(
                                page: UserDetailScreen(
                                    user: model.groupMembers[index]),
                              ),
                            );
                          },
                          leading: model.groupMembers[index].images!.isEmpty
                              ? CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: AssetImage(
                                    '$dynamicAsset/profile.png',
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: NetworkImage(
                                    model.groupMembers[index].images!.first,
                                  ),
                                ),
                          title: Text(
                            model.groupMembers[index].name!,
                            style: subHeadingTextStyle2,
                          ),
                          subtitle: model.groupMembers[index].id ==
                                  model.group.groupAdmin
                              ? Text(
                                  'Admin',
                                  style: subtitleText.copyWith(
                                    color: primaryColor,
                                  ),
                                )
                              : Text(
                                  model.groupMembers[index].nickName!,
                                  style: subtitleText,
                                ),
                          trailing: Image.asset(
                            '$staticAsset/arrow.png',
                            scale: 3,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> _removeUser(
      BuildContext context, GroupDetailProvider model, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            title: Text(
              'Are you sure?',
              style: bodyTextStyle.copyWith(color: primaryColor),
            ),
            content: Text('Do you realy want to remove this member'),
            actions: [
              TextButton(
                onPressed: () {
                  model.removeMember(index);
                  Get.back();
                },
                child: Text(
                  'YES',
                  style: buttonTextStyle2.copyWith(
                    color: lightRed,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'NO',
                  style: buttonTextStyle2.copyWith(
                    color: lightRed,
                  ),
                ),
              )
            ],
          );
        });
  }

  Future<dynamic> leavegroup(BuildContext context, GroupDetailProvider model) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            title: Text(
              'Are you sure?',
              style: bodyTextStyle.copyWith(color: primaryColor),
            ),
            content: Text('Do you realy want to leave this group'),
            actions: [
              TextButton(
                onPressed: () {
                  model.leaveGroup();
                  // Get.back();
                },
                child: Text(
                  'YES',
                  style: buttonTextStyle2.copyWith(
                    color: lightRed,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'NO',
                  style: buttonTextStyle2.copyWith(
                    color: lightRed,
                  ),
                ),
              )
            ],
          );
        });
  }
}
