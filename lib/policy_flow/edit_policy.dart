import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:health_model/regex.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/providers/general_stats_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDetailsPage extends StatefulWidget {
  PolicyHiveModel model;
  // String portCompanyName, portPolicyNo, portSumAssured;
  // DateTime portIssueDate;
  // bool isFress;

  EditDetailsPage({
    super.key,
    required this.model,

    // required this.portCompanyName,
    // required this.portPolicyNo,
    // required this.portIssueDate,
    // required this.portSumAssured,
    // required this.isFress
  });
  @override
  _EditDetailsPageState createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  final policyNumber = TextEditingController();
  final sumAssured = TextEditingController();
  final premiumAmt = TextEditingController();
  final issuedDate = TextEditingController();
  final inceptionDate = TextEditingController();

  final nomineeName = TextEditingController();
  final advisorName = TextEditingController();

  final _policyFormKey = GlobalKey<FormState>();

  int withGST = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autofill();
  }

  autofill() {
    policyNumber.text = widget.model.policyNo;
    sumAssured.text = widget.model.sumAssured.toString();
    premiumAmt.text = widget.model.premuimAmt.toString();
    issuedDate.text = dateTimetoText(widget.model.issuedDate);
    inceptionDate.text = dateTimetoText(widget.model.inceptionDate);
    nomineeName.text = widget.model.nomineeName;
    advisorName.text = widget.model.advisorName;
    withGST = widget.model.premuimAmt;
    // defaultTerm = widget.model.advisorName;
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<PolicyProvider>(context, listen: true);
    final statsProvider = Get.find<DashProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _policyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: heading("Edit Policy Details", 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        policyNumber,
                        "Policy Number",
                        "Enter Policy Number",
                        FieldRegex.defaultRegExp,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(
                          sumAssured,
                          "Sum Assured",
                          "Enter Sum Assured",
                          FieldRegex.integerRegExp,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        issuedDate,
                        "Issued Date:DD/MM/YYYY",
                        "Enter Issued Date",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: formTextField(
                    inceptionDate,
                    "Inception Date:DD/MM/YYYY",
                    "Enter Inception Date",
                    FieldRegex.dateRegExp,
                  ),
                ),
                formTextField(premiumAmt, "premium Amount",
                    "Enter premium Amount", FieldRegex.integerRegExp,
                    isCompulsory: true, onChange: (val) {
                  setState(() {
                    withGST = int.parse(val);
                  });
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buttonText("With GST:${addWithGST(withGST)}", 14,
                      color: Colors.redAccent),
                ),
                formTextField(
                  nomineeName,
                  "Nominee Name",
                  "Enter Nominee Name",
                  FieldRegex.nameRegExp,
                ),
                streamNominees(widget.model.userid!, context, nomineeName),
                formTextField(
                  advisorName,
                  "advisor Name",
                  "Enter Nominee Name",
                  FieldRegex.defaultRegExp,
                ),
                renderAdvisor(statsProvider.advisorList, context, advisorName),
                genericPicker(
                    radius: 10,
                    prefixIcon: Ionicons.hourglass_outline,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    provider.termList,
                    provider.termSelected,
                    "Choose Terms", (value) {
                  provider.selectTerm(value);
                }, context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buttonText(
                      "Your policy will be issued from ${issuedDate.text} to ${dateTimetoText(textToDateTime(issuedDate.text).add(Duration(days: int.parse(AppUtils.getFirstWord(provider.termSelected)) * 365)))}",
                      14,
                      color: Colors.greenAccent),
                ),
                genericPicker(
                    radius: 10,
                    prefixIcon: Ionicons.card_outline,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    provider.payModeList,
                    provider.payModeSelected,
                    "Choose Payment Mode", (value) {
                  provider.selectpayMode(value);
                }, context),
                provider.payModeSelected == "Cheque"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: formTextField(
                              provider.bankName,
                              "Bank Name",
                              "Enter Bank Name",
                              FieldRegex.nameRegExp,
                              isCompulsory: false,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: formTextField(
                                provider.bankDate,
                                "Date:DD/MM/YYYY",
                                "Enter Date",
                                FieldRegex.dateRegExp,
                                isCompulsory: false,
                              )),
                          Expanded(
                            flex: 1,
                            child: formTextField(
                              provider.chequeNo,
                              "Cheque No",
                              "Enter Cheque",
                              FieldRegex.defaultRegExp,
                              isCompulsory: false,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                customButton("Update In Database", () async {
                  if (_policyFormKey.currentState?.validate() == true) {
                    updateStats("sum_premium_amt",
                        statsProvider.premiumAmtSum - widget.model.premuimAmt);
                    updateStats(
                        "sum_premium_amt",
                        statsProvider.premiumAmtSum +
                            int.parse(premiumAmt.text));

                    updateCompanybussiness(
                        widget.model.premuimAmt, provider.companyID,
                        negative: true);
                    updateCompanybussiness(
                        int.parse(premiumAmt.text), provider.companyID);
                    updatePolicy(
                        textToDateTime(issuedDate.text),
                        textToDateTime(inceptionDate.text),
                        widget.model.policyID,
                        provider.termSelected);

                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updatePolicy(DateTime issuedDate, DateTime inceptionDate, String docId,
      String termSelected) {
    int term = int.parse(AppUtils.getFirstWord(termSelected));
    FirebaseFirestore.instance.collection("Policies").doc(docId).update({
      "renewal_date": issuedDate.add(Duration(days: 365 * term)),
      "policy_no": policyNumber.text,
      "issued_date": issuedDate,
      "inception_date": inceptionDate,
      "policy_status": "active",
      "sum_assured": int.parse(sumAssured.text),
      "premium_amt": int.parse(premiumAmt.text),
      "premium_term": term,
      "nominee_name": nomineeName.text,
      "advisor_name": advisorName.text,
    });
  }
}
