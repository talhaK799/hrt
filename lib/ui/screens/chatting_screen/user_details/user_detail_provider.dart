import 'package:get/get.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/report_user.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class UserDetailProvider extends BaseViewModel {
  int dotIndex = 0;
  final currentUser = locator<AuthService>();
  final db = DatabaseService();

  ReportedUser reportedConversations = ReportedUser();

  int reportsOptionsIndex = -1;
  List<String> reportsOptions = [
    "This profile has inappropiate photos or content",
    "This is a fake account",
    "They are underage",
    "They're abusive or harassing",
    "They're solicting me or others",
    "Doesn't match search setting",
    "Something else",
  ];

  updateIndex(index) {
    dotIndex = index;
    print('current index==> $index=====> $dotIndex');
    notifyListeners();
  }

  reportUser(AppUser user) async {
    if (reportsOptionsIndex >= 0) {
      reportedConversations.reason = reportsOptions[reportsOptionsIndex];
      reportedConversations.reportedUserId = user.id;
      reportedConversations.reportingUserId = currentUser.appUser.id;
      reportedConversations.reportedAt = DateTime.now();
      bool isreported = await db.reportedConversations(reportedConversations);
      if (isreported == true) {
        Get.back();
        Get.snackbar('Alert!', 'User Reported');
      }
      reportsOptionsIndex = -1;
    } else {
      Get.snackbar('Alert!', 'Please select reason');
    }
  }
}
