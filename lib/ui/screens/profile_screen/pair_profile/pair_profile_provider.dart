import 'package:hart/core/others/dynamic_link_handler.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:share_plus/share_plus.dart';

class PairProfilePorvider extends BaseViewModel {
  int currentIndex = 0;
  final auth = locator<AuthService>();
  DynamicLinkHandler linkHandler = DynamicLinkHandler();

  select(index) {
    currentIndex = index;
    notifyListeners();
  }

  shareLink() async {
    await linkHandler.createLink(auth.appUser.id!).then((value) {
      Share.share(
        'Join me on Feeld as my partner. You need to be logged in and tap on this link to accept the invite $value',
      );
    });

    notifyListeners();
  }
}
