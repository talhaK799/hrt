import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/screens/connection_screen/connections_provider.dart';
import 'package:provider/provider.dart';

class ConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionsProvider(),
      child: Consumer<ConnectionsProvider>(builder: (context, model, child) {
        return Scaffold(
          backgroundColor: model.isLiked ? whiteColor : primaryColor,
          body: model.isLiked
              ? Padding(
                  padding: EdgeInsets.fromLTRB(22, 50, 22, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Connections',
                        style: subHeadingTextWhite.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      sizeBox30,

                      ///
                      /// Uplift Button
                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2 Members liked you',
                            style: subHeadingTextStyle2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: pinkColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  '$staticAsset/uplift2.png',
                                  scale: 3,
                                ),
                                sizeBoxw10,
                                Text(
                                  'Uplift',
                                  style: buttonTextStyleRed,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      sizeBox20,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Showing most recent first',
                          style: buttonTextStyleGrey.copyWith(
                            color: blackColor,
                          ),
                        ),
                      ),

                      sizeBox10,
                      // _userDetails(),
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _userDetails();
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 40.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : _staticScreen(context),
        );
      }),
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              18,
              53,
              18,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connections',
                  style: subHeadingTextWhite,
                ),
                sizeBox20,
                Image.asset(
                  '$dynamicAsset/Subtract.png',
                ),
                sizeBox20,
                Text(
                  'This is where you will see your Connections.',
                  style: subHeadingText1.copyWith(
                    color: blackColor,
                  ),
                ),
                sizeBox10,
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, right: 20),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'As soon someone likes you, will appear here! Keep liking more Hart members, the perfect connection is around the corner! ',
                          style: buttonTextStyle.copyWith(
                            color: greyColor2,
                          ),
                        ),
                        // TextSpan(
                        //   text: 'Hart',
                        //   style: subHeadingText1,
                        // ),
                        // TextSpan(
                        //   text:
                        //       ' members, a connection could be around in corner.',
                        //   style: buttonTextStyle.copyWith(
                        //     color: greyColor2,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _userDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 95.h,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: 90,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: AssetImage(
                      '$dynamicAsset/image.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        sizeBox10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vince',
                  style: bodyTextStyle,
                ),
                sizeBox10,
                Text(
                  '15 woman straight',
                  style: buttonTextStyleGrey,
                ),
                Text(
                  'Single, 8 km away, Last seen 30 min ago',
                  style: buttonTextStyleGrey,
                ),
              ],
            ),
            _likeButtons(),
          ],
        ),
      ],
    );
  }

  _likeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // model.disLike(model.index);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color:
                  //model.users[model.index].isDesLiked == true
                  //     ? greyColor2
                  // :
                  whiteColor,
              shape: BoxShape.circle,
              boxShadow: boxShadow,
            ),
            child: Image.asset(
              '$staticAsset/cross.png',
              // color:
              //  model.users[model.index].isDesLiked == true
              //     ? whiteColor
              //     : null,
              scale: 6,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () {
            // model.like(model.index);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color:
                  // model.users[model.index].isLiked == true
                  //     ? primaryColor
                  //     :
                  whiteColor,
              shape: BoxShape.circle,
              boxShadow: boxShadow,
            ),
            child:
                //  model.users[model.index].isLiked == true
                //     ?
                //     Image.asset(
                //   '$staticAsset/likeWhite.png',
                //   scale: 8,
                // )
                // :
                Image.asset(
              '$staticAsset/Like.png',
              scale: 6,
            ),
          ),
        )
      ],
    );
  }
}
