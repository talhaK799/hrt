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
import 'package:hart/ui/custom_widgets/dialogs/custom_snackbar.dart';
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
  // List<File> unUploadedImages = [];
  List<String> imagesUrls = [];
  List<String> currentImages = [];
  List<File> newImages = [];
  int userImagesCount = 0;

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
    userImagesCount = currentImages.length;
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
  removeImage(index) async {
    images[index] = PickImage();
    // List<File> imgs = [];
    // if (currentImages.length != 0) {
    if (index < userImagesCount) {
      currentImages.removeAt(index);
      print('current images ===> ${currentImages.length}');
      userImagesCount = userImagesCount - 1;
    } else {
      newImages.removeAt(index - userImagesCount);
      // imgs = newImages;
    }
    for (var i = 0; i < images.length; i++) {
      images[i] = PickImage();
    }
    for (var i = 0; i < userImagesCount + newImages.length; i++) {
      if (i < userImagesCount) {
        images[i].imgUrl = currentImages[i];
      } else {
        print('local image path ${newImages[i - userImagesCount].path}');
        images[i].image = newImages[i - userImagesCount];
      }
    }
    notifyListeners();
    // } else {
    //   unUploadedImages.removeAt(index);
    //   imgs = unUploadedImages;

    //   for (var i = 0; i < images.length; i++) {
    //     images[i] = PickImage();
    //   }
    //   for (var i = 0; i < imgs.length; i++) {
    //     images[i].image = imgs[i];

    //     print('selected $i path :=> ${imgs[i].path}');
    //   }
    //   notifyListeners();
    // }
  }

  void selectMultipleImages() async {
    // imageFileList = [];
    // isMultipleSelection = true;
    final List<XFile>? imagesList = await imagePicker.pickMultiImage();
    if (imagesList!.isNotEmpty) {
      for (int i = 0; i < imagesList.length; i++) {
        // if (currentImages.length != 0) {
        images[userImagesCount + newImages.length].image =
            File(imagesList[i].path);
        newImages.add(
          File(imagesList[i].path),
        );
        // if (userImagesCount != images.length) {
        //   userImagesCount = userImagesCount + 1;
        // }
        // } else {
        //   images[unUploadedImages.length].image = File(imagesList[i].path);
        //   unUploadedImages.add(
        //     File(imagesList[i].path),
        //   );
        // }
      }
      // notifyListeners();
    }
    // print(
    //   "Image List Length:" + unUploadedImages.length.toString(),
    // );
    notifyListeners();
  }

  pickImge() async {
    // isMultipleSelection = false;

    // if (currentImages.length != 0) {
    images[userImagesCount + newImages.length].image =
        await _filePickerService.pickImage();

    newImages.add(images[userImagesCount + newImages.length].image!);
    // } else {
    //   images[unUploadedImages.length].image =
    //       await _filePickerService.pickImage();
    //   if (images[unUploadedImages.length].image != null) {
    //     unUploadedImages.add(images[unUploadedImages.length].image!);
    //   } else {
    //     Get.snackbar('Error', 'unable to pick image');
    //   }
    // }

    notifyListeners();
  }

  addUserImages() async {
    if (newImages.length < 1) {
      customSnackBar('alert!', 'Image must be selected');
    } else {
      setState(ViewState.busy);
      // if (currentImages.length != 0) {
      imagesUrls = await fbStorage.uploadImagesList(newImages, 'User Images');
      for (var i = 0; i < imagesUrls.length; i++) {
        currentImages.add(imagesUrls[i]);
      }
      currentUser.images = currentImages;
      // } else {
      //   imagesUrls =
      //       await fbStorage.uploadImagesList(unUploadedImages, 'User Images');

      //   currentUser.images = imagesUrls;
      // }

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
