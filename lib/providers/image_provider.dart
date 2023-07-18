// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:health_model/shared/storage_helper.dart';
// import 'package:image_picker/image_picker.dart';

// enum SubmissionStatus { idle, uploading, submitting, done }

// enum ImageMode { none, file, network }

// class PictureProvider extends ChangeNotifier {
//   ImageMode imagemode = ImageMode.none;
//   SubmissionStatus status = SubmissionStatus.idle;
//   File? imageFile;
//   String? imageUrl;
//   void pickImageFromGallery() async {
//     final picker = ImagePicker();

//     XFile? image =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//     if (image != null) {
//       imageFile = File(image.path);
//       imagemode = ImageMode.file;
//       submitData().then((value) => {
//             imageUrl = value,
//           });
//       // update();
//       ChangeNotifier();
//     }
//   }

//   Future<String> submitData() async {
//     if (imageFile == null) {
//       // ScaffoldMessenger.of(Get.context!)
//       //     .showSnackBar(SnackBar(content: Text("Please Pick the image first")));
//       return "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg";
//     }
//     status = SubmissionStatus.uploading;
//     // update();

//     ChangeNotifier();
//     var imageStatus = await FirebaseStorageHelper.uploadFileToFirebase(
//         imageFile: imageFile!, fileName: "hello");

//     await imageStatus.fold(
//         (l) => {
//               imageUrl = l,
//               status = SubmissionStatus.submitting,
//               // update(),

//               ChangeNotifier()
//             },
//         (r) => null);
//     return imageUrl!;
//   }
// }
