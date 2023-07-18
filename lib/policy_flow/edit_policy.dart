import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDetailsPage extends StatefulWidget {
  PolicyModel model;
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
  List genderdropDownData = [
    {"title": "1 year", "value": "1"},
    {"title": "2 years", "value": "2"},
    {"title": "3 years", "value": "3"},
  ];
  String defaultTerm = "";

  List paymentdropDownData = [
    {"title": "net Banking", "value": "net Banking"},
    {"title": "credit/debit", "value": "credit/debit"},
    {"title": "UPI", "value": "UPI"},
  ];

  String defaultpaymode = "";

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
    issuedDate.text = dateTimetoText(widget.model.issuedDate.toDate());
    inceptionDate.text = dateTimetoText(widget.model.inceptionDate.toDate());
    nomineeName.text = widget.model.nomineeName;
    advisorName.text = widget.model.advisorName;
    withGST = widget.model.premuimAmt;
    // defaultTerm = widget.model.advisorName;
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<PolicyProvider>(context, listen: false);
    final statsProvider =
        Provider.of<HealthStatsProvider>(context, listen: false);

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
                          policyNumber, "Policy Number", "Enter Policy Number"),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(
                            sumAssured, "Sum Assured", "Enter Sum Assured")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        issuedDate,
                        "Issued Date:DD/MM/YYYY",
                        "Enter Issued Date",
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
                  ),
                ),
                formTextField(
                    premiumAmt, "premium Amount", "Enter premium Amount",
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
                    nomineeName, "Nominee Name", "Enter Nominee Name"),
                streamNominees(widget.model.userid!, context, nomineeName),
                formTextField(
                    advisorName, "advisor Name", "Enter Nominee Name"),
                renderAdvisor(statsProvider.advisorList, context, advisorName),
                fdropdown("Select Term Period", defaultTerm, genderdropDownData,
                    (value) {
                  print("selected Value $value");
                  setState(() {
                    defaultTerm = value!;
                  });
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buttonText(
                      "Your policy will be issued from ${issuedDate.text} to ${dateTimetoText(textToDateTime(issuedDate.text).add(Duration(days: (defaultTerm == "" ? 1 : int.parse(defaultTerm)) * 365)))}",
                      14,
                      color: Colors.greenAccent),
                ),
                fdropdown(
                    "Select Payment Mode", defaultpaymode, paymentdropDownData,
                    (value) {
                  print("selected Value $value");
                  setState(() {
                    defaultpaymode = value!;
                  });
                }),
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
                    print("Fine till here 1");

                    updateCompanybussiness(
                        widget.model.premuimAmt, provider.companyID,
                        negative: true);
                    updateCompanybussiness(
                        int.parse(premiumAmt.text), provider.companyID);
                    print("Fine till here 2");
                    updatePolicy(
                        textToDateTime(issuedDate.text),
                        textToDateTime(inceptionDate.text),
                        widget.model.policyID);
                    print("Fine till here 3");

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

  void updatePolicy(DateTime issuedDate, DateTime inceptionDate, String docId) {
    int term = defaultTerm == "" ? 1 : int.parse(defaultTerm);
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
