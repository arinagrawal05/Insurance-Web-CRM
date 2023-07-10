import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/models/plan_model.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/sheets/plan_sheet.dart';
import 'package:health_model/shared/tiles.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AddCompanyPage extends StatelessWidget {
  String companyid;
  AddCompanyPage({super.key, required this.companyid});
  final name = TextEditingController();

  final phone = TextEditingController();

  final _addBrandKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final dashProvider = Provider.of<DashProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Company"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addBrandKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              formTextField(name, "Company Name", "Enter Company Name"),
              dashProvider.dashName == AppConsts.health
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        heading("Plan", 20),
                        customButton("Add Plan", () async {
                          var uuid = const Uuid();
                          String docId = uuid.v4();
                          addPlanSheet(context, companyid, docId);
                        }, context, isExpanded: false),
                      ],
                    )
                  : Container(),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Companies")
                    .doc(companyid)
                    .collection("Plans")
                    // .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return customCircularLoader("Plans");
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // return Text("erfdfv");
                          return planTile(
                            false,
                            context,
                            PlanModel.fromFirestore(snapshot.data!.docs[index]),
                          );
                        });
                  }
                },
              ),

              const Spacer(),
              customButton("Add Company to Database", () async {
                if (_addBrandKey.currentState?.validate() == true) {
                  FirebaseFirestore.instance
                      .collection("Companies")
                      .doc(companyid)
                      .set({
                    "company_id": companyid,
                    "name": name.text,
                    "plans_count": 0,
                    "policy_count": 0,
                    "timestamp": Timestamp.now(),
                    "company_type": dashProvider.dashName,
                    "total_bussiness": 0,
                    "logo":
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReatD6bpUCpOVAd7ojjwBFEi9aIRCe55KlVQ&usqp=CAU",
                    // "phone": dob.text,
                  });
                  Navigator.pop(context);
                }
              }, context),

              // addMemberSheet(context, widget.userid, docId);
            ],
          ),
        ),
      ),
    );
  }
}
