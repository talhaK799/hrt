import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/screens/connection_screen/connections_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ConnectionScreen extends StatefulWidget {
  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionsProvider(),
      child: Consumer<ConnectionsProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: model.state == ViewState.busy
                ? Container()
                : model.currentUser.likingUsers.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(22, 50, 22, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            12.verticalSpace,
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
                                  '${model.currentUser.likingUsers.length} Members liked you',
                                  style: subHeadingTextStyle2,
                                ),
                                // Container(
                                //   padding: EdgeInsets.symmetric(
                                //     vertical: 10,
                                //     horizontal: 20,
                                //   ),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(24.r),
                                //     color: pinkColor,
                                //   ),
                                //   child: Row(
                                //     children: [
                                //       Image.asset(
                                //         '$staticAsset/uplift2.png',
                                //         scale: 3,
                                //       ),
                                //       sizeBoxw10,
                                //       Text(
                                //         'Uplift',
                                //         style: buttonTextStyleRed,
                                //       ),
                                //     ],
                                //   ),
                                // ),
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
                                itemCount: model.currentUser.likingUsers.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return _userDetails(
                                      model,
                                      model.currentUser.likingUsers[index],
                                      model.currentUser.matches[index]);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 40.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : model.state == ViewState.busy
                        ? Container(
                            color: whiteColor,
                            width: 1.sw,
                            height: 1.sh,
                          )
                        : _staticScreen(context),
          ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                  '$staticAsset/connection.png',
                ),
                sizeBox20,
                Text(
                  'This is where you will see your connections.',
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

  _userDetails(model, AppUser user, Matches match) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 95.h,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: user.images!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: 90,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //     user.images![index],
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: '$logoPath/logo4.png',
                  image: user.images![index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        sizeBox10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name!.toString(),
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
            ),
            _likeButtons(model, user, match),
          ],
        ),
      ],
    );
  }

  _likeButtons(ConnectionsProvider model, user, match) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              model.disLiked = true;
            });

            await Future.delayed(Duration(milliseconds: 500));

            setState(() {
              model.disLiked = false;
            });
            model.dilike(user, match);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: model.disLiked == true ? greyColor2 : whiteColor,
              shape: BoxShape.circle,
              boxShadow: boxShadow,
            ),
            child: Image.asset(
              '$staticAsset/cross.png',
              color: model.disLiked == true ? whiteColor : null,
              scale: 6,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              model.isLiked = true;
            });

            await Future.delayed(Duration(milliseconds: 500));

            setState(() {
              model.isLiked = false;
            });
            model.like(user, match, context);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: model.isLiked == true ? primaryColor : whiteColor,
              shape: BoxShape.circle,
              boxShadow: boxShadow,
            ),
            child: model.isLiked == true
                ? Image.asset(
                    '$staticAsset/likeWhite.png',
                    scale: 8,
                  )
                : Image.asset(
                    '$staticAsset/Like.png',
                    scale: 6,
                  ),
          ),
        )
      ],
    );
  }
}
