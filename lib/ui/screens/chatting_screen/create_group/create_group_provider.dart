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
  List<AppUser> matchedUsers = [];
  List<AppUser> selectedUsers = [];
  bool isEnable = false;
  Message message = Message();
  var uuid = Uuid();
  bool isCreated = false;

  CreateGroupProvider() {
    getLikedUsers();
  }

  init() async {
    setState(ViewState.busy);
    message = Message();
    conversation = Conversation();
    isEnable = false;
    isCreated = false;
    matchedUsers = [];
    selectedUsers = [];
    await getLikedUsers();
    setState(ViewState.idle);
  }

  check(ind) {
    matchedUsers[ind].isSelected = !matchedUsers[ind].isSelected!;
    for (var i = 0; i < matchedUsers.length; i++) {
      if (matchedUsers[ind].isSelected == true) {
        isEnable = true;
        break;
      } else {
        isEnable = false;
      }
    }
    notifyListeners();
  }

  getLikedUsers() async {
    matchedUsers = [];
    setState(ViewState.busy);
    matchedUsers = await db.getMatchedUsers(currentUser.appUser);
    setState(ViewState.idle);
    for (var i = 0; i < matchedUsers.length; i++) {
      matchedUsers[i].isSelected = false;
    }
    filterSelectedUsers();
  }

  filterSelectedUsers() {
    selectedUsers = [];
    for (var i = 0; i < matchedUsers.length; i++) {
      selectedUsers.add(matchedUsers[i]);
    }
  }

  createGroup() async {
    if (selectedUsers.isNotEmpty) {
      setState(ViewState.busy);
      conversation.lastMessage = "created";
      conversation.conversationId = conversation.conversationId ?? uuid.v4();
      conversation.groupId = uuid.v4();
      conversation.lastMessageAt = DateTime.now();
      conversation.fromUserId = currentUser.appUser.id;
      conversation.isGroupChat = true;
      // conversation.imageUrl = currentUser.appUser.images!.first;
      conversation.isMessageSeen = false;
      conversation.leftedUsers = [];
      conversation.joinedUsers = [];
      conversation.joinedUsers!.add(currentUser.appUser.id!);
      message.fromUserId = currentUser.appUser.id;
      message.sendAt = DateTime.now();
      message.textMessage = "Group created";
      message.type = "GroupCreated";

      for (var i = 0; i < selectedUsers.length; i++) {
        conversation.joinedUsers!.add(selectedUsers[i].id!);
      }

      await db.createGroup(conversation, message);

      for (var i = 0; i < selectedUsers.length; i++) {
        message.fromUserId = selectedUsers[i].id;
        message.sendAt = DateTime.now();
        message.textMessage = "Added to group";
        message.type = "added";
        conversation.lastMessage = "Added";
        conversation.lastMessageAt = DateTime.now();
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
