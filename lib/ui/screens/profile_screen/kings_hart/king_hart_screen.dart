import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loaders/red_hart_10sec.dart';
import 'package:hart/ui/custom_widgets/offer_container.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: RedHart10SecLoader(),
          child: Scaffold(
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
                      style: subHeadingText1.copyWith(
                        fontSize: 18.sp,
                      ),
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
                    SizedBox(
                      // height: 130.h,
                      child: Row(
                        // shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < model.spanks.length; i++)
                            Expanded(
                              child: Offers(
                                title: '${model.spanks[i].no_spanks} Spanks',
                                price: '\$ ${model.spanks[i].price!.toInt()}',
                                isSelected: model.spanks[i].isSelected,
                                offer: model.spanks[i].offer,
                                onTap: () {
                                  model.select(i);
                                },
                              ),
                            ),
                          // Expanded(
                          //   child: Offers(
                          //     title: '5 Spank',
                          //     price: '€ 15',
                          //     offer: '20 % OFF',
                          //     selectionIndex: 1,
                          //     currentIndex: model.currentIndex,
                          //     onTap: () {
                          //       model.select(1);
                          //     },
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Offers(
                          //     title: '10 Spank',
                          //     price: '€ 25',
                          //     offer: '50 % OFF',
                          //     selectionIndex: 2,
                          //     currentIndex: model.currentIndex,
                          //     onTap: () {
                          //       model.select(2);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    sizeBox30,
                    Text(
                      'Become Maestro and get 1 Free Spank a day',
                      style: descriptionTextStyle.copyWith(
                          color: lightRed, fontSize: 13.sp),
                    ),
                    sizeBox30,
                    CustomButton(
                      title: 'CONTINUE',
                      onTap: () {
                        model.makePayment(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ignore: must_be_immutable

