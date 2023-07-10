import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class EnterPolicyDetails extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EnterPolicyDetailsState createState() => _EnterPolicyDetailsState();
}

class _EnterPolicyDetailsState extends State<EnterPolicyDetails> {
  int withGST = 0;

  @override
  void initState() {
    super.initState();
    // inceptionDate.text = dateTimetoText(widget.portIssueDate);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PolicyProvider>(context, listen: false);
    final statsProvider =
        Provider.of<HealthStatsProvider>(context, listen: false);

    return Scaffold(
      body: Consumer<PolicyProvider>(builder: (context, controller, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.policyFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chooseHeader("Fill Details", 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(controller.policyNumber,
                            "Policy Number", "Enter Policy Number"),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: formTextField(controller.sumAssured,
                              "Sum Assured", "Enter Sum Assured")),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(
                          controller.issuedDate,
                          "Issued Date:DD/MM/YYYY",
                          "Enter Issued Date",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: formTextField(
                      controller.inceptionDate,
                      "Inception Date:DD/MM/YYYY",
                      "Enter Inception Date",
                    ),
                  ),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        withGST = int.parse(val);
                      });
                    },
                    // keyboardType: kType,
                    controller: controller.premiumAmt,
                    decoration: InputDecoration(
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: buttonText("With GST:${addWithGST(withGST)}", 14,
                            color: Colors.redAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: "premium Amount",
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                    validator: (value) {
                      // if (isCompulsory) {
                      if (value!.isEmpty) {
                        return "Enter premium Amount";
                      }
                      return null;
                      // }
                    },
                  ),
                  formTextField(controller.nomineeName, "Nominee Name",
                      "Enter Nominee Name"),
                  streamNominees(
                      provider.client_uid, context, controller.nomineeName),
                  formTextField(controller.advisorName, "advisor Name",
                      "Enter Nominee Name"),
                  renderAdvisor(statsProvider.advisorList, context,
                      controller.advisorName),
                  genericPicker(
                      radius: 10,
                      prefixIcon: Ionicons.hourglass_outline,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      controller.termList,
                      controller.termSelected,
                      "Choose Terms", (value) {
                    controller.selectTerm(value);
                  }, context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: buttonText(
                        "Your policy will be issued from ${controller.issuedDate.text} to ${dateTimetoText(textToDateTime(controller.issuedDate.text).add(Duration(days: int.parse(getFirstWord(controller.termSelected)) * 365)))}",
                        14,
                        color: Colors.greenAccent),
                  ),
                  genericPicker(
                      radius: 10,
                      prefixIcon: Ionicons.card_outline,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      controller.payModeList,
                      controller.payModeSelected,
                      "Choose Payment Mode", (value) {
                    controller.selectpayMode(value);
                  }, context),
                  controller.payModeSelected == "Cheque"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: formTextField(
                                controller.bankName,
                                "Bank Name",
                                "Enter Bank Name",
                                isCompulsory: false,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: formTextField(
                                  controller.bankDate,
                                  "Date:DD/MM/YYYY",
                                  "Enter Date",
                                  isCompulsory: false,
                                )),
                            Expanded(
                              flex: 1,
                              child: formTextField(
                                controller.chequeNo,
                                "Cheque No",
                                "Enter Cheque",
                                isCompulsory: false,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  customButton("Add to Database", () async {
                    if (
                        // controller.policyFormKey.currentState?.validate() ==
                        true) {
                      var uuid = const Uuid();
                      String docId = uuid.v4();

                      controller.clearFields();
                      // controller.performFunctions(docId, statsProvider);
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                    }
                  }, context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
