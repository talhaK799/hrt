import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/create_group_provider.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/group_members/members_screen.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateGroupProvider(),
      child: Consumer<CreateGroupProvider>(builder: (context, model, child) {
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
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          itemCount: model.memebers.length,
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
                                model.memebers[index].name!,
                                style: subHeadingTextStyle2,
                              ),
                              subtitle: Text(
                                model.memebers[index].description!,
                                style: subtitleText,
                              ),
                              trailing: model.memebers[index].isChecked == true
                                  ? Image.asset(
                                      '$staticAsset/tick.png',
                                      scale: 3.5,
                                    )
                                  : null,
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
                    child: model.isEnable
                        ? CustomButton(
                            title: 'Continue',
                            onTap: () {
                              print("Done");
                              Get.to(
                                MembersScreen(),
                              );
                            },
                          )
                        : CustomButton(
                            title: 'Continue',
                            onTap: null,
                            textColor: primaryColor,
                            color: pinkColor,
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
}
