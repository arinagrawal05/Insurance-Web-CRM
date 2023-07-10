import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/fd_provider.dart';
// ignore: unused_import
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/shared/toggle.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class EnterFdDetails extends StatelessWidget {
  // String portCompanyName, portPolicyNo, portSumAssured;
  // DateTime portIssueDate;
  // bool isFress;

  // EnterFdDetails(
  //     {super.key,
  //     required this.portCompanyName,
  //     required this.portPolicyNo,
  //     required this.portIssueDate,
  //     required this.portSumAssured,
  //     required this.isFress});

  List genderdropDownData = [
    {"title": "1 year", "value": "1"},
    {"title": "2 years", "value": "2"},
    {"title": "3 years", "value": "3"},
  ];

  String defaultTerm = "";

  EnterFdDetails({super.key});

  // @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<FDProvider>(context, listen: true);
    // final statsProvider =
    //     Provider.of<HealthStatsProvider>(context, listen: false);

    return Scaffold(
      body: Consumer<FDProvider>(builder: (context, controller, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).canvasColor,
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 12,
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 600,
                      width: 300,
                      color: Theme.of(context).canvasColor,
                      child: Column(
                        children: [
                          const ChangeThemeButtonWidget(),
                          Text(controller.client_member_name),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      elevation: 12,
                      color: Theme.of(context).canvasColor,
                      child: Container(
                        // color: Colors.red,
                        height: 600,
                        width: 900,
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: controller.fdFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // chooseHeader("Fill Fd Details", 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  heading("Fill Details", 22),
                                  Container(
                                    width: 150,
                                    child: noBorderTextField(
                                        controller.initialDate,
                                        "Initial Date",
                                        "Enter initial Date",
                                        Ionicons.calendar),
                                  )
                                ],
                              ),
                              Container(
                                // width:
                                // MediaQuery.of(context).size.width * 0.3,
                                child: formTextField(
                                  controller.investedAmt,
                                  "Invested Amount",
                                  "Enter Invested Amount",
                                ),
                              ),
                              // Container(
                              //   // width: MediaQuery.of(context).size.width * 0.3,
                              //   child: fdFormTextField(
                              //       inceptionDate,
                              //       "Inception Date:DD/MM/YYYY",
                              //       "Enter Inception Date",
                              //       Ionicons.infinite),
                              // ),
                              // formTextField(controller.investedAmt,
                              //     "premium Amount", "Enter premium Amount",
                              //     isCompulsory: true, onChange: (val) {}),
                              // formTextField(
                              //     advisorName, "advisor Name", "Enter Nominee Name"),
                              // // renderAdvisor(statsProvider.advisorList, context, advisorName),
                              // fdropdown(
                              //     "Select Term Period", defaultTerm, genderdropDownData,
                              //     (value) {
                              //   print("selected Value $value");
                              //   setState(() {
                              //     defaultTerm = value!;
                              //   });
                              // }),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 5),
                              //   child: buttonText(
                              //       "Your policy will be issued from " +
                              //           issuedDate.text +
                              //           " to " +
                              //           dateTimetoText(textToDateTime(issuedDate.text).add(
                              //               Duration(
                              //                   days: (defaultTerm == ""
                              //                           ? 1
                              //                           : int.parse(defaultTerm)) *
                              //                       365))),
                              //       14,
                              //       color: Colors.greenAccent),
                              // ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: buttonText(
                                    "Your Fd will be issued from ${controller.initialDate.text} to ${dateTimetoText(textToDateTime(controller.initialDate.text).add(Duration(days: int.parse(getFirstWord(controller.termSelected)) * 30)))}",
                                    14,
                                    color: Colors.redAccent),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        heading("Cummulative", 20),
                                        CummulativeToggle(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              formTextField(controller.nomineeName,
                                  "Nominee Name", "Enter Nominee Name"),
                              // streamNominees(provider.client_uid, context, nomineeName),

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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

                              const Spacer(),
                              customButton("Add to Database", () async {
                                var uuid = const Uuid();
                                String docId = uuid.v4();
                                if (controller.fdFormKey.currentState
                                        ?.validate() ==
                                    true) {
                                  // print("Take 1");
                                  //     updateStats(
                                  //         "sum_premium_amt",
                                  //         statsProvider.premiumAmtSum +
                                  //             int.parse(premiumAmt.text));
                                  //     updateCompanybussiness(int.parse(premiumAmt.text),
                                  //         provider.companyID);
                                  //     updateCompanyPlans(
                                  //         provider.companyID, "policy_count");
                                  controller.addFd(docId);
                                  //     print("Take 2");
                                  //     addCommision(
                                  //         provider.client_name,
                                  //         policyNumber.text,
                                  //         int.parse(premiumAmt.text),
                                  //         textToDateTime(issuedDate.text),
                                  //         getFirstWord(provider.companyName),
                                  //         statsProvider.healthPercent);
                                  //     makeATransaction(
                                  //         provider.client_uid,
                                  //         docId,
                                  //         policyNumber.text,
                                  //         provider.companyName,
                                  //         textToDateTime(issuedDate.text),
                                  //         defaultTerm == ""
                                  //             ? 1
                                  //             : int.parse(defaultTerm),
                                  //         int.parse(premiumAmt.text),
                                  //         provider.membersCount,
                                  //         textToDateTime(issuedDate.text));
                                  //     print("Take 3");
                                  //     sumAssured.text = "hello";
                                  //     Navigator.pop(context);
                                  //     Navigator.pop(context);
                                  //     Navigator.pop(context);
                                  //     Navigator.pop(context);
                                  //     Navigator.pop(context);
                                }
                              }, context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget noBorderTextField(TextEditingController controller, String labelText,
      String errorText, IconData icon,
      {bool isCompulsory = true,
      Function(String)? onChange,
      bool isAbsorbed = false,
      TextInputType? kType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: AbsorbPointer(
        absorbing: isAbsorbed,
        child: Container(
          child: TextFormField(
            onChanged: onChange,
            // keyboardType: kType,
            controller: controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 24,
              ),
              border: InputBorder.none,
              hintText: labelText,
              isDense: true,
              contentPadding: const EdgeInsets.only(top: 11),
            ),
            validator: (value) {
              if (isCompulsory) {
                if (value!.isEmpty) {
                  return errorText;
                }
                return null;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

class CummulativeToggle extends StatelessWidget {
  const CummulativeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final fdProvider = Provider.of<FDProvider>(context);
    return CupertinoSwitch(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: fdProvider.isCummulative,
      onChanged: (value) {
        final provider = Provider.of<FDProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
