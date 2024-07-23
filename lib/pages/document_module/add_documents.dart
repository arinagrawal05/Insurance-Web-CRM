// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import '/shared/exports.dart';

// ignore: must_be_immutable
class AddDocumentPage extends StatefulWidget {
  String userid;
  UserHiveModel userModel;
  AddDocumentPage({super.key, required this.userid, required this.userModel});

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  TextEditingController name = TextEditingController();
  TextEditingController dateCreated = TextEditingController();
  TextEditingController fileType = TextEditingController();
  // TextEditingController name = TextEditingController();
  // TextEditingController name = TextEditingController();
  // late final imageUrl = TextEditingController();

  // final phone = TextEditingController();
  String? imageUrll;

  final _companyFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.userModel != null) {
    // name.text = widget.userModel!.name;
    // imageUrll = widget.userModel!.companyImg;
    // imageUrl.text = widget.model!.companyImg;
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context, listen: true);
    final docProvider = Provider.of<DocumentProvider>(context, listen: true);

    //var uploadImage = Provider.of<UploadImage>(context);
    // final dashProvider = Get.find<DashProvider>();
    // String? modelImage =
    //     widget.userModel == null ? null : widget.userModel!.companyImg;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Documents"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 230,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: _pickedFile == null
                            ? GestureDetector(
                                onTap: () {
                                  print("object");
                                  pickFile();
                                  // _pickImage(name.text);
                                },
                                child: dottedBorder(
                                    color: primaryColor,
                                    text: "Upload Document"),
                              )
                            : GestureDetector(
                                onTap: () {
                                  pickFile();

                                  // _pickImage(name.text);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // child: dottedBorder(color: primaryColor),
                                  child: Icon(
                                      _pickedFile!.type == "application/pdf"
                                          ? Ionicons.document
                                          : Ionicons.image_outline,
                                      size: 60,
                                      color: primaryColor),
                                  //widget.userModel == null
                                  //     ? kIsWeb
                                  //         ? Image.memory(webImage,
                                  //             fit: BoxFit.fill)
                                  //         : Image.file(_pickedImage!,
                                  //             fit: BoxFit.fill)
                                  //     : _pickedImage == null
                                  // ?
                                  // Image.network(imageUrll!)
                                  // :
                                  // kIsWeb
                                  //     ? Image.memory(webImage,
                                  //         fit: BoxFit.fill)
                                  //     : Image.file(_pickedImage!,
                                  //         fit: BoxFit.fill),
                                ),
                              )),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Form(
                    key: _companyFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        formTextField(name, "Document Name",
                            "Enter Document Name", FieldRegex.defaultRegExp,
                            isCompulsory: false),
                        formTextField(
                          dateCreated,
                          "Date Created",
                          "Enter Date Created",
                          FieldRegex.dateRegExp,
                        ),
                        formTextField(fileType, "fileType",
                            "Enter Company Name", FieldRegex.defaultRegExp,
                            isAbsorbed: true, isCompulsory: false),
                        genericPicker(
                            radius: 10,
                            prefixIcon: Ionicons.document,
                            height: 70,
                            width: double.infinity,
                            docProvider.documentList,
                            docProvider.documentSelected,
                            "Document", (value) {
                          docProvider.selectDocument(value);
                          // print(getGender(provider.relationSelected).toString());
                          // provider.genderSelected = value;
                          print(value);
                        }, context),
                        // Expanded(
                        //   child: StreamBuilder<QuerySnapshot>(
                        //     stream: FirebaseFirestore.instance
                        //         .collection("Documents")
                        //         .where("userid", isEqualTo: widget.userid)
                        //         .snapshots(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState == ConnectionState.waiting) {
                        //         return customCircularLoader("Documents");
                        //       } else {
                        //         return ListView.builder(
                        //             // shrinkWrap: true,
                        //             // physics: const NeverScrollableScrollPhysics(),
                        //             itemCount: snapshot.data!.docs.length,
                        //             itemBuilder: (context, index) {
                        //               // return Text("erfdfv");
                        //               return documentTile(
                        //                 context,
                        //                 DocumentModel.fromFirestore(
                        //                     snapshot.data!.docs[index]),
                        //               );
                        //             });
                        //       }
                        //     },
                        //   ),
                        // ),

                        // const Spacer(),

                        // addMemberSheet(context, widget.userid, docId);
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            _isUploading == true
                ? customCircularLoader(term: "Uploading document")
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: customButton("Submit Document", () async {
                      if (_companyFormKey.currentState?.validate() == true) {
                        var v1 = const Uuid().v4();
                        FirebaseFirestore.instance
                            .collection("Documents")
                            .doc(v1)
                            .set({
                          "doc_id": v1,
                          "userid": widget.userid,
                          "doc_created": textToDateTime(dateCreated.text),
                          "name": widget.userModel.name,
                          "doc_format": fileType.text,
                          "doc_type": docProvider.documentSelected,
                          "doc_name": name.text,
                          "doc_url": imageUrll,
                          "timestamp": DateTime.now(),
                        }).then((value) {
                          print("success");

                          UserHiveHelper.fetchDocFromFirebase();

                          Navigator.pop(context);
                        });
                      }
                    }, context),
                  ),
          ],
        ),
      ),
    );
  }

  Uint8List? _pickedFileBytes;
  html.File? _pickedFile;
  bool _isUploading = false;
  Future<void> pickFile() async {
    print("object");
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
          name.text = file.name;
          dateCreated.text = dateTimetoText(file.lastModifiedDate);
          fileType.text = file.type;
        });

        reader.readAsArrayBuffer(file);
        setState(() {
          _isUploading = true;
        });
        Timer(Duration(seconds: 1), () {
          uploadDocument();
          // uploadFileToFirebase(
          //         imageFile: _pickedFileBytes!,
          //         fileName: name.text,
          //         folderName: "Documents")!
          //     .then((downloadURL) {
          //   print('Upload successful. Download URL: $downloadURL');

          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //         content:
          //             Text('Upload successful! Download URL: $downloadURL')),
          //   );
          //   setState(() {
          //     _isUploading = false;
          //   });
          // });
        });
      });
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  Future<void> uploadDocument() async {
    if (_pickedFileBytes == null || _pickedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      String fileName =
          'Documents/${DateTime.now().millisecondsSinceEpoch}-${_pickedFile!.name}';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = storageRef.putData(_pickedFileBytes!);

      final snapshot = await uploadTask;
      final downloadURL = await snapshot.ref.getDownloadURL();
      print('Upload successful. Download URL: $downloadURL');
      setState(() {
        imageUrll = downloadURL;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text('Upload successful! Download URL: $downloadURL')),
      // );
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
}
