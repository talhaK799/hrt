import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/screens/home/home_provider.dart';
import 'package:provider/provider.dart';

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
            Column(
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
                      Image.asset(
                        '$staticAsset/Filter.png',
                        scale: 3,
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
                    ],
                  ),
                )
              ],
            )
          ],
        ));
      }),
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
          height: 400,
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
