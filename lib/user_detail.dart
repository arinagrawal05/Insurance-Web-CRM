import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/add_user.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/user_model.dart';
import 'package:health_model/providers/user_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/sheets/confirm_sheet.dart';
import 'package:health_model/shared/tiles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class UserDetailPage extends StatefulWidget {
  UserModel model;
  UserDetailPage({required this.model});
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late TooltipBehavior tooltip = TooltipBehavior();
  // AsyncSnapshot<QuerySnapshot<Object?>>? snap;
  late Stream<DocumentSnapshot<Object?>> documentStream;
  late DocumentSnapshot<Object?> initialSnapshot;
  bool isTherePolicy = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // getPolicy("c598584a-3f3d-4bf0-a208-bfb6ba61a406");
    FirebaseFirestore.instance
        .collection("Policies")
        .where("uid", isEqualTo: userProvider.userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        // for (var i = 0; i < value.docs.length; i++) {
        DocumentReference documentRef = FirebaseFirestore.instance
            .collection('Policies') // Replace with your collection name
            .doc(value.docs[0]["policy_id"]);

        documentStream = documentRef.snapshots();

        documentRef.get().then((snapshot) {
          setState(() {
            isTherePolicy = true;
            initialSnapshot = snapshot;
          });
        });
      }
      // print("Success");
    });
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    UserModel model = widget.model;
    // final provider = Provider.of<PolicyProvider>(context, listen: false);

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
          confirmRemoveSheet(context, "Client", () {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(model.userid)
                .delete();
          });
        }, context),
      ]),
      body: SingleChildScrollView(
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
                                    "mailto:${model.email}?subject=This is Regarding your policy&body=Hello${getFirstWord(model.name)}");
                              }, context),
                              customDeleteButton(Ionicons.logo_whatsapp,
                                  Colors.greenAccent.shade100, () {
                                launchURL(
                                    "https://wa.me/${model.phone}?text=Hi ${getFirstWord(model.name)},");
                              }, context),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ignore: unnecessary_null_comparison
                    isTherePolicy == false
                        ? Container()
                        : policyTile(
                            context, PolicyModel.fromFirestore(initialSnapshot))
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
                                child: heading("Members", 20),
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              streamMembers(model.userid),
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
                                  dateTimetoText(model.dob.toDate()),
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
}
