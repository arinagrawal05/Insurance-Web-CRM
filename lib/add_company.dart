import 'dart:io';

import 'package:health_model/shared/regex.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/sheets/plan_sheet.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddCompanyPage extends StatefulWidget {
  String companyid;
  CompanyModel? model;
  AddCompanyPage({super.key, required this.companyid, required this.model});

  @override
  State<AddCompanyPage> createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {
  final name = TextEditingController();
  // late final imageUrl = TextEditingController();

  // final phone = TextEditingController();
  String? imageUrll;

  final _companyFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      name.text = widget.model!.name;
      imageUrll = widget.model!.companyImg;
      // imageUrl.text = widget.model!.companyImg;
    }
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final dashProvider = Get.find<DashProvider>();
    String? modelImage = widget.model == null ? null : widget.model!.companyImg;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "Add Company" : "Update Company"),
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
                      child: _pickedImage == null && widget.model == null
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
                                child: widget.model == null
                                    ? kIsWeb
                                        ? Image.memory(webImage,
                                            fit: BoxFit.fill)
                                        : Image.file(_pickedImage!,
                                            fit: BoxFit.fill)
                                    : _pickedImage == null
                                        ? Image.network(imageUrll!)
                                        : kIsWeb
                                            ? Image.memory(webImage,
                                                fit: BoxFit.fill)
                                            : Image.file(_pickedImage!,
                                                fit: BoxFit.fill),
                              ),
                            )),
                ),
                // formTextField(
                //   imageUrl,
                //   "Company Image Url",
                //   "Enter Image Url",
                //   FieldRegex.defaultRegExp,
                // ),

                formTextField(
                  name,
                  "Company Name",
                  "Enter Company Name",
                  FieldRegex.nameRegExp,
                ),

                dashProvider.currentDashBoard != ProductType.fd
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          heading("Plan", 20),
                          customButton("Add Plan", () async {
                            var uuid = const Uuid();
                            String docId = uuid.v4();
                            addPlanSheet(context, widget.companyid, docId);
                          }, context, isExpanded: false),
                        ],
                      )
                    : Container(),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Companies")
                        .doc(widget.companyid)
                        .collection("Plans")
                        // .orderBy("timestamp", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return customCircularLoader("Plans");
                      } else {
                        return ListView.builder(
                            // shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // return Text("erfdfv");
                              return planTile(
                                false,
                                context,
                                PlanModel.fromFirestore(
                                    snapshot.data!.docs[index]),
                              );
                            });
                      }
                    },
                  ),
                ),

                // const Spacer(),
                isLoading == true
                    ? CircularProgressIndicator()
                    : customButton(
                        widget.model == null
                            ? "Add Company to Database"
                            : "Update This Company", () async {
                        if (_companyFormKey.currentState?.validate() == true) {
                          if (widget.model != null) {
                            FirebaseFirestore.instance
                                .collection("Companies")
                                .doc(widget.companyid)
                                .update({
                              "name": name.text,
                              "logo": imageUrll,
                              // "phone": dob.text,
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection("Companies")
                                .doc(widget.companyid)
                                .set({
                              "company_id": widget.companyid,
                              "name": name.text,
                              "plans_count": 0,
                              "policy_count": 0,
                              "timestamp": Timestamp.now(),
                              "company_type": EnumUtils.convertTypeToKey(
                                  dashProvider.currentDashBoard),
                              "total_bussiness": 0,
                              "logo": imageUrll,
                              // "phone": dob.text,
                            });

                            FirebaseFirestore.instance
                                .collection("Policies")
                                .where("type", isEqualTo: "Life")
                                .where("company_id",
                                    isEqualTo: widget.companyid)
                                .get()
                                .then((value) {
                              if (value.docs.isNotEmpty) {
                                for (var i = 0; i < value.docs.length; i++) {
                                  // print(value.docs[i]["fd_id"]);
                                  // sum += value.docs[i]["invested_amt"];
                                  FirebaseFirestore.instance
                                      .collection("Policies")
                                      .doc(value.docs[i]["life_id"])
                                      .update({"company_logo": imageUrll});
                                }
                                // print("Successfully Temp Updated " + sum.toString());
                              }
                            });
                          }

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
