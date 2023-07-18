// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';

// class FirebaseStorageHelper {
//   static Future<Either<String?, String>> uploadFileToFirebase(
//       {required File imageFile, required String fileName}) async {
//     Uint8List bytes = imageFile.readAsBytesSync();
//     String? imageUrl;
//     try {
//       UploadTask uploadTask;

//       Reference ref = FirebaseStorage.instance
//           .ref()
//           .child('company_logo')
//           .child('/$fileName');

//       final metadata = SettableMetadata(contentType: 'image/jpeg');
//       uploadTask = ref.putData(bytes, metadata);

//       await uploadTask;
//       imageUrl = await ref.getDownloadURL();
//     } catch (e) {
//       print(e);
//       return Right(e.toString());
//     }
//     // ignore: unnecessary_null_comparison
//     if (imageUrl == null) {
//       return const Right('_r');
//     }
//     return Left(imageUrl);
//   }
// }
