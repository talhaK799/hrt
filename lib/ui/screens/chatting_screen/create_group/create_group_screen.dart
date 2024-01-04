import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/create_group_provider.dart';
import 'package:hart/ui/screens/chatting_screen/create_group/group_members/members_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CreateGroupProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => CreateGroupProvider(),
        //   child:
        Consumer<CreateGroupProvider>(builder: (context, model, child) {
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
                          itemCount: model.matchedUsers.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                model.check(index);
                              },
                              leading:
                                  model.matchedUsers[index].images!.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 35.r,
                                          backgroundImage: NetworkImage(
                                            '${model.matchedUsers[index].images!.first}',
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 35.r,
                                          backgroundImage: AssetImage(
                                            '$dynamicAsset/profile.png',
                                          ),
                                        ),
                              title: Text(
                                "${model.matchedUsers[index].name}",
                                style: subHeadingTextStyle2,
                              ),
                              subtitle: Text(
                                "${model.matchedUsers[index].nickName}",
                                style: subtitleText,
                              ),
                              trailing:
                                  model.matchedUsers[index].isSelected == true
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              // Get.to(
                              //   MembersScreen(),
                              // );
                              Navigator.push(
                                context,
                                PageFromRight(
                                  page: MembersScreen(),
                                ),
                              );
                            },
                          )
                        : CustomButton(
                            title: 'Continue',
                            onTap: () {
                              Get.snackbar("Error!", "Please select members");
                            },
                            textColor: primaryColor,
                            color: pinkColor,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
            // ),
            );
  }
}
