import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';
import 'package:uuid/uuid.dart';

class AddPeopleProvider extends BaseViewModel {
  bool isEnable = false;
  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  List<AppUser> matchedUsers = [];
  List<AppUser> addingUsers = [];
  Conversation group = Conversation();

  Message message = Message();

  var uuid = Uuid();

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
    filterSelectedUsers();
    if (selectedUsers.isNotEmpty) {
      setState(ViewState.busy);
      group.lastMessage = "Member added";
      group.conversationId = group.conversationId ?? uuid.v4();
      group.groupId = uuid.v4();
      group.lastMessageAt = FieldValue.serverTimestamp();
      group.fromUserId = currentUser.appUser.id;
      group.isGroupChat = true;
      // conversation.imageUrl = currentUser.appUser.images!.first;
      group.isMessageSeen = false;
      group.leftedUsers = [];
      group.joinedUsers = [];
      group.joinedUsers!.add(currentUser.appUser.id!);
      message.fromUserId = currentUser.appUser.id;
      message.sendAt = FieldValue.serverTimestamp();
      message.textMessage = "You Added a Member";
      message.type = "added";
      for (var i = 0; i < selectedUsers.length; i++) {
        group.joinedUsers!.add(selectedUsers[i].id!);
        if (group.leftedUsers!.contains(selectedUsers[i].id)) {
          group.leftedUsers!.remove(selectedUsers[i].id!);
        }
      }
      await db.updateGroup(group, message);

      for (var member in selectedUsers) {
        message.fromUserId = member.id;
        message.sendAt = FieldValue.serverTimestamp();
        message.textMessage = "Added to group";
        message.type = "added";
        group.lastMessage = "Added";
        group.lastMessageAt = FieldValue.serverTimestamp();
        group.fromUserId = member.id;
        await db.updateGroup(group, message);
      }

      setState(ViewState.idle);
      // if (isAded) {
      Get.offAll(RootScreen(
        index: 2,
      ));
      // Get.snackbar("Success", "New Member added successfully!");
      // }
    }
  }
}
