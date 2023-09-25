import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/profile_screen/pair_profile/pair_profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/style.dart';

class PairProfileScreen extends StatelessWidget {
  const PairProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PairProfilePorvider(),
      child: Consumer<PairProfilePorvider>(builder: (context, model, child) {
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
                  CustomAppBar(title: 'Pair Profiles'),
                  sizeBox30,
                  SvgPicture.asset(
                    '$dynamicAsset/Subtract.svg',
                  ),
                  sizeBox20,
                  Text(
                    'To pair profile with a partner share this magic link with them.',
                    style: descriptionTextStyle.copyWith(
                      color: greyColor2,
                    ),
                  ),
                  sizeBox20,
                  Text(
                    'They won’t see your connections but you wil be able to create group chat with them for a shared connections.',
                    style: descriptionTextStyle.copyWith(
                      color: greyColor2,
                    ),
                  ),
                  sizeBox30,
                  CustomButton(title: 'SHARE MAGIC LINK', onTap: () {}),
                  sizeBox20,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
