import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class GroupDetailProvider extends BaseViewModel {
  bool isMute = false;
  List<AppUser> groupMembers = [];
  final currentUser = locator<AuthService>();
  AppUser member = AppUser();
  Conversation group = Conversation();
  final _db = DatabaseService();

  GroupDetailProvider(group) {
    this.group = group;
    getMembers();
  }

  getMembers() async {
    groupMembers = [];
    setState(ViewState.busy);
    for (var i = 0; i < group.joinedUsers!.length; i++) {
      member = AppUser();
      member = await _db.getAppUser(group.joinedUsers![i]);

      groupMembers.add(member);
    }
    setState(ViewState.idle);
  }

  removeMember(index) async {
    group.joinedUsers!.removeWhere(
      (element) => element == groupMembers[index].id,
    );

    setState(ViewState.busy);
    for (var user in groupMembers) {
      group.fromUserId = user.id;
      await _db.updateGroup(group);
    }

    setState(ViewState.idle);
    groupMembers.removeAt(index);
    notifyListeners();
  }

  leaveGroup() async {
    group.joinedUsers!.removeWhere(
      (element) => element == currentUser.appUser.id,
    );

    setState(ViewState.busy);
    for (var user in groupMembers) {
      group.fromUserId = user.id;
      await _db.updateGroup(group);
    }

    setState(ViewState.idle);
    groupMembers.remove(currentUser.appUser);
    notifyListeners();
  }

  changeMute(val) {
    isMute = val;
    notifyListeners();
  }
}
