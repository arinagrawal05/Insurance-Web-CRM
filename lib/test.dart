import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html' as html; // For web specific handling
import 'dart:typed_data';

import 'package:health_model/shared/exports.dart'; // For handling file bytes

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? _pickedFileBytes;
  html.File? _pickedFile;
  bool _isUploading = false;
  Future<void> _pickFile() async {
    try {
      final html.FileUploadInputElement uploadInput =
          html.FileUploadInputElement();
      uploadInput.accept = 'application/pdf,image/*';
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        final html.File file = uploadInput.files!.first;
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            _pickedFileBytes = reader.result as Uint8List?;
            _pickedFile = file;
          });
        });

        reader.readAsArrayBuffer(file);
      });
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  Future<void> _uploadFile() async {
    if (_pickedFileBytes == null || _pickedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      String fileName =
          'uploads/${DateTime.now().millisecondsSinceEpoch}-${_pickedFile!.name}';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = storageRef.putData(_pickedFileBytes!);

      final snapshot = await uploadTask;
      final downloadURL = await snapshot.ref.getDownloadURL();
      print('Upload successful. Download URL: $downloadURL');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Upload successful! Download URL: $downloadURL')),
      );
    } catch (e) {
      print('Upload failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Picker and Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_pickedFile != null) Text('Picked File: ${_pickedFile!.name}'),
            if (_pickedFile != null)
              Text('Picked Path: ${_pickedFile!.relativePath}'),
            if (_pickedFile != null) Text('Picked Type: ${_pickedFile!.type}'),
            if (_pickedFile != null)
              Text(
                  'Picked Time: ${dateTimetoText(_pickedFile!.lastModifiedDate)}'),
            if (_pickedFile != null) Text('Picked Size: ${_pickedFile!.size}'),
            if (_isUploading) customCircularLoader(term: "uploading doc"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickedFileBytes != null && !_isUploading
                  ? _uploadFile
                  : null,
              child: Text('Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
