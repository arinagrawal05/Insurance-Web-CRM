import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

// ignore: must_be_immutable
class PolicyDetailPage extends StatelessWidget {
  PolicyHiveModel model;
  PolicyDetailPage({required this.model});
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                decoration: dashBoxDex(context),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: heading(" Client Profile", 18),
                    ),
                    const CircleAvatar(
                      minRadius: 50,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Ionicons.person_add,
                          size: 60,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          heading(model.name, 22),
                          Container(
                            child: productTileText(
                                model.isMale ? "Male" : "Female", 12),
                          ),
                        ],
                      ),
                    ),
                    userCardShow("phone", model.phone),
                    userCardShow("email", model.email),
                    userCardShow("Date of Birth", dateTimetoText(model.dob)),
                    userCardShow("Address", model.address),
                    userCardShow("Nominee", model.nomineeName),
                    membersShowcase(model.membersCount, model.userid)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                // color: const Color.fromRGBO(0, 0, 0, 0),
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          heading("About Policy", 18),
                          model.policyStatus == "active"
                              ? Row(
                                  children: [
                                    customButton("Renew", () {
                                      navigate(RenewPolicyPage(model: model),
                                          context);
                                    }, context, isExpanded: false),
                                    customButton("Port", () {
                                      provider.feedPort(
                                          model.companyName,
                                          model.policyNo,
                                          model.sumAssured.toString(),
                                          model.policyID,
                                          model.issuedDate);
                                      navigate(ChooseUser(), context);
                                    }, context, isExpanded: false),
                                    customButton("Edit", () {
                                      navigate(EditDetailsPage(model: model),
                                          context);
                                    }, context, isExpanded: false),
                                    customDeleteButton(Ionicons.trash_outline,
                                        Colors.red.shade500, () async {
                                      confirmRemoveSheet(context, "Policy", () {
                                        FirebaseFirestore.instance
                                            .collection("Policies")
                                            .doc(model.policyID)
                                            .delete();
                                      });
                                    }, context),
                                  ],
                                )
                              : Row(
                                  children: [
                                    customButton("Grant Renew", () {
                                      navigate(RenewPolicyPage(model: model),
                                          context);
                                    }, context, isExpanded: false),
                                    customDeleteButton(Ionicons.trash_outline,
                                        Colors.red.shade500, () async {
                                      confirmRemoveSheet(context, "Policy", () {
                                        FirebaseFirestore.instance
                                            .collection("Policies")
                                            .doc(model.policyID)
                                            .delete();
                                      });
                                    }, context),
                                  ],
                                ),
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
                                "Policy No: ${model.policyNo}",
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
                                    launchURL(
                                        "https://wa.me/${model.phone}?text=${healthRenewalDraftMsg(model)}");
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
                                "RS ${model.sumAssured}",
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
                            "Plan: ${model.planName}",
                            22,
                          ),
                          productTileText(
                            "Renewal Date: ${dateTimetoText(model.renewalDate)}",
                            22,
                          ),
                          !(model.isFresh)
                              ? Container(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Ionicons.information_circle_outline,
                                        size: 45,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            heading(
                                                "This Policy is Ported From ${model.portCompanyName} on ${dateTimetoText(model.portIssueDate)}",
                                                20),
                                            heading1(
                                                "Ported Policy no is ${model.portPolicyNo}",
                                                16)
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                              : Container()
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
                            healthTransactionHeader(),
                            model.inceptionDate == model.issuedDate
                                ? Container()
                                : inceptionWidget(model.inceptionDate, context),
                            streamTransactions("policy_id", model.policyID),
                            model.policyStatus == "active"
                                ? Container()
                                : statusFooter(model.policyStatus,
                                    model.statusDate, context)
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
