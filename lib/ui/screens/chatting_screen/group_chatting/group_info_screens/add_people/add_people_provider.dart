import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class AddPeopleProvider extends BaseViewModel {
  bool isEnable = false;
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  List<AppUser> matchedUsers = [];
  List<AppUser> addingUsers = [];
  Conversation group = Conversation();

  List<AppUser> selectedUsers = [];

  AddPeopleProvider(group) {
    this.group = group;
    getMembers();
  }

  getMembers() async {
    matchedUsers = [];
    setState(ViewState.busy);
    matchedUsers = await db.getMatchedUsers(currentUser.appUser);
    setState(ViewState.idle);
    for (var i = 0; i < matchedUsers.length; i++) {
      matchedUsers[i].isSelected = false;
      if (!group.joinedUsers!.contains(matchedUsers[i].id)) {
        /// should update joined users in every users of joined user list
        addingUsers.add(matchedUsers[i]);
      }
    }
    filterSelectedUsers();
  }

  filterSelectedUsers() {
    selectedUsers = [];
    for (var i = 0; i < addingUsers.length; i++) {
      if (addingUsers[i].isSelected == true) {
        selectedUsers.add(addingUsers[i]);
      }
    }
  }

  check(ind) {
    addingUsers[ind].isSelected = !addingUsers[ind].isSelected!;
    for (var i = 0; i < addingUsers.length; i++) {
      if (addingUsers.any((element) => element.isSelected == true)) {
        isEnable = true;
        // break;
      } else {
        isEnable = false;
      }
    }
    notifyListeners();
  }

  addNewMember() async {
    setState(ViewState.busy);
    filterSelectedUsers();
    for (var i = 0; i < selectedUsers.length; i++) {
      group.joinedUsers!.add(selectedUsers[i].id!);
      if (group.leftedUsers!.contains(selectedUsers[i].id)) {
        group.leftedUsers!.remove(selectedUsers[i].id!);
      }
    }
    // bool isAded = await db.updateGroup(group);

    for (var member in group.joinedUsers!) {
      group.fromUserId = member;
      await db.updateGroup(group);
    }

    setState(ViewState.busy);
    // if (isAded) {
    Get.offAll(RootScreen(
      index: 2,
    ));
    // Get.snackbar("Success", "New Member added successfully!");
    // }
  }
}
