import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50, left: 25),
      child: Column(
        children: [
          ///
          /// AppBar
          ///

          CustomAppBar(
            title: "Terms And Conditions",
          ),

          ///
          /// Body
          ///
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Html(
                  data: """
                <h1>Terms And Conditions </h1>
                Lorem ipsum dolor sit amet consectetur. Nulla ut proin diam est ac quam pretium lacus mollis. Pretium quam ac nibh nibh. Nec neque pulvinar risus sit consectetur cursus ut etiam risus...
                
                
                """,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
