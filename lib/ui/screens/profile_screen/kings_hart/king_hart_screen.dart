import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/style.dart';

class KingHartScreen extends StatelessWidget {
  const KingHartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KingHartProvider(),
      child: Consumer<KingHartProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                60,
                24,
                40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAppBar(title: 'Kings HARTS'),
                  sizeBox30,
                  SvgPicture.asset(
                    '$staticAsset/Character.svg',
                  ),
                  sizeBox20,
                  Text(
                    'Let them know with a Spank',
                    style: subHeadingText1,
                  ),
                  sizeBox10,
                  Text(
                    'Notify a member you like immediately and increase your chances of connecting.',
                    textAlign: TextAlign.center,
                    style: descriptionTextStyle.copyWith(
                      color: lightRed,
                    ),
                  ),
                  sizeBox20,
                  Container(
                    height: 0.2.sh,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Offers(
                          title: '1 Spank',
                          price: '€ 5',
                          offer: '20 % OFF',
                          selectionIndex: 0,
                          currentIndex: model.currentIndex,
                          isOffered: false,
                          onTap: () {
                            model.select(0);
                          },
                        ),
                        Offers(
                          title: '5 Spank',
                          price: '€ 15',
                          offer: '20 % OFF',
                          selectionIndex: 1,
                          currentIndex: model.currentIndex,
                          onTap: () {
                            model.select(1);
                          },
                        ),
                        Offers(
                          title: '10 Spank',
                          price: '€ 25',
                          offer: '50 % OFF',
                          selectionIndex: 2,
                          currentIndex: model.currentIndex,
                          onTap: () {
                            model.select(2);
                          },
                        ),
                      ],
                    ),
                  ),
                  sizeBox30,
                  Text(
                    'Become Maestro and get 1 Free Spank a day',
                    style: descriptionTextStyle.copyWith(
                      color: lightRed,
                    ),
                  ),
                  sizeBox20,
                  CustomButton(title: 'CONTINUE', onTap: () {}),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class Offers extends StatelessWidget {
  String? title;
  String? price;
  String? offer;
  bool? isOffered;
  int? selectionIndex;
  int? currentIndex;
  final onTap;

  Offers({
    this.offer,
    this.price,
    this.title,
    this.isOffered = true,
    this.selectionIndex,
    this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                  color:
                      selectionIndex == currentIndex ? pinkColor : whiteColor,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: pinkColor2,
                  )),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title!,
                      style: subtitleText.copyWith(
                        color: lightRed,
                      ),
                    ),
                    Text(
                      price!,
                      style: subHeadingText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          isOffered == true
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: primaryColor,
                    ),
                    child: Text(
                      offer!,
                      style: buttonTextStyle2.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
