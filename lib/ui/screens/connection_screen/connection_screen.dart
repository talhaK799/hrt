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
            backgroundColor: primaryColor,
            body: Stack(
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
            ));
      }),
    );
  }
}
