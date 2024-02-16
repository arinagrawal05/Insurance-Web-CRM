import 'dart:io';

// import '
import 'package:health_model/models/document_model.dart';

import '/shared/exports.dart';
import '/sheets/plan_sheet.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddDocumentPage extends StatefulWidget {
  String userid;
  UserHiveModel userModel;
  AddDocumentPage({super.key, required this.userid, required this.userModel});

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final name = TextEditingController();
  // late final imageUrl = TextEditingController();

  // final phone = TextEditingController();
  String? imageUrll;

  final _companyFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userModel != null) {
      name.text = widget.userModel!.name;
      // imageUrll = widget.userModel!.companyImg;
      // imageUrl.text = widget.model!.companyImg;
    }
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final dashProvider = Get.find<DashProvider>();
    // String? modelImage =
    //     widget.userModel == null ? null : widget.userModel!.companyImg;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Documents"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _companyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: _pickedImage == null && widget.userModel == null
                          ? GestureDetector(
                              onTap: () {
                                _pickImage(name.text);
                              },
                              child: dottedBorder(color: primaryColor),
                            )
                          : GestureDetector(
                              onTap: () {
                                _pickImage(name.text);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child:
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
                                    kIsWeb
                                        ? Image.memory(webImage,
                                            fit: BoxFit.fill)
                                        : Image.file(_pickedImage!,
                                            fit: BoxFit.fill),
                              ),
                            )),
                ),

                formTextField(
                  name,
                  "Company Name",
                  "Enter Company Name",
                  FieldRegex.defaultRegExp,
                ),

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Documents")
                        .where("userid", isEqualTo: widget.userid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return customCircularLoader("Documents");
                      } else {
                        return ListView.builder(
                            // shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // return Text("erfdfv");
                              return documentTile(
                                context,
                                DocumentModel.fromFirestore(
                                    snapshot.data!.docs[index]),
                              );
                            });
                      }
                    },
                  ),
                ),

                // const Spacer(),
                isLoading == true
                    ? const CircularProgressIndicator()
                    : customButton("Done", () async {
                        if (_companyFormKey.currentState?.validate() == true) {
                          var v1 = const Uuid().v4();
                          FirebaseFirestore.instance
                              .collection("Documents")
                              .doc(v1)
                              .set({
                            "doc_id": v1,
                            "userid": widget.userid,
                            "name": widget.userModel.name,
                            "doc_type": "aadhar",
                            "doc_name": name.text,
                            "doc_url": imageUrll,
                            "timestamp": DateTime.now(),
                          }).then((value) {
                            print("success");
                          });

                          Navigator.pop(context);
                        }
                      }, context),

                // addMemberSheet(context, widget.userid, docId);
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  Future<void> _pickImage(String companyName) async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          isLoading = true;
          webImage = f;
          _pickedImage = File('a');
          uploadFileToFirebase(fileName: companyName, imageFile: webImage)!
              .then((value) {
            setState(() {
              isLoading = false;
              imageUrll = value;
            });
            // print(value);
          });
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }
}
