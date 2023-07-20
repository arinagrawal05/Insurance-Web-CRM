import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:health_model/shared/drafted_msgs.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/policy_flow/choose_user.dart';
import 'package:health_model/policy_flow/edit_policy.dart';
import 'package:health_model/policy_renew.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/sheets/confirm_sheet.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'hive/hive_model/policy_models/fd_model.dart';

// ignore: must_be_immutable
class FdDetailPage extends StatelessWidget {
  FdHiveModel model;
  FdDetailPage({required this.model});
  late TooltipBehavior tooltip = TooltipBehavior();

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    // final provider = Provider.of<StatsProvider>(context, listen: true);
    // PolicyModel model = model;
    final provider = Provider.of<PolicyProvider>(context, listen: false);

    return Scaffold(
      appBar: genericAppbar(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                decoration: dashBoxDex(context),
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: heading(" Client Profile", 18),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 45),
                      // height: 200,
                      // width: 150,
                      child: Icon(
                        Ionicons.person_outline,
                        size: 80,
                      ),
                    ),
                    heading(model.name, 22),
                    heading1("Arin Agrawals" + "'s member", 15),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    userDetailShow(
                        "phone", model.phone, Ionicons.phone_portrait_outline),
                    userDetailShow("email", model.email, Ionicons.mail),
                    userDetailShow("Birthday", dateTimetoText(model.dob),
                        Ionicons.medical_outline),
                    userDetailShow(
                        "Gender",
                        model.isMale ? "Male" : "Female",
                        model.isMale
                            ? Ionicons.man_outline
                            : Ionicons.woman_outline),
                    userDetailShow(
                        "Address", "Borewali mumbai", Ionicons.home_outline),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                margin: const EdgeInsets.all(12),
                // color: const Color.fromRGBO(0, 0, 0, 0),
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          heading("About FD", 18),
                          model.fdStatus == "applied"
                              ? Row(
                                  children: [
                                    customButton("Got Certificate", () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              errorDialog("bolo?"));
                                      // Get.snackbar(
                                      //   "hello",
                                      //   "this is message",
                                      //   snackPosition: SnackPosition.BOTTOM,
                                      // );
                                      // print("object");
                                      // navigate(RenewPolicyPage(model: model),
                                      // context);
                                    }, context, isExpanded: false),
                                    customButton("Edit FD", () {
                                      // navigate(EditDetailsPage(model: model),
                                      // context);
                                    }, context, isExpanded: false),
                                    customDeleteButton(Ionicons.trash_outline,
                                        Colors.red.shade500, () async {
                                      confirmRemoveSheet(context, "Policy", () {
                                        FirebaseFirestore.instance
                                            .collection("Policies")
                                            .doc(model.fdId)
                                            .delete();
                                      });
                                    }, context),
                                  ],
                                )
                              : Row(
                                  children: [
                                    // customButton("Grant Renew", () {
                                    //   navigate(RenewPolicyPage(model: model),
                                    //       context);
                                    // }, context, isExpanded: false),
                                    customDeleteButton(Ionicons.trash_outline,
                                        Colors.red.shade500, () async {
                                      confirmRemoveSheet(context, "Policy", () {
                                        FirebaseFirestore.instance
                                            .collection("Policies")
                                            .doc(model.fdId)
                                            .delete();
                                      });
                                    }, context),
                                  ],
                                ),

                          // Container(),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: dashBoxDex(context),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productTileText(
                                "FD No: ${model.fdNo}",
                                22,
                              ),
                              // Text(
                              //   model.policyNo,
                              //   style: GoogleFonts.nunito(
                              //       fontSize: 22,
                              //       color: Colors.green.shade300,
                              //       fontWeight: FontWeight.w500),
                              // ),
                              GestureDetector(
                                  onTap: () {
                                    // launchURL(
                                    //     "https://wa.me/${model.phone}?text=${renewalDraftMsg(model)}");
                                  },
                                  child: Icon(
                                    Ionicons.logo_whatsapp,
                                    color: Colors.green.shade300,
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              productTileText(
                                "Sum Assured: ",
                                22,
                              ),
                              Text(
                                "RS ${model.investedAmt.toString()}",
                                style: GoogleFonts.nunito(
                                    fontSize: 22,
                                    color: Colors.green.shade300,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          productTileText(
                            "Company: ${model.companyName}",
                            22,
                          ),
                          productTileText(
                            "Renewal Date: ${dateTimetoText(model.maturityDate)}",
                            22,
                          ),
                          Text(model.isCummulative.toString())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: heading("Transactions", 18),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: dashBoxDex(context),
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fDTransactionHeader(),
                            // model.inceptionDate == model.issuedDate
                            //     ? Container()
                            //     : inceptionWidget(model.inceptionDate, context),
                            streamTransactions("policy_id", model.fdId),
                            model.fdStatus == "applied"
                                ? Container()
                                : statusFooter(
                                    model.fdStatus, model.initialDate, context)
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

Widget inceptionWidget(DateTime inceptionDate, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    // color: Theme.of(context).scaffoldBackgroundColor,
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(vertical: 3),
    child: simpleText("Inception Date: ${dateTimetoText(inceptionDate)}", 16),
    // child: Text()
  );
}

Dialog errorDialog(String title) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: heading("Certificate Submission", 22),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Awesome',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: Text(
                'Got It!',
                style: TextStyle(color: Colors.purple, fontSize: 18.0),
              ))
        ],
      ),
    ),
  );
}
