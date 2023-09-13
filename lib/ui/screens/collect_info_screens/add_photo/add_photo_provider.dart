import 'dart:io';

import 'package:get/get.dart';
import 'package:hart/core/services/file_picker_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class AddPhotoProvider extends BaseViewModel {
  final _filePickerService = FilePickerService();

  File? image;

  pickImge() async {
    image = await _filePickerService.pickImage();
    if (image != null) {
      Get.snackbar('Success', 'image was picked');
    } else {
      Get.snackbar('Error', 'unable to pick image');
    }
    notifyListeners();
  }
}
