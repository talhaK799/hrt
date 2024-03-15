import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/chatting_screen/user_details/user_detail_provider.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatelessWidget {
  AppUser user;
  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDetailProvider(),
      child: Consumer<UserDetailProvider>(builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///
                  /// Image slider
                  ///
                  _imageSlider(model, user),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? 'Jacqline Fernandus',
                          style: subHeadingText1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '23 Women Straight',
                              style: buttonTextStyle2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Single, 10 km away,',
                              style: buttonTextStyle2,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              '3 hours ago',
                              style: buttonTextStyle2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Desire',
                          style: subHeadingText1,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 35.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return _infoContainer(user.desire![index]);
                            }),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 16.w,
                            ),
                            itemCount: user.desire!.length,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Interests',
                          style: subHeadingText1,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 35.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return _infoContainer(user.identity![index]);
                            }),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 16.w,
                            ),
                            itemCount: user.identity!.length,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'About Me',
                          style: subHeadingText1,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          user.about ?? " ",
                          style: buttonTextStyle2,
                        ),
                        20.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.report,
                                color: greyColor2,
                              ),
                              10.horizontalSpace,
                              GestureDetector(
                                onTap: () {
                                  ///
                                  /// Report bottomsheet
                                  ///
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "Why are you reporting",
                                                  style: headingText.copyWith(
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: model
                                                      .reportsOptions.length,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          ListTile(
                                                    title: Text(
                                                        "${model.reportsOptions[index]}"),
                                                    trailing:
                                                        model.reportsOptionsIndex ==
                                                                index
                                                            ? Icon(Icons
                                                                .circle_rounded)
                                                            : Icon(Icons
                                                                .circle_outlined),
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          model.reportsOptionsIndex =
                                                              index;
                                                        },
                                                      );

                                                      // model.selectReportOption(index);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                ),
                                                child: CustomButton(
                                                  title: 'Report',
                                                  onTap: () {
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    model.reportUser(user);
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 30.h),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Text(
                                  'Report Profile ',
                                  style: bodyTextStyle.copyWith(
                                    color: greyColor2,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _infoContainer(text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Text(
        text,
        style: buttonTextStyle2,
      ),
    );
  }

  _imageSlider(UserDetailProvider model, AppUser user) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: user.images!.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              height: 0.35.sh,
              child: Image.network(
                user.images![index].toString(),
                height: 0.35.sh,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Return the image widget if it's fully loaded.
                  }
                  return Container(
                    height: 0.35.sh,
                    color: Colors.grey.withOpacity(0.1),
                    child: Center(
                      // Display a linear progress indicator until the image is fully loaded.
                      child: CircularProgressIndicator(
                        color: primaryColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              model.updateIndex(index);
            },
            height: 0.35.sh,

            // aspectRatio: 1,
            viewportFraction: 1,
            initialPage: 0,

            enableInfiniteScroll: false,
            scrollDirection: Axis.vertical,
            enlargeFactor: 0.6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 80,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: pinkColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DotsIndicator(
                axis: Axis.vertical,
                dotsCount: user.images!.length > 0 ? user.images!.length : 1,
                position: model.dotIndex,
                decorator: const DotsDecorator(
                  activeColor: primaryColor,
                  size: Size(7.0, 7.0),
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomBackButton(
            isWhite: true,
          ),
        )
      ],
    );
  }
}
