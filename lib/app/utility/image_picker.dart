import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePickerService _singleton = ImagePickerService._internal();

  factory ImagePickerService() {
    return _singleton;
  }

  ImagePickerService._internal();

  static Future<XFile?> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  static Future<XFile?> pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
