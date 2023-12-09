import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loaders/red_hart_10sec.dart';
import 'package:hart/ui/screens/home/home_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: RedHart10SecLoader(),
          child: Scaffold(
              backgroundColor: model.isFiltering == true
                  ? model.filteredUsers.isEmpty
                      ? primaryColor
                      : whiteColor
                  : model.currentUser.appUsers.isEmpty
                      ? primaryColor
                      : whiteColor,
              body: Stack(
                children: [
                  model.state == ViewState.busy
                      ? Container(
                          color: whiteColor,
                          width: 1.sw,
                          height: 1.sh,
                        )
                      : Column(
                          children: [
                            model.currentUser.appUsers.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 50, 24, 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          behavior: HitTestBehavior.opaque,
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
                            Expanded(
                              child: PageView.builder(
                                physics: BouncingScrollPhysics(),
                                controller: model.pageController,
                                itemCount: model.isFiltering == true
                                    ? model.filteredUsers.length > 0
                                        ? model.filteredUsers.length
                                        : 1
                                    : model.appUsers.length > 0
                                        ? model.appUsers.length
                                        : 1,
                                itemBuilder: (context, index) {
                                  model.index = index;
                                  return model.isFiltering == true
                                      ? model.state == ViewState.busy
                                          ? Container()
                                          : model.filteredUsers.length == 0
                                              ? _staticScreen(context)
                                              : _homeScreenData(model,
                                                  model.filteredUsers[index])
                                      : model.state == ViewState.busy
                                          ? Container()
                                          : model.appUsers.length == 0
                                              ? _staticScreen(context)
                                              : _homeScreenData(
                                                  model, model.appUsers[index]);
                                },
                                onPageChanged: (val) => model.changePage(val),
                              ),
                            )
                          ],
                        ),
                  model.isFiltering == true
                      ? model.filteredUsers.isEmpty
                          ? Container()
                          : _likeButtons(model)
                      : model.appUsers.isEmpty
                          ? Container()
                          : _likeButtons(model),

                  ///
                  /// Liking Animation
                  ///
                  // model.isLiked
                  //     ? Center(
                  //         child: Lottie.asset(
                  //           '$animations/heart.json',
                  //           // controller: _animationController,
                  //           repeat: false,
                  //           frameRate: FrameRate(
                  //             100,
                  //           ),
                  //         ),
                  //       )
                  //     : Container(),
                ],
              )),
        );
      }),
    );
  }

  _likeButtons(HomeProvider model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ////
                /// DisLike button
                ///
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      model.isLiked = false;
                      model.isDisLiked = true;
                    });
                    await Future.delayed(Duration(milliseconds: 100));

                    setState(() {
                      model.isDisLiked = false;
                    });
                    model.disLike(model.appUsers[model.index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: model.isDisLiked == true ? greyColor2 : whiteColor,
                      shape: BoxShape.circle,
                      boxShadow: boxShadow,
                    ),
                    child: Image.asset(
                      '$staticAsset/cross.png',
                      color: model.isDisLiked == true ? whiteColor : null,
                      scale: 3.5,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),

                ////
                /// Like button
                ///
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      model.isLiked = true;
                      model.isDisLiked = false;
                    });
                    await Future.delayed(Duration(milliseconds: 100));

                    setState(() {
                      model.isLiked = false;
                      model.isDisLiked = false;
                    });
                    model.like(model.appUsers[model.index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: model.isLiked == true ? primaryColor : whiteColor,
                      shape: BoxShape.circle,
                      boxShadow: boxShadow,
                    ),
                    child: model.isLiked == true
                        ? Image.asset(
                            '$staticAsset/likeWhite.png',
                            scale: 3.5,
                          )
                        : Image.asset(
                            '$staticAsset/Like.png',
                            scale: 3.5,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _staticScreen(BuildContext context) {
    return Stack(
      children: [
        ///
        /// Background Image
        ///
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 0.35.sh,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                child: SvgPicture.asset(
                  '$staticAsset/circle.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              18,
              0,
              18,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nobody around',
                  style: subHeadingTextWhite.copyWith(
                    color: blackColor,
                  ),
                ),
                sizeBox20,
                Center(
                  child: Image.asset(
                    '$staticAsset/Subtract.png',
                    scale: 4,
                    fit: BoxFit.cover,
                  ),
                ),
                sizeBox20,
                Text(
                  'There is nobody matching your search preferences right now.',
                  style: subHeadingText1.copyWith(
                    color: blackColor,
                  ),
                ),
                sizeBox10,
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Try changing your search setting.',
                    style: buttonTextStyle.copyWith(
                      color: greyColor2,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: CustomButton(
                      title: 'Change Setting',
                      onTap: () {
                        showFilter(context);
                      }),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _homeScreenData(HomeProvider model, AppUser user) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// Iamge slider
          ///
          ///
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
                  user.name ?? '${user.nickName}',
                  style: subHeadingText1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        model.spank(user);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
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
                              scale: 2,
                              color: pinkColor2,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              '${model.currentUser.appUser.spanks ?? 0}',
                              style: buttonTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // _infoContainer('23 men straight'),
                    Text(
                      '${user.age} Women Straight',
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
                      'Single, ${(user.distance / 1000).round()} km away,',
                      style: buttonTextStyle2,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    // _infoContainer('3 hours ago'),
                    Text(
                      user.offlineTime,
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
                Wrap(
                  children: [
                    for (int i = 0; i < user.lookingFor!.length; i++)
                      _infoContainer(user.lookingFor![i])
                  ],
                ),
                // SizedBox(
                //   height: 35.h,
                //   child: ListView.separated(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: ((context, index) {
                //       return _infoContainer(user.lookingFor![index]);
                //     }),
                //     separatorBuilder: (context, index) => SizedBox(
                //       width: 16.w,
                //     ),
                //     itemCount: user.lookingFor!.length,
                //   ),
                // ),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         _infoContainer('Art'),
                //         SizedBox(
                //           width: 16.w,
                //         ),
                //         _infoContainer('Music'),
                //         SizedBox(
                //           width: 16.w,
                //         ),
                //         _infoContainer('Hiking'),
                //         // SizedBox(
                //         //   width: 16.w,
                //         // ),
                //       ],
                //     ),
                //     sizeBox10,
                //     Row(
                //       children: [
                //         _infoContainer('Real connection'),
                //       ],
                //     )
                //   ],
                // ),
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
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                model.resetFilter();
                              },
                              child: Text(
                                'Reset',
                                style: miniText.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Text(
                              'Filters',
                              style: subHeadingText1,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Done',
                                style: miniText.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.05.sh),
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
                          endThumbIcon: thumbIcon(false),
                          startThumbIcon: thumbIcon(false),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Maximum Distance',
                              style: subHeadingTextStyle2,
                            ),
                            Text(
                              ' ${model.distanceValues.end.floor()} KM',
                              // ${model.distanceValues.start.floor()} -
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
                          endThumbIcon: thumbIcon(false),
                          startThumbIcon: thumbIcon(true),
                        ),
                        SizedBox(height: 40.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Looking For',
                              style: subHeadingTextStyle2,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                await model.selectGender();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    model.lookingFor,
                                    style: buttonTextStyle.copyWith(
                                      color: greyColor2,
                                    ),
                                  ),
                                  sizeBoxw10,
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: greyColor2,
                                    size: 15,
                                  ),
                                ],
                              ),
                            )
                            // CustomDropDownButton(
                            //   value: model.gender,
                            //   onchange: (val) {
                            //     // model.selectGender(val);
                            //     Get.to(
                            //       SelectGenderScreen(),
                            //     );
                            //   },
                            //   items: model.lookingFor,
                            // ),
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

                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  onSelect: (countery) {
                                    // model.country = countery.displayName;
                                    model.selectCountry(countery.name);
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    model.country,
                                    style: buttonTextStyle.copyWith(
                                      color: greyColor2,
                                    ),
                                  ),
                                  sizeBoxw10,
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: greyColor2,
                                    size: 15,
                                  ),
                                ],
                              ),
                            )
                            // CustomDropDownButton(
                            //   value: model.country,
                            //   onchange: (val) {
                            //     model.selectCountry(val);
                            //   },
                            //   items: model.countries,
                            // ),
                            // Text(
                            //   'Current location >',
                            //   style: miniText.copyWith(color: greyColor2),
                            // ),
                          ],
                        ),
                        SizedBox(height: 40.h),

                        Text(
                          'Search by',
                          style: subHeadingText1,
                        ),
                        sizeBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'What you desire',
                              style: subHeadingTextStyle2.copyWith(
                                  color: primaryColor),
                            ),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  await model.selectDesire();
                                },
                                child: Container(
                                  height: 50.h,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Spacer(),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              model.filter.desire!.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${model.filter.desire![index]}, ",
                                                  style:
                                                      buttonTextStyle.copyWith(
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                1.horizontalSpace,
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: primaryColor,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // CustomDropDownButton(
                            //   value: model.desire,
                            //   onchange: (val) {
                            //     model.selectDesire();
                            //   },
                            //   color: lightRed,
                            //   items: model.desires,
                            // ),
                            // Text(
                            //   'Any >',
                            //   style: miniText.copyWith(
                            //     color: primaryColor,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        // model.currentUser.appUser.isPremiumUser == true
                        //     ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recently online',
                                  style: buttonTextStyle.copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          greyColor.withOpacity(0.1),
                                      disabledColor: redColor),
                                  child: Switch(
                                    activeColor: primaryColor,
                                    value: model.isRecent,
                                    trackOutlineWidth:
                                        MaterialStateProperty.all(10),
                                    onChanged: (val) {
                                      model.recent(context, val);
                                    },
                                  ),
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
                          ],
                        ),
                        // : Container(),

                        SizedBox(
                          height: 0.1.sh,
                        ),
                        CustomButton(
                          title: 'CONTINUE',
                          onTap: () {
                            model.applyFilter();
                          },
                        ),
                        sizeBox20,
                      ],
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

  thumbIcon(isFixed) {
    return isFixed
        ? CircleAvatar(
            backgroundColor: primaryColor,
            maxRadius: 2,
          )
        : Container(
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

_imageSlider(HomeProvider model, AppUser user) {
  return Stack(
    children: [
      user.images == null
          ? Image.asset("$dynamicAsset/image.png")
          : CarouselSlider.builder(
              itemCount: user.images!.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  height: 0.35.sh,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: NetworkImage(user.images![index].toString()),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
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

                  // FadeInImage.assetNetwork(
                  //
                  //   placeholder: '$logoPath/logo4.png',
                  //   image: user.images![index].toString(),
                  //   fit: BoxFit.fill,
                  // ),
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
      user.images == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  decoration: BoxDecoration(
                    color: pinkColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DotsIndicator(
                    axis: Axis.vertical,
                    dotsCount:
                        user.images!.length > 0 ? user.images!.length : 1,
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
      user.images == null
          ? Container()
          : Positioned(
              bottom: 16,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  model.restorePrevousProfile();
                },
                child: Image.asset(
                  '$staticAsset/Recycle.png',
                  scale: 3,
                ),
              ),
            ),
      // Positioned(
      //     right: 16,
      //     bottom: 16,
      //     child: Container(
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 10,
      //         vertical: 4,
      //       ),
      //       decoration: BoxDecoration(
      //         color: primaryColor,
      //         borderRadius: BorderRadius.circular(16.r),
      //       ),
      //       child: Row(
      //         children: [
      //           Image.asset(
      //             '$staticAsset/loader.png',
      //             scale: 3,
      //           ),
      //           SizedBox(
      //             width: 10.h,
      //           ),
      //           Text(
      //             '2',
      //             style: buttonTextStyle,
      //           )
      //         ],
      //       ),
      //     ))
    ],
  );
}
