import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/collect_info_screens/about/user_about_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/idetity_screen/identity_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/name/name_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_screen.dart';

import '../../../custom_widgets/dialogs/auth_dialog.dart';
import '../../collect_info_screens/nick_name/nick_name_screen.dart';

class EditProfileProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseService();
  bool isIncoginito = false;
  DateTime? pickedDate;
  List<String> interst = [];
  String desire = '';

  // DateTime? dob;

  EditProfileProvider() {
    init();
  }

  init() async {
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    print('looking for ${currentUser.appUser.lookingFor!.first}');
    // dob = date.parse(currentUser.appUser.dob!);
    // setState(ViewState.idle);
    notifyListeners();
  }

  pickDate(context) async {
    pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1971),
      lastDate: DateTime(2090),
      dateFormat: "dd/MM/yyyy",
      looping: true,
    );
    notifyListeners();
  }

  updateProfile() async {
    currentUser.appUser.dob = pickedDate.toString();
    currentUser.appUser.desire!.add(desire);
    currentUser.appUser.lookingFor = interst;
    setState(ViewState.busy);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);

    setState(ViewState.idle);
    if (isUpdated) {
      Get.snackbar('success', 'profile updated');
    } else {
      Get.snackbar('error!', 'Unable to update profile');
    }
  }

  incognito(context, val) async {
    if (currentUser.appUser.isPremiumUser == true) {
      isIncoginito = val;
      notifyListeners();
      currentUser.appUser.isPrivatePhoto = val;
      await db.updateUserProfile(currentUser.appUser);
    } else {
      becomeMaestroDialog(context, "This feature is only for Premium users");
      // Get.snackbar('Alert!', 'This feature required premium subscription',
      //     colorText: redColor, backgroundColor: whiteColor);
    }

    notifyListeners();
  }

  changeNickName(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: NickNameScreen(
          isUpdate: true,
        ),
      ),
    );
    currentUser.appUser.nickName = update ?? currentUser.appUser.nickName;

    notifyListeners();
  }

  changeAbout(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: UserAboutScreen(
          isUpdate: true,
        ),
      ),
    );
    currentUser.appUser.about = update ?? currentUser.appUser.about;

    notifyListeners();
  }

  changeUserName(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: NameScreen(
          isUpdate: true,
        ),
      ),
    );
    currentUser.appUser.name = update ?? currentUser.appUser.name;

    notifyListeners();
  }

  changeDob(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: DOBScreen(
          isUpdate: true,
        ),
      ),
    );
    currentUser.appUser.dob = update ?? currentUser.appUser.dob;
    // currentUser.appUser.dob = await Get.to(
    //       DOBScreen(
    //         isUpdate: true,
    //       ),
    //     ) ??
    //     currentUser.appUser.dob;
    notifyListeners();
  }

  changeSexuality(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: IdentityScreen(
          isUpdate: true,
        ),
      ),
    );
    currentUser.appUser.identity = update ?? currentUser.appUser.identity;
    // currentUser.appUser.identity = await Get.to(
    //       IdentityScreen(
    //         isUpdate: true,
    //       ),
    //     ) ??
    //     currentUser.appUser.identity;
    notifyListeners();
  }

  changeDesires(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: FantasiesScreen(
          isUpdate: true,
        ),
      ),
    );
    print('updated desire list=====> ${update.first}');
    currentUser.appUser.desire = update ?? currentUser.appUser.desire;
    // currentUser.appUser.desire = await Get.to(
    //       FantasiesScreen(
    //         isUpdate: true,
    //       ),
    //     ) ??
    //     currentUser.appUser.desire;
    notifyListeners();
  }

  changeLookingFor(context) async {
    final update = await Navigator.push(
      context,
      PageFromRight(
        page: SelectGenderScreen(
          isUpdate: true,
        ),
      ),
    );
    currentUser.appUser.lookingFor = update ?? currentUser.appUser.lookingFor;
    // currentUser.appUser.lookingFor = await Get.to(
    //       SelectGenderScreen(
    //         isUpdate: true,
    //       ),
    //     ) ??
    //     currentUser.appUser.lookingFor;
    notifyListeners();
  }
}
