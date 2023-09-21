import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/group_members/members_provider.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_chatting_screen.dart';
import 'package:provider/provider.dart';

import '../../../../custom_widgets/custom_button.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemebersProvider(),
      child: Consumer<MemebersProvider>(builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
            child: Stack(
              children: [
                Column(
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
                    _groupNameTextField(),
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
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 35.r,
                                backgroundImage: AssetImage(
                                  '$dynamicAsset/profile.png',
                                ),
                              ),
                              title: Text(
                                'Laiba',
                                style: subHeadingTextStyle2,
                              ),
                              subtitle: Text(
                                '20 woman straight',
                                style: subtitleText,
                              ),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomButton(
                      title: 'CREATE',
                      onTap: () {
                        Get.off(
                          GroupChattingScreen(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _groupNameTextField() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: 1.sw,
          height: 65.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: greyColor)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 10),
          child: TextFormField(
            // obscureText: obscure ?? false,
            obscuringCharacter: '*',
            cursorColor: greyColor,
            style: subHeadingTextStyle,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Your group name..',
                hintStyle: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                errorStyle: subHeadingTextStyle,
                // suffix: suffex,
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
