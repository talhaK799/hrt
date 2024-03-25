import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/models/conversation.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen.dart';
import 'package:hart/ui/screens/chatting_screen/group_chatting/group_info_screens/add_people/add_people_screen.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

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

  addpeople(context) {
    print(
        "admin===> ${currentUser.appUser.id!.trim()}=====> ${group.groupAdmin!.trim()}");
    if (currentUser.appUser.id == group.groupAdmin) {
      Navigator.push(
        context,
        PageFromRight(
          page: AddPeopleScreen(
            group: group,
          ),
        ),
      );
    } else {
      Get.snackbar('alert!', "only admin can add members");
    }
  }

  Message message = Message();
  removeMember(index) async {
    group.joinedUsers!.removeWhere(
      (element) => element == groupMembers[index].id,
    );

    if (!group.leftedUsers!.contains(groupMembers[index].id)) {
      group.leftedUsers!.add(groupMembers[index].id!);
    }

    setState(ViewState.busy);
    for (var user in groupMembers) {
      message.fromUserId = user.id;
      message.sendAt = FieldValue.serverTimestamp();
      message.textMessage = "removed from group";
      message.type = "removed";
      group.fromUserId = user.id;
      group.lastMessageAt = FieldValue.serverTimestamp();
      await _db.updateGroup(group, message);
    }

    setState(ViewState.idle);
    Conversation g = group;
    g.fromUserId = groupMembers[index].id;
    print("grp id ==> ${g.groupId}");
    bool isdeleted = await _db.deleteGroup(g);
    groupMembers.removeAt(index);
    if (isdeleted) {
      Get.to(
        RootScreen(
          index: 2,
        ),
      );
    }

    notifyListeners();
  }

  leaveGroup() async {
    group.joinedUsers!.removeWhere(
      (element) => element == currentUser.appUser.id,
    );

    if (!group.leftedUsers!.contains(currentUser.appUser.id)) {
      group.leftedUsers!.add(currentUser.appUser.id!);
    }

    setState(ViewState.busy);
    for (var user in groupMembers) {
      message.fromUserId = user.id;
      message.sendAt = FieldValue.serverTimestamp();
      message.textMessage = "left the group";
      message.type = "left";
      group.fromUserId = user.id;

      group.lastMessageAt = FieldValue.serverTimestamp();
      await _db.updateGroup(group, message);
    }

    setState(ViewState.idle);
    Conversation g = group;
    g.fromUserId = currentUser.appUser.id;
    print("grp id ==> ${g.groupId} and user id==> ${g.fromUserId}");
    bool isdeleted = await _db.deleteGroup(g);
    groupMembers.remove(currentUser.appUser);
    if (isdeleted) {
      Get.to(
        RootScreen(
          index: 2,
        ),
      );
    }
    notifyListeners();
  }

  changeMute(val) async {
    isMute = val;
    if (isMute) {
      if (!currentUser.appUser.muteIds!.contains(group.groupId!)) {
        currentUser.appUser.muteIds!.add(group.groupId!);
      }
    } else {
      currentUser.appUser.muteIds!.remove(group.groupId!);
    }

    await _db.updateUserProfile(currentUser.appUser);
    print('muteId==> ${currentUser.appUser.muteIds!.length}');
    notifyListeners();
  }
}
