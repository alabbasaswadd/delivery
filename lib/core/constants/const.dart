import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum OrderStateEnum {
  pending, // جاري المعالجة
  scheduled, // تم الجدولة
  inTransit, //جاري التوصيل
  delivered, //تم التوصيل
  cancelled, // تم الإلغاء
  failed, //فشل التوصيل
}

// File? selectedImage;
// final ImagePicker _picker = ImagePicker();
// Future<void> pickImage() async {
//   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     setState(() {
//       selectedImage = File(pickedFile.path);
//     });
//   }
// }
