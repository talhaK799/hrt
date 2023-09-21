import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class DobProvider extends BaseViewModel {
  DateTime? pickedDate;
  DateTime? now = DateTime.now();
  int age = 0;

  pickDate(context) async {
    pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2002),
      firstDate: DateTime(2000),
      lastDate: DateTime(2090),
      dateFormat: "dd/MM/yyyy",
      looping: true,
    );
    age = now!.year - pickedDate!.year;
    print('this is the age $age');
    notifyListeners();
  }
}
