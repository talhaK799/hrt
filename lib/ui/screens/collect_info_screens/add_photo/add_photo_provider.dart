import 'package:get/get.dart';
import 'package:hart/core/models/imag.dart';
import 'package:hart/core/services/file_picker_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoProvider extends BaseViewModel {
  final _filePickerService = FilePickerService();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
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
      Get.snackbar('Success', 'image was picked');
    } else {
      Get.snackbar('Error', 'unable to pick image');
    }
    notifyListeners();
  }
}
