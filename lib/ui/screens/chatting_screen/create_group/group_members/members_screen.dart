import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/create_group_provider.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/group_members/members_provider.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_chatting_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../custom_widgets/custom_button.dart';
import '../../../../custom_widgets/white_textfield.dart';

class MembersScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateGroupProvider(),
      child: Consumer<CreateGroupProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          title: 'Create Group Chat',
                        ),
                        sizeBox30,
                        Text(
                          'Name your group',
                          style: bodyTextStyle,
                        ),
                        sizeBox10,

                        ///
                        /// TextField
                        ///
                        CustomTextFieldWhite(
                          validator: (val) {
                            if (val == null) {
                              return "Enter group name";
                            }
                          },
                          onChange: (val) {
                            model.conversation.name = val.trim();
                          },
                          hintText: 'Enter your group name',
                        ),
                        sizeBox20,
                        Text(
                          'Name your group',
                          style: bodyTextStyle,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 95),
                            child: ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: model.selectedUsers.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: model.selectedUsers[index].images!
                                          .isNotEmpty
                                      ? CircleAvatar(
                                          radius: 35.r,
                                          backgroundImage: NetworkImage(
                                            '${model.selectedUsers[index].images!.first}',
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 35.r,
                                          backgroundImage: AssetImage(
                                            '$dynamicAsset/profile.png',
                                          ),
                                        ),
                                  title: Text(
                                    '${model.selectedUsers[index].name}',
                                    style: subHeadingTextStyle2,
                                  ),
                                  // subtitle: Text(
                                  //   '20 woman straight',
                                  //   style: subtitleText,
                                  // ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CustomButton(
                        title: 'CREATE',
                        onTap: () {
                          if (model.conversation.name != null) {
                            model.createGroup();
                          } else {
                            Get.snackbar("Error!", "Please enter group name");
                          }
                          // Get.off(
                          //   GroupChattingScreen(),
                          // );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // _groupNameTextField() {
  //   return CustomTextFieldWhite();
  // }
}
