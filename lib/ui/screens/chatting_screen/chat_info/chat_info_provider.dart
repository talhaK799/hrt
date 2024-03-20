import 'package:get/get.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class ChatInfoProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final _db = DatabaseService();
  bool isMute = false;
  bool isBlocked = false;
  Conversation chat = Conversation();
  // AppUser blockingUser = AppUser();

  ChatInfoProvider(chating) {
    chat = chating;
    
  }

  changeMute(val) async {
    isMute = val;

    if (isMute) {
      if (!currentUser.appUser.muteIds!.contains(chat.toUserId)) {
        currentUser.appUser.muteIds!.add(chat.toUserId!);
      }
    } else {
      currentUser.appUser.muteIds!.remove(chat.toUserId);
    }

    await _db.updateUserProfile(currentUser.appUser);
    print('muteId==> ${currentUser.appUser.muteIds!.length}');
    notifyListeners();
  }

  blockUser() async {
    if (!currentUser.appUser.blockedUsers!.contains(chat.toUserId)) {
      isBlocked = true;
      currentUser.appUser.blockedUsers!.add(chat.toUserId!);
    } else {
      isBlocked = false;
      currentUser.appUser.blockedUsers!.remove(chat.toUserId);
    }

    await _db.updateUserProfile(currentUser.appUser);
    print('muteId==> ${currentUser.appUser.blockedUsers!.length}');
    Get.to(RootScreen(
      index: 2,
    ));
    notifyListeners();
  }
}
