import 'package:flutter/material.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
            title: "Privacy Policy",
          ),

          ///
          /// Body
          ///
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Html(
                  data: """
                <h1>Privacy Policy </h1>
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
