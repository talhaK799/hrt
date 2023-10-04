import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: model.pageController,
              itemCount: 4,
              itemBuilder: (context, index) {
                return _homeScreenData(context, model);
              },
              onPageChanged: (val) {
                model.changePage();
              },
            ),
            _likeButtons(model)
          ],
        ));
      }),
    );
  }

  _likeButtons(HomeProvider model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                model.disLike();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: boxShadow,
                ),
                child: Image.asset(
                  '$staticAsset/cross.png',
                  scale: 3.5,
                ),
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: model.isLiked ? primaryColor : whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: boxShadow,
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
    );
  }

  _homeScreenData(BuildContext context, HomeProvider model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   'Hart',
                //   style: subHeadingText1,
                // ),
                Image.asset(
                  '$logoPath/logo3.png',
                  scale: 6.5,
                  color: primaryColor,
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
                    // _infoContainer('23 men straight'),
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
                    // _infoContainer('Madrid, Spain'),
                    Text(
                      'Single, 10 km away,',
                      style: buttonTextStyle2,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    // _infoContainer('3 hours ago'),
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
                Row(
                  children: [
                    _infoContainer('Friendship'),
                    SizedBox(
                      width: 16.w,
                    ),
                    _infoContainer('Marriage'),
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
                Column(
                  children: [
                    Row(
                      children: [
                        _infoContainer('Art'),
                        SizedBox(
                          width: 16.w,
                        ),
                        _infoContainer('Music'),
                        SizedBox(
                          width: 16.w,
                        ),
                        _infoContainer('Hiking'),
                        // SizedBox(
                        //   width: 16.w,
                        // ),
                      ],
                    ),
                    sizeBox10,
                    Row(
                      children: [
                        _infoContainer('Real connection'),
                      ],
                    )
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
                  padding: const EdgeInsets.only(bottom: 100),
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
        shape: const RoundedRectangleBorder(
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        '$staticAsset/bottom_sheet.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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

                          ///
                          /// Age slider
                          ///
                          SfRangeSlider(
                            values: model.ageValues,
                            onChanged: (val) {
                              model.selectAge(val);
                            },
                            activeColor: primaryColor,
                            inactiveColor: greyColor,
                            showLabels: true,
                            min: 18,
                            max: 70.0,
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
                            max: 150.0,
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
                                'What you desire',
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
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Only show people active in the last 7 days',
                            style: buttonTextStyle2.copyWith(
                              color: const Color(0xFFc48184),
                            ),
                          ),
                          sizeBox30,
                          CustomButton(
                            title: 'CONTINUE',
                            onTap: () {
                              Get.back();
                            },
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
}

_imageSlider(HomeProvider model) {
  return Stack(
    children: [
      CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          return Container(
            decoration: const BoxDecoration(
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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              color: pinkColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: DotsIndicator(
              axis: Axis.vertical,
              dotsCount: 5,
              position: model.currentIndex,
              decorator: const DotsDecorator(
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
            padding: const EdgeInsets.symmetric(
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
