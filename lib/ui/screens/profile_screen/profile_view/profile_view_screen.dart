import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/screens/profile_screen/profile_view/profile_view_provider.dart';
import 'package:provider/provider.dart';

class ProfileViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewProvider(),
      child: Consumer<ProfileViewProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          isWhite: true,
                        ),
                      ],
                    ),
                  ),
                  sizeBox30,

                  ///
                  /// Iamge slider
                  ///

                  _imageSlider(model, model.currentUser),
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
                          // user.name ??
                          '${model.currentUser.nickName}',
                          style: subHeadingText1,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     SizedBox(
                        //       height: 15.h,
                        //     ),
                        //     GestureDetector(
                        //       behavior: HitTestBehavior.opaque,
                        //       onTap: () {
                        //         // model.spank(user, context);
                        //       },
                        //       child: Container(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 12,
                        //           vertical: 4,
                        //         ),
                        //         decoration: BoxDecoration(
                        //           color: primaryColor,
                        //           borderRadius: BorderRadius.circular(16.r),
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             Image.asset(
                        //               '$staticAsset/loader.png',
                        //               scale: 2,
                        //               color: pinkColor2,
                        //             ),
                        //             SizedBox(
                        //               width: 10.h,
                        //             ),
                        //             Text(
                        //               '${model.currentUser.spanks ?? 0}',
                        //               style: buttonTextStyle,
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        20.verticalSpace,
                        Row(
                          children: [
                            // _infoContainer('23 men straight'),
                            Text(
                              '${model.currentUser.age} ${model.currentUser.lookingFor != null || model.currentUser.lookingFor!.isNotEmpty ? model.currentUser.lookingFor!.first : ""} ${model.currentUser.identity}',
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
                              '${model.currentUser.desire != null || model.currentUser.desire!.isNotEmpty ? model.currentUser.desire!.first : ""}',
                              style: buttonTextStyle2,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            // _infoContainer('3 hours ago'),
                            Text(
                              model.currentUser.offlineTime,
                              style: buttonTextStyle2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Desires',
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
                              return _infoContainer(
                                  model.currentUser.desire![index]);
                            }),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 16.w,
                            ),
                            itemCount: model.currentUser.desire!.length,
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
                            for (int i = 0;
                                i < model.currentUser.lookingFor!.length;
                                i++)
                              _infoContainer(model.currentUser.lookingFor![i])
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
                          child: Column(
                            children: [
                              Text(
                                "${model.currentUser.about}",
                                style: buttonTextStyle2,
                                textAlign: TextAlign.justify,
                              ),
                              20.verticalSpace,
                            ],
                          ),
                        ),
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
}

_imageSlider(ProfileViewProvider model, AppUser user) {
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
      user.isPrivatePhoto == true
          ? Container(
              height: 0.35.sh,
              decoration: BoxDecoration(color: whiteColor.withOpacity(0.9)),
              child: Center(
                  // child: Text(
                  //   'Pravate Image',
                  //   style: bodyTextStyle,
                  // ),
                  ),
            )
          : Container(),
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
      // user.images == null
      //     ? Container()
      //     : Positioned(
      //         bottom: 16,
      //         left: 16,
      //         child: GestureDetector(
      //           onTap: () {
      //             model.restorePrevousProfile();
      //           },
      //           child: Image.asset(
      //             '$staticAsset/Recycle.png',
      //             scale: 3,
      //           ),
      //         ),
      //       ),
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
