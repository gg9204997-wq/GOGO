import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService._();

  static final ImagePickerService instance =
      ImagePickerService._();

  final ImagePicker _picker = ImagePicker();

  /// اختيار صورة من المعرض
  Future<File?> pickFromGallery() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// التقاط صورة بالكاميرا
  Future<File?> pickFromCamera() async {
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// نافذة اختيار المصدر
  Future<File?> showPicker() async {
    // سيتم استخدامها مع BottomSheet داخل الشاشة
    return null;
  }
}