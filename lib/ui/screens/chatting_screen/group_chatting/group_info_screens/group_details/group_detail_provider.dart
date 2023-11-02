import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class GroupDetailProvider extends BaseViewModel {
  bool isMute = false;
  List<AppUser> groupMembers = [];
  AppUser member = AppUser();
  final _db = DatabaseService();

  GroupDetailProvider(group) {
    getMembers(group);
  }

  getMembers(Conversation group) async {
    groupMembers = [];
    setState(ViewState.busy);
    for (var i = 0; i < group.joinedUsers!.length; i++) {
      member = AppUser();
      member = await _db.getAppUser(group.joinedUsers![i]);

      groupMembers.add(member);
    }
    setState(ViewState.idle);
  }

  changeMute(val) {
    isMute = val;
    notifyListeners();
  }
}
