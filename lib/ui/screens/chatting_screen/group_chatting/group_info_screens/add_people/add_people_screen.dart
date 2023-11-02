import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'add_people_provider.dart';

class AddPeopleScreen extends StatelessWidget {
  Conversation group;
  AddPeopleScreen({
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPeopleProvider(group),
      child: Consumer<AddPeopleProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        title: 'Add People',
                      ),
                      sizeBox30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select group members',
                            style: bodyTextStyle,
                          ),
                          Image.asset(
                            '$staticAsset/search.png',
                            scale: 3,
                          ),
                        ],
                      ),
                      sizeBox20,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 95),
                          child: model.selectedUsers.isNotEmpty
                              ? ListView.separated(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: model.selectedUsers.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        model.check(index);
                                      },
                                      leading: CircleAvatar(
                                        radius: 35.r,
                                        backgroundImage: AssetImage(
                                          '$dynamicAsset/profile.png',
                                        ),
                                      ),
                                      title: Text(
                                        model.selectedUsers[index].name!,
                                        style: subHeadingTextStyle2,
                                      ),
                                      subtitle: Text(
                                        model.selectedUsers[index].nickName!,
                                        style: subtitleText,
                                      ),
                                      trailing: model.selectedUsers[index]
                                                  .isSelected ==
                                              true
                                          ? Image.asset(
                                              '$staticAsset/tick.png',
                                              scale: 3.5,
                                            )
                                          : null,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 15.h,
                                  ),
                                )
                              : Center(
                                  child: Text('No Matched User'),
                                ),
                        ),
                      ),
                    ],
                  ),
                  model.selectedUsers.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: model.isEnable
                                ? CustomButton(
                                    title: 'Continue',
                                    onTap: () {
                                      // Get.to(
                                      //   MembersScreen(),
                                      // );
                                    },
                                  )
                                : CustomButton(
                                    textColor: primaryColor,
                                    color: pinkColor,
                                    title: 'Continue',
                                    onTap: null,
                                  ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
