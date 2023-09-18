import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/home/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(builder: (context, model, child) {
        return Scaffold(
            body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hart',
                          style: subHeadingText1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showFilter(context);
                          },
                          child: Image.asset(
                            '$staticAsset/Filter.png',
                            scale: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _imageSlider(
                    model,
                  ),
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
                          'Sarah',
                          style: subHeadingText1,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            _interstsContainer('23 men straight'),
                            SizedBox(
                              width: 16.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: greyColor),
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '$staticAsset/location2.png',
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '6.4 km',
                                    style: buttonTextStyle2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            _interstsContainer('Madrid, Spain'),
                            SizedBox(
                              width: 16.w,
                            ),
                            _interstsContainer('3 hours ago'),
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
                        Row(
                          children: [
                            _interstsContainer('Friendship'),
                            SizedBox(
                              width: 16.w,
                            ),
                            _interstsContainer('Marriage'),
                          ],
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
                        Row(
                          children: [
                            _interstsContainer('Art'),
                            SizedBox(
                              width: 16.w,
                            ),
                            _interstsContainer('Music'),
                            SizedBox(
                              width: 16.w,
                            ),
                            _interstsContainer('Hiking'),
                            SizedBox(
                              width: 16.w,
                            ),
                            _interstsContainer('Real connection'),
                          ],
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Text(
                            'Lorem ipsum dolor sit amet consectetur. Nulla ut proin diam est ac quam pretium lacus mollis. Pretium quam ac nibh nibh. Nec neque pulvinar risus sit consectetur cursus ut etiam risus...',
                            style: buttonTextStyle2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
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
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Image.asset(
                        '$staticAsset/cross.png',
                        scale: 3.5,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        model.like();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: model.isLiked ? primaryColor : whiteColor,
                          shape: BoxShape.circle,
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
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: model.isLiked
                            ? Image.asset(
                                '$staticAsset/likeWhite.png',
                                scale: 3.5,
                              )
                            : Image.asset(
                                '$staticAsset/Like.png',
                                scale: 3.5,
                              ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
      }),
    );
  }

  showFilter(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        clipBehavior: Clip.antiAlias,
        isScrollControlled: true,
        useSafeArea: true,
        // showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Consumer<HomeProvider>(
            builder: (context, model, child) => Stack(
              children: [
                Container(
                  height: 1.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        '$staticAsset/bottom_sheet.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reset',
                                style: miniText,
                              ),
                              Text(
                                'Filters',
                                style: subHeadingText1,
                              ),
                              Text(
                                'Done',
                                style: miniText,
                              ),
                            ],
                          ),
                          sizeBox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Age Range',
                                style: subHeadingTextStyle2,
                              ),
                              Text(
                                '${model.ageValues.start.floor()} - ${model.ageValues.end.floor()}',
                                style: miniText,
                              ),
                            ],
                          ),
                          // sizeBox10,
                          SfRangeSlider(
                            values: model.ageValues,
                            onChanged: (val) {
                              model.selectAge(val);
                            },
                            activeColor: primaryColor,
                            inactiveColor: greyColor,
                            showLabels: true,
                            max: 40.0,
                            endThumbIcon: thumbIcon(),
                            startThumbIcon: thumbIcon(),
                          ),
                          sizeBox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Maximum Distance',
                                style: subHeadingTextStyle2,
                              ),
                              Text(
                                '${model.distanceValues.start.floor()} - ${model.distanceValues.end.floor()} KM',
                                style: miniText,
                              ),
                            ],
                          ),
                          // sizeBox10,
                          SfRangeSlider(
                            values: model.distanceValues,
                            onChanged: (val) {
                              model.selectDistance(val);
                            },
                            activeColor: primaryColor,
                            inactiveColor: greyColor,
                            showLabels: true,
                            max: 20.0,
                            endThumbIcon: thumbIcon(),
                            startThumbIcon: thumbIcon(),
                          ),
                          sizeBox30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Looking For',
                                style: subHeadingTextStyle2,
                              ),
                              Text(
                                'Woman >',
                                style: miniText.copyWith(color: greyColor2),
                              ),
                            ],
                          ),
                          sizeBox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location',
                                style: subHeadingTextStyle2,
                              ),
                              Text(
                                'Current location >',
                                style: miniText.copyWith(color: greyColor2),
                              ),
                            ],
                          ),
                          sizeBox20,
                          Text(
                            'Search by',
                            style: subHeadingText1,
                          ),
                          sizeBox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location',
                                style: subHeadingTextStyle2.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                'Any >',
                                style: miniText.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          sizeBox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recently online',
                                style: buttonTextStyle.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                              Switch(
                                activeColor: primaryColor,
                                value: model.isRecent,
                                onChanged: (val) {
                                  model.recent(val);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Only show people active in the last 7 days',
                            style: buttonTextStyle2.copyWith(
                              color: Color(0xFFc48184),
                            ),
                          ),
                          sizeBox30,
                          CustomButton(
                            title: 'CONTINUE',
                            onTap: () {},
                          ),

                          sizeBox30,
                        ],
                      ),
                    ),
                  ),
                ),

                ///
                /// drag Handle
                ///
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    '$staticAsset/handle.png',
                    scale: 3,
                  ),
                )
              ],
            ),
          );
        });
  }

  Container thumbIcon() {
    return Container(
      width: 12.w,
      height: 12.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: whiteColor,
        border: Border.all(
          width: 3,
          color: primaryColor,
        ),
      ),
    );
  }

  _interstsContainer(text) {
    return Container(
      padding: EdgeInsets.symmetric(
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
}

_imageSlider(HomeProvider model) {
  return Stack(
    children: [
      CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('$dynamicAsset/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            model.updateIndex(index);
          },
          height: 0.4.sh,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: model.currentIndex,
          enableInfiniteScroll: false,
          scrollDirection: Axis.vertical,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25,
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              color: pinkColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: DotsIndicator(
              axis: Axis.vertical,
              dotsCount: 5,
              position: model.currentIndex,
              decorator: DotsDecorator(
                activeColor: primaryColor,
                size: Size(7.0, 7.0),
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 16,
        left: 16,
        child: Image.asset(
          '$staticAsset/Recycle.png',
          scale: 3,
        ),
      ),
      Positioned(
          right: 16,
          bottom: 16,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  '$staticAsset/loader.png',
                  scale: 3,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Text(
                  '2',
                  style: buttonTextStyle,
                )
              ],
            ),
          ))
    ],
  );
}
