import 'dart:io';

import 'package:get/get.dart';
import 'package:hart/core/models/imag.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/file_picker_service.dart';
import 'package:hart/core/services/firebase_storage_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/permissions/permission_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums/view_state.dart';

class AddPhotoProvider extends BaseViewModel {
  final _filePickerService = FilePickerService();
  DatabaseService _db = DatabaseService();
  final fbStorage = locator<FirebaseStorageService>();
  final currentUser = locator<AuthService>().appUser;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<File>? selectedImages = [];
  List<String>? imagesUrls = [];

  bool isMultipleSelection = false;

  List<PickImage> images = [
    PickImage(),
    PickImage(),
    PickImage(),
    PickImage(),
    PickImage(),
    PickImage(),
    PickImage(),
    PickImage(),
    PickImage(),
  ];

  void selectImages() async {
    imageFileList = [];
    isMultipleSelection = true;
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    notifyListeners();
  }

  pickImge(index) async {
    isMultipleSelection = false;
    images[index].image = await _filePickerService.pickImage();
    if (images[index].image != null) {
      selectedImages!.add(images[index].image!);
    } else {
      Get.snackbar('Error', 'unable to pick image');
    }
    notifyListeners();
  }

  addUserImages() async {
    setState(ViewState.busy);
    imagesUrls=await fbStorage.uploadImagesList(selectedImages!, 'User Images');
    // for (var element in selectedImages!) {
    //   if (element.isSelected == true) {
    //     selectedItems.add(element.title!);
    //   }
    // }

    currentUser.images = imagesUrls;
    
    bool isUpdated = await _db.updateUserProfile(currentUser);
    setState(ViewState.idle);
    if (isUpdated) {
      Get.to(
        PermissionScreen(),
      );
    }
  }
}
