import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class DobProvider extends BaseViewModel {
  DateTime? pickedDate;
  DateTime? now = DateTime.now();
  final currentUser = locator<AuthService>();
  final DatabaseService db = DatabaseService();
  int age = 0;

  pickDate(context) async {
    pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1971),
      lastDate: DateTime(2090),
      dateFormat: "dd/MM/yyyy",
      looping: true,
    );

    age = now!.year - pickedDate!.year;
    if (age > 18) {
      setState(ViewState.busy);
      currentUser.appUser.dob = pickedDate.toString();
      currentUser.appUser.age = age;
      bool isProfUpdated = await db.updateUserProfile(currentUser.appUser);
      if (!isProfUpdated) {
        Get.snackbar('error!!', 'profile not updated');
      } else {
        print('profile Updated');
      }
      setState(ViewState.idle);
    }
    print('this is the age $age');
    notifyListeners();
  }
}
