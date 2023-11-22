// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../custom_widgets/custom_bottombar_item.dart';
import 'root_provider.dart';

class RootScreen extends StatelessWidget {
  int? index = 0;

  RootScreen({this.index = 0});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootViewModel(this.index!),
      child: Consumer<RootViewModel>(builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () => model.closeApp(context),
          child: Scaffold(
            ///
            /// body
            ///
            body: model.allScreen[model.currentIndex],

            ///
            /// bottom navigation bar
            ///
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: greyColor,
                    offset: const Offset(
                      3.0,
                      3.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                ],
                color: whiteColor,
              ),
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBottomBarItem(
                    onTap: () {
                      model.updateIndex(0);
                    },
                    icon2: 'home2.png',
                    icon: 'home.png',
                    activeIndex: 0,
                    currentIndex: model.currentIndex,
                  ),
                  CustomBottomBarItem(
                    icon2: 'heartl.png',
                    icon: 'heartl.png',
                    size: 34,
                    currentIndex: model.currentIndex,
                    activeIndex: 1,
                    onTap: () {
                      model.updateIndex(1);
                    },
                  ),
                  CustomBottomBarItem(
                    icon2: 'chat2.png',
                    icon: 'chat.png',
                    currentIndex: model.currentIndex,
                    activeIndex: 2,
                    onTap: () {
                      model.updateIndex(2);
                    },
                  ),
                  CustomBottomBarItem(
                    icon2: 'profile2.png',
                    icon: 'profile.png',
                    currentIndex: model.currentIndex,
                    activeIndex: 3,
                    onTap: () {
                      model.updateIndex(3);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
