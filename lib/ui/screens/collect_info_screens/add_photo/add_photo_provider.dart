import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/models/imag.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/file_picker_service.dart';
import 'package:hart/core/services/firebase_storage_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/style.dart';
import '../../../../core/enums/view_state.dart';

class AddPhotoProvider extends BaseViewModel {
  final _filePickerService = FilePickerService();
  DatabaseService _db = DatabaseService();
  final fbStorage = locator<FirebaseStorageService>();
  final currentUser = locator<AuthService>().appUser;
  final ImagePicker imagePicker = ImagePicker();
  bool isUpdation = false;
  // List<XFile>? imageFileList = [];
  List<File> selectedImages = [];
  List<String> imagesUrls = [];
  List<String> currentImages = [];
  List<File> networkImages = [];
  int count = 0;

  // PickImage pickImage = PickImage();

  AddPhotoProvider(profUpdate) {
    isUpdation = profUpdate;
    print('updation==> $isUpdation');
    init();
  }

  init() {
    setState(ViewState.busy);
    currentImages = currentUser.images ?? [];
    for (var i = 0; i < currentImages.length; i++) {
      images[i].imgUrl = currentImages[i];
    }
    count = currentUser.images!.length;
    setState(ViewState.idle);
  }

  // bool isMultipleSelection = false;

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
// [1 , null ,3, 4, 5]
  removeImage(index) async {
    images[index] = PickImage();
    List<File> imgs = [];
    if (selectedImages.length == 0) {
      // networkImages.removeAt(index);
      // imgs = networkImages;
      if (index < count) {
        currentImages.removeAt(index);
        count = count - 1;
      } else {
        networkImages.removeAt(index - count);
        imgs = networkImages;
        // count = count - 1;
      }
    } else {
      selectedImages.removeAt(index);
      imgs = selectedImages;
    }
    for (var i = 0; i < images.length; i++) {
      images[i] = PickImage();
    }
    for (var i = 0; i < count; i++) {
      images[i].imgUrl = currentImages[i];
      print('imgUrls ===> ${images[i].imgUrl}');
    }
    for (var i = 0; i < imgs.length; i++) {
      images[i].image = imgs[i];

      print('selected $i path :=> ${imgs[i].path}');
      // await Future.delayed(Duration(seconds: 1));
    }

    // print('selected images===> ${imgs.length}');

    notifyListeners();
  }

  void selectImages() async {
    // imageFileList = [];
    // isMultipleSelection = true;
    final List<XFile>? imagesList = await imagePicker.pickMultiImage();
    if (imagesList!.isNotEmpty) {
      // selectedImages!.add(File(imagesList[2].path));
      for (int i = 0; i < imagesList.length; i++) {
        if (selectedImages.length == 0) {
          images[count].image = File(imagesList[i].path);
          networkImages.add(
            File(imagesList[i].path),
          );
          if (count != images.length) {
            count = count + 1;
          }
        } else {
          images[selectedImages.length].image = File(imagesList[i].path);
          selectedImages.add(
            File(imagesList[i].path),
          );
        }
      }
      notifyListeners();
    }
    print(
      "Image List Length:" + selectedImages.length.toString(),
    );
    notifyListeners();
  }

  pickImge() async {
    // isMultipleSelection = false;
    if (selectedImages.length == 0) {
      images[count].image = await _filePickerService.pickImage();

      networkImages.add(images[count].image!);
      if (count != images.length) {
        count = count + 1;
      }
    } else {
      images[selectedImages.length].image =
          await _filePickerService.pickImage();
      if (images[selectedImages.length].image != null) {
        selectedImages.add(images[selectedImages.length].image!);
      } else {
        Get.snackbar('Error', 'unable to pick image');
      }
    }

    notifyListeners();
  }

  addUserImages() async {
    if (selectedImages.length < 1 && networkImages.length < 1) {
      Get.snackbar(
        'Error!',
        '',
        colorText: primaryColor,
        messageText: Text(
          'Images must be selected',
          style: miniText.copyWith(
            color: lightRed,
            fontSize: 15.sp,
          ),
        ),
      );
    } else {
      setState(ViewState.busy);
      if (selectedImages.length == 0) {
        imagesUrls =
            await fbStorage.uploadImagesList(networkImages, 'User Images');
        for (var i = 0; i < imagesUrls.length; i++) {
          currentImages.add(imagesUrls[i]);
        }
        currentUser.images = currentImages;
      } else {
        imagesUrls =
            await fbStorage.uploadImagesList(selectedImages, 'User Images');

        currentUser.images = imagesUrls;
      }

      bool isUpdated = await _db.updateUserProfile(currentUser);
      setState(ViewState.idle);
      if (isUpdated) {
        if (isUpdation == true) {
          //profile update
          Get.back();
        } else {
          Get.offAll(
            RootScreen(),
          );
        }
      }
    }
  }
}
