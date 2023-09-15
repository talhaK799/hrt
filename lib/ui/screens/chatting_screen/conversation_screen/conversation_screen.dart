import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/conversation_provider.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationProvider(),
      child: Consumer<ConversationProvider>(builder: (context, model, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(32, 50, 32, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 72, 24, 16),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: AssetImage('$dynamicAsset/profile.png'),
                  ),
                  title: Text(
                    'Laiba',
                    style: subHeadingTextStyle,
                  ),
                  subtitle: Text(
                    'online',
                    style: miniText.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  trailing: GestureDetector(
                    child: Image.asset(
                      '$staticAsset/more.png',
                      scale: 3.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  // height: 1.sh,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    reverse: true,
                    itemCount: model.messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: model.messages[index].isSender!
                                ? greyColor
                                : primaryColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: SizedBox(
                          child: Text(
                            model.messages[index].text!,
                            style: subtitleText.copyWith(
                              fontSize: 12.sp,
                              color: model.messages[index].isSender!
                                  ? blackColor
                                  : whiteColor,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15.h,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
