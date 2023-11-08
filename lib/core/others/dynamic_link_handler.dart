import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  createLink(String uid) async {
    print(uid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse('https://hartapp.page.link/$uid'),
      uriPrefix: 'https://hartapp.page.link',
      androidParameters: AndroidParameters(packageName: 'hart.flutter.app'),
      iosParameters: IOSParameters(bundleId: 'hart.flutter.app'),
    );

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildLink(parameters);
    print(refLink);
    return refLink.toString();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if (initialLink == null) return;
    } catch (e) {
      // Error
    }
  }

  // void handleDeepLink(String path) {

  // }
}
