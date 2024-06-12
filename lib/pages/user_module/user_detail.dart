import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_model/add_documents.dart';
import 'package:health_model/providers/doc_provider.dart';
import '/shared/exports.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:io';

// import 'package:firebase/firebase.dart' as fb;
// import 'dart:html' as html;

// ignore: must_be_immutable
class UserDetailPage extends StatefulWidget {
  UserHiveModel model;
  UserDetailPage({required this.model});
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late TooltipBehavior tooltip = TooltipBehavior();
  // AsyncSnapshot<QuerySnapshot<Object?>>? snap;
  // late Stream<DocumentSnapshot<Object?>> documentStream;
  // late List<DocumentSnapshot<Object?>> initialSnapshot = [];
  // bool isTherePolicy = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final docProvider = Provider.of<DocumentProvider>(context, listen: true);

    UserHiveModel model = widget.model;
    // final provider = Provider.of<PolicyProvider>(context, listen: false);
    final dashProvider = Get.find<DashProvider>();

    return Scaffold(
      appBar: genericAppbar(actions: [
        customButton("Edit", () async {
          userProvider.changeMemberCount(model.membersCount);
          navigate(
              AddUserPage(
                model: model,
                userid: model.userid,
              ),
              context);
          // addMemberSheet(context, widget.userid, docId);
        }, context, isExpanded: false),
        customDeleteButton(Ionicons.trash_outline, Colors.red.shade500,
            () async {
          genericConfirmSheet(context, Statements.removeClient, "Client", () {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(model.userid)
                .delete()
                .then((value) {
              UserHiveHelper.fetchUsersFromFirebase();

              Navigator.pop(context);

              Navigator.pop(context);
            });
          });
        }, context),
      ]),
      body:
          //  streamPoliciesByUser(model.userid, dashProvider)

          SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.all(20),
          padding: const EdgeInsets.all(30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 40),
                              height: 300,
                              // decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //   image: NetworkImage(
                              //     "https://media.istockphoto.com/id/1287754287/vector/liquid-style-colorful-pastel-abstract-background-with-elements-vector.jpg?s=612x612&w=0&k=20&c=uIHo_HvNo9VgTIlnHXgoPNVSLfkl67ARKqiW1bWqcug=",
                              //    ),
                              // )),
                              child: cachedImage(
                                "https://media.istockphoto.com/id/1287754287/vector/liquid-style-colorful-pastel-abstract-background-with-elements-vector.jpg?s=612x612&w=0&k=20&c=uIHo_HvNo9VgTIlnHXgoPNVSLfkl67ARKqiW1bWqcug=",
                              ),
                            )),
                        Container(
                          width: 900,
                          padding: const EdgeInsets.all(20),
                          decoration: dashBoxDex(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.network(
                                      "https://static.vecteezy.com/system/resources/previews/024/492/706/original/man-head-user-profile-character-vector.jpg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  heading(model.name, 25),
                                  heading(model.email, 20),
                                ],
                              ),
                              const Spacer(),
                              customDeleteButton(
                                  Ionicons.mail, Colors.yellowAccent.shade100,
                                  () {
                                launchURL(
                                    "mailto:${model.email}?subject=This is Regarding your policy&body=Hello${AppUtils.getFirstWord(model.name)}");
                              }, context),
                              customDeleteButton(Ionicons.logo_whatsapp,
                                  Colors.greenAccent.shade100, () {
                                launchURL(
                                    "https://wa.me/${model.phone}?text=Hi ${AppUtils.getFirstWord(model.name)},");
                              }, context),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: userProvider
                          .getPoliciesByUser(widget.model.userid)
                          .length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (userProvider
                                    .getPoliciesByUser(
                                        widget.model.userid)[index]
                                    .data!
                                    .type ==
                                EnumUtils.convertTypeToKey(
                                    dashProvider.currentDashBoard) ||
                            dashProvider.currentDashBoard == ProductType.cms) {
                          return Column(
                            children: [
                              renderTile(
                                  userProvider
                                      .getPoliciesByUser(
                                          widget.model.userid)[index]
                                      .data,
                                  context),
                            ],
                          );

                          // if (userProvider
                          //         .getPoliciesByUser(widget.model.userid)[index]
                          //         .data!
                          //         .type ==
                          //     EnumUtils.convertTypeToKey(ProductType.health)) {
                          //   return HealthTile(
                          //       context: context,
                          //       model: userProvider
                          //           .getPoliciesByUser(
                          //               widget.model.userid)[index]
                          //           .data as PolicyHiveModel);
                          // } else if (userProvider
                          //         .getPoliciesByUser(widget.model.userid)[index]
                          //         .data!
                          //         .type ==
                          //     EnumUtils.convertTypeToKey(ProductType.life)) {
                          //   return LifeTile(
                          //       context: context,
                          //       model: userProvider
                          //           .getPoliciesByUser(
                          //               widget.model.userid)[index]
                          //           .data as LifeHiveModel);
                          // } else if (userProvider
                          //         .getPoliciesByUser(widget.model.userid)[index]
                          //         .data!
                          //         .type ==
                          //     EnumUtils.convertTypeToKey(ProductType.motor)) {
                          //   return MotorTile(
                          //       context: context,
                          //       model: userProvider
                          //           .getPoliciesByUser(
                          //               widget.model.userid)[index]
                          //           .data as MotorHiveModel);
                          // } else {
                          //   return FDTile(
                          //       context: context,
                          //       model: userProvider
                          //           .getPoliciesByUser(
                          //               widget.model.userid)[index]
                          //           .data as FdHiveModel);
                          // }
                        }
                        // return Container(
                        //   child: Text(userProvider
                        //       .getPoliciesByUser(widget.model.userid)[index]
                        //       .data!
                        //       .type),
                        // );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: dashBoxDex(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    heading("Documents", 20),
                                    docProvider
                                            .getDocumentsByUser(
                                                widget.model.userid)
                                            .isEmpty
                                        ? customButton("Add", () {
                                            navigate(
                                                AddDocumentPage(
                                                    userid: widget.model.userid,
                                                    userModel: widget.model),
                                                context);
                                          }, context, isExpanded: false)
                                        : Container()
                                  ],
                                ),
                              ),

                              docProvider
                                      .getDocumentsByUser(widget.model.userid)
                                      .isNotEmpty
                                  ? const Divider(
                                      indent: 20,
                                      endIndent: 20,
                                    )
                                  : const SizedBox(
                                      height: 10,
                                    ),
                              ListView.builder(
                                itemCount: docProvider
                                    .getDocumentsByUser(widget.model.userid)
                                    .length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return documentMiniTile(
                                      context,
                                      docProvider.getDocumentsByUser(
                                          widget.model.userid)[index]);
                                },
                              ),

                              docProvider
                                      .getDocumentsByUser(widget.model.userid)
                                      .isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: customButton("Add Document", () {
                                        navigate(
                                            AddDocumentPage(
                                                userid: widget.model.userid,
                                                userModel: widget.model),
                                            context);
                                      }, context),
                                    )
                                  : Container(),
                              // streamMembers(
                              //   model.userid,
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: dashBoxDex(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: heading("Members", 20),
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              streamMembers(
                                model.userid,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: dashBoxDex(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: heading("Details", 20),
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              userDetailShow("phone", model.phone,
                                  Ionicons.phone_portrait_outline),
                              userDetailShow(
                                  "email", model.email, Ionicons.mail),
                              userDetailShow(
                                  "Birthday",
                                  dateTimetoText(model.dob),
                                  Ionicons.medical_outline),
                              userDetailShow(
                                  "Gender",
                                  model.isMale ? "Male" : "Female",
                                  model.isMale
                                      ? Ionicons.man_outline
                                      : Ionicons.woman_outline),
                              userDetailShow("Address", model.address,
                                  Ionicons.home_outline),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // Future pickPDF() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     Uint8List? bytes = result.files.single.bytes;
  //     if (bytes != null) {
  //       // Create a file object with custom bytes for web
  //       File pdfFile = File.fromRawPath(bytes);
  //       uploadPDF(pdfFile);
  //     } else {
  //       // Handle the case where bytes are not available
  //       print('Error: File bytes could not be retrieved.');
  //     }
  //   }
  // }
  Future pickPDF() async {
    print("abcd");
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isMacOS ||
        Platform.isWindows) {
      print("abcd mobile form");
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        Uint8List? bytes = result.files.single.bytes;
        if (bytes != null) {
          File pdfFile = File.fromRawPath(bytes);
          uploadPDF(pdfFile);
        } else {
          print('Error: File bytes could not be retrieved.');
        }
      } else {
        print('User canceled the file picking.');
      }
    } else {
      print("abcd web form");
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        Uint8List? bytes = result.files.single.bytes;
        if (bytes != null) {
          File pdfFile = File.fromRawPath(bytes);
          uploadPDF(pdfFile);
        } else {
          print('Error: File bytes could not be retrieved.');
        }
      } else {
        print('User canceled the file picking.');
      }
    }
  }

  Future uploadPDF(File pdfFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child('pdfs/helo');
    UploadTask uploadTask = ref.putFile(pdfFile);

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();

    // Use the downloadURL to display or store it as needed
    print('Download URL: $downloadURL');
  }
}
