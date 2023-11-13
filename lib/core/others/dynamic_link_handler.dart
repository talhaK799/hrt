import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  createLink(String uid) async {
    print(uid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse('https://hartapp.page.link/user?userId=$uid'),
        uriPrefix: 'https://hartapp.page.link',
        androidParameters: AndroidParameters(packageName: 'hart.flutter.app'),
        iosParameters: IOSParameters(bundleId: 'hart.flutter.app'),
        socialMetaTagParameters: SocialMetaTagParameters());

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildLink(parameters);
    print(refLink);
    return refLink.toString();
  }

  initDeepLinks() async {
    try {
      PendingDynamicLinkData? initialLink = await dynamicLinks.getInitialLink();
      Uri? deepLink = initialLink?.link;
      print('Link data => ${deepLink}');
      if (deepLink == null) return;
      String id = deepLink.queryParameters['userId'] ?? 'nothing';
      // print('sending user id ${id}');
      return id;
    } catch (e) {
      print('error while initializing dynamicLink==> $e');
    }
  }
// Future handleDynamicLinks() async {
//     // 1. Get the initial dynamic link if the app is opened with a dynamic link
//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();

//     // 2. handle link that has been retrieved
//     _handleDeepLink(data!);

//     // 3. Register a link callback to fire if the app is opened up from the background
//     // using a dynamic link.
//     FirebaseDynamicLinks.instance.onLink;
//   }

//   void _handleDeepLink(PendingDynamicLinkData data) {
//     final Uri deepLink = data.link;

//       print('_handleDeepLink | deeplink: $deepLink');

//   }
  // void handleDeepLink(String path) {

  // }
}
