import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class ChatInfoProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final _db = DatabaseService();
  bool isMute = false;
  Conversation chat = Conversation();

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
}
