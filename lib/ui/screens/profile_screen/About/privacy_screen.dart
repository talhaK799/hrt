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
              data: """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HART - PRIVACY POLICY</title>
</head>
<body>

    <h1>Last Modified: 14/11/2023</h1>

    <p>Hart Ltd ("Hart", "we", "our", or "us") is committed to protecting and respecting your privacy.</p>

    <h2>OUR APPROACH TO PRIVACY</h2>
    <p>This privacy policy sets out how we collect, store, process, transfer, share and use data that identifies or is associated with you ("personal information") when you use our app(s), any website operated by us (including https://hart.co/), any services we provide or otherwise interact with us (together the “Services”).</p>

    <p>If you are a resident of the United States of America (US), please see Annex 3 [LINK] for more information about the categories of personal data that we may collect and the categories of sources from which we may collect such personal data.</p>

    <h2>ABOUT US</h2>
    <p>Hart Ltd (company no. 08916634) is the data controller of the personal information we hold about you.</p>

    <p>Our registered and postal address is James Watson House Montgomery Way, Rosehill Industrial Estate, Carlisle, England, CA1 2UU.</p>

    <p>We are registered as a data controller with the UK Information Commissioner’s Office under data protection registration number ZA239970.</p>

    <p>Our data protection officer can be contacted at <a href="mailto:dpo@hart.co">dpo@hart.co</a>.</p>

    <h2>PERSONAL INFORMATION WE COLLECT ABOUT YOU AND HOW WE USE IT</h2>
    <p>The table at Annex 1 [LINK] sets out the categories of personal information we collect about you and how we use that information...</p>

    <h2>DATA RETENTION</h2>
    <p>We will only retain your personal information for as long as reasonably necessary to fulfill the purposes we collected it for...</p>

    <h2>RECIPIENTS OF PERSONAL INFORMATION</h2>
    <p>We may share your personal information with the following (as required in accordance with the uses set out in Annex 1 [LINK] or as otherwise described below):</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>MARKETING AND ADVERTISING</h2>
    <p>From time to time, we may contact you with information about the Services, including sending you marketing messages and asking for your feedback on our Services.</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>STORING AND TRANSFERRING YOUR PERSONAL INFORMATION</h2>
    <p>Security. We implement appropriate technical and organizational measures, including encryption, to protect your personal information against accidental or unlawful access...</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>YOUR RIGHTS IN RESPECT OF YOUR PERSONAL INFORMATION</h2>
    <p>In accordance with applicable privacy law, you have the following rights in respect of your personal information that we hold:</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>COOKIES AND SIMILAR TECHNOLOGIES</h2>
    <p>Our website uses cookies and similar technologies to distinguish you from other users of our Services. Please refer to our Cookies Policy at Annex 2 [LINK] for more information...</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>INTEREST- BASED ADVERTISING</h2>
    <p>We participate in interest-based advertising and use third-party advertising companies to serve you targeted advertisements based on your online browsing history and your interests...</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>LINKS TO THIRD- PARTY SITES</h2>
    <p>Our app and/or website(s) may, from time to time, contain links to and from third-party websites...</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>CHANGES TO THIS POLICY</h2>
    <p>We may update this privacy policy from time to time, so you should review this page periodically...</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>CHILDREN (17 and under)</h2>
    <p>You must not use our Services if you are under the age of 18...</p>

    <!-- ... (continue replacing "Feeld" with "Hart" throughout the document) ... -->

    <h2>CONTACTING US</h2>
    <p>If you have any questions, comments and requests regarding this Privacy Policy, you can contact us:</p>

    <p>By post:</p>
    <address>
        FAO Legal Department<br>
        James Watson House Montgomery Way,<br>
        Rosehill Industrial Estate,<br>
        Carlisle,<br>
        United Kingdom,<br>
        CA1 2UU
    </address>

    <p>By email: <a href="mailto:privacy@hart.co">privacy@hart.co</a></p>

    <p>This privacy policy was last modified on [INSERT DATE] 2023.</p>

</body>
</html>
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
