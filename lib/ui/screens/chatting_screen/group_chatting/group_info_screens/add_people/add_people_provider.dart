import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/models/group_members.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class AddPeopleProvider extends BaseViewModel {
  bool isEnable = false;
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  List<AppUser> matchedUsers = [];
  List<AppUser> addingUsers = [];

  List<AppUser> selectedUsers = [];

  AddPeopleProvider(group) {
    getLikedUsers(group);
  }

  getLikedUsers(Conversation group) async {
    matchedUsers = [];
    setState(ViewState.busy);
    matchedUsers = await db.getMatchedUsers(currentUser.appUser);
    setState(ViewState.idle);
    for (var i = 0; i < matchedUsers.length; i++) {
      matchedUsers[i].isSelected = false;
      if (group.joinedUsers!.contains(matchedUsers[i].id)) {
        addingUsers.add(matchedUsers[i]);
      }
    }
    filterSelectedUsers();
  }

  filterSelectedUsers() {
    selectedUsers = [];
    for (var i = 0; i < addingUsers.length; i++) {
      selectedUsers.add(addingUsers[i]);
    }
  }

  // List<GroupMembers> memebers = [
  //   GroupMembers(
  //     name: 'laiba',
  //     description: '20 woman straight',
  //   ),
  //   GroupMembers(
  //     name: 'laiba',
  //     description: '20 woman straight',
  //   ),
  //   GroupMembers(
  //     name: 'laiba',
  //     description: '20 woman straight',
  //   ),
  //   GroupMembers(
  //     name: 'laiba',
  //     description: '20 woman straight',
  //   ),
  //   GroupMembers(
  //     name: 'laiba',
  //     description: '20 woman straight',
  //   ),
  //   GroupMembers(
  //     name: 'laiba',
  //     description: '20 woman straight',
  //   ),
  // ];
  check(ind) {
    selectedUsers[ind].isSelected = !selectedUsers[ind].isSelected!;
    for (var i = 0; i < selectedUsers.length; i++) {
      if (selectedUsers[i].isSelected == true) {
        isEnable = true;
        break;
      } else {
        isEnable = false;
      }
    }
    notifyListeners();
  }
}
