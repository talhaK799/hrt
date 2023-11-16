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

class CreateGroupProvider extends BaseViewModel {
  final db = DatabaseService();
  Conversation conversation = Conversation();
  final currentUser = locator<AuthService>();
  List<AppUser> likedUsers = [];
  List<AppUser> matchedUsers = [];
  List<AppUser> selectedUsers = [];
  bool isEnable = false;
  Message message = Message();
  var uuid = Uuid();
  bool isCreated = false;

  CreateGroupProvider() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    message = Message();
    conversation = Conversation();
    isEnable = false;
    isCreated = false;
    likedUsers = [];
    matchedUsers = [];
    selectedUsers = [];
    await getLikedUsers();
    setState(ViewState.idle);
  }

  check(ind) {
    matchedUsers[ind].isSelected = !matchedUsers[ind].isSelected!;
    if (matchedUsers.any((element) => element.isSelected == true)) {
      isEnable = true;
    } else {
      isEnable = false;
    }

    // for (var i = 0; i < matchedUsers.length; i++) {
    //   if (matchedUsers[ind].isSelected == true) {
    //     isEnable = true;
    //     break;
    //   } else {
    //     isEnable = false;
    //   }
    // }
    notifyListeners();
  }

  getLikedUsers() async {
    likedUsers = [];
    matchedUsers = [];
    setState(ViewState.busy);
    likedUsers = await db.getMatchedUsers(currentUser.appUser);
    setState(ViewState.idle);
    for (var i = 0; i < likedUsers.length; i++) {
      likedUsers[i].isSelected = false;
      if (likedUsers[i].likedUsers!.contains(currentUser.appUser.id)) {
        print('current user${i + 1} likes===>${likedUsers[i].id}');
        print('other user likes current user===>${likedUsers[i].id}');
        if (!matchedUsers.contains(likedUsers[i])) {
          matchedUsers.add(likedUsers[i]);
        }
      }
    }
    // filterSelectedUsers();
  }

  filterSelectedUsers() {
    selectedUsers = [];
    for (var i = 0; i < matchedUsers.length; i++) {
      if (matchedUsers[i].isSelected == true) {
        selectedUsers.add(matchedUsers[i]);
      }
    }
  }

  createGroup() async {
    filterSelectedUsers();
    if (selectedUsers.isNotEmpty) {
      setState(ViewState.busy);
      conversation.lastMessage = "created";
      conversation.conversationId = conversation.conversationId ?? uuid.v4();
      conversation.groupId = uuid.v4();
      conversation.lastMessageAt = FieldValue.serverTimestamp();
      conversation.fromUserId = currentUser.appUser.id;
      conversation.isGroupChat = true;
      // conversation.imageUrl = currentUser.appUser.images!.first;
      conversation.isMessageSeen = false;
      conversation.leftedUsers = [];
      conversation.joinedUsers = [];
      conversation.joinedUsers!.add(currentUser.appUser.id!);
      message.fromUserId = currentUser.appUser.id;
      message.sendAt = FieldValue.serverTimestamp();
      message.textMessage = "Group created";
      message.type = "GroupCreated";

      for (var i = 0; i < selectedUsers.length; i++) {
        conversation.joinedUsers!.add(selectedUsers[i].id!);
      }

      await db.createGroup(conversation, message);

      for (var i = 0; i < selectedUsers.length; i++) {
        message.fromUserId = selectedUsers[i].id;
        message.sendAt = FieldValue.serverTimestamp();
        message.textMessage = "Added to group";
        message.type = "added";
        conversation.lastMessage = "Added";
        conversation.lastMessageAt = FieldValue.serverTimestamp();
        conversation.fromUserId = selectedUsers[i].id;
        isCreated = await db.createGroup(conversation, message);
      }

      setState(ViewState.idle);

      if (isCreated) {
        Get.offAll(RootScreen(
          index: 2,
        ));
        Get.snackbar("Success", "Group created successfully!");
      }
    }
  }
}
