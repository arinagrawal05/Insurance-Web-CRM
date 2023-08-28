import 'package:flutter/cupertino.dart';
import 'package:health_model/shared/regex.dart';

import '../../../shared/exports.dart';

// ignore: must_be_immutable
class EditFdDetails extends StatefulWidget {
  FdHiveModel model;

  EditFdDetails({
    super.key,
    required this.model,
  });
  @override
  State<EditFdDetails> createState() => _EditFdDetailsState();
}

class _EditFdDetailsState extends State<EditFdDetails> {
  // final TextEditingController investedAmt = TextEditingController();
  // final TextEditingController nomineeName = TextEditingController();
  // final TextEditingController nomineeRelation = TextEditingController();
  // final TextEditingController nomineeDob = TextEditingController();

  // final TextEditingController chequeNo = TextEditingController();
  // final TextEditingController bankDate = TextEditingController();
  // final TextEditingController bankName = TextEditingController();
  // TextEditingController initialDate =
  //     TextEditingController(text: todayTextFormat());

  // final TextEditingController fdNo = TextEditingController();
  // final TextEditingController maturityDate = TextEditingController();
  // final TextEditingController folioNo = TextEditingController();
  // final TextEditingController maturityAmt = TextEditingController();
  final fdFormKey = GlobalKey<FormState>();

  final TextEditingController investedAmt = TextEditingController();
  final TextEditingController investedDate = TextEditingController();
  final TextEditingController fdNo = TextEditingController();
  final TextEditingController maturityDate = TextEditingController();
  final TextEditingController folioNo = TextEditingController();
  final TextEditingController maturityAmt = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autofill();
  }

  autofill() {
    investedAmt.text = widget.model.investedAmt.toString();
    investedDate.text = dateTimetoText(widget.model.initialDate);
    // if (widget.model.fdStatus == "inHand") {
    fdNo.text = widget.model.fdNo;
    maturityAmt.text = widget.model.maturityAmt.toString();
    maturityDate.text = dateTimetoText(widget.model.maturityDate);
    folioNo.text = widget.model.folioNo;
    // }

    // f.text = widget.model.policyNo;
    // sumAssured.text = [widget.model.sumAssured.toString();
    // premiumAmt.text = widget.model.premuimAmt.toString();
    // issuedDate.text = dateTimetoText(widget.model.issuedDate);
    // inceptionDate.text = dateTimetoText(widget.model.inceptionDate);
    // nomineeName.text = widget.model.nomineeName;
    // advisorName.text = widget.model.advisorName;

    // defaultTerm = widget.model.advisorName;
  }

  // @override
  Widget build(BuildContext context) {
    FdHiveModel model = widget.model;

    // final provider = Provider.of<FDProvider>(context, listen: true);
    // final statsProvider =
    //     Provider.of<HealthStatsProvider>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: genericAppbar(),
      body: Consumer<FDProvider>(builder: (context, controller, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                                  // SizedBox(
                                  //   width: 160,
                                  //   child: noBorderTextField(
                                  //       controller.initialDate,
                                  //       "Initial Date",
                                  //       "Enter initial Date",
                                  //       Ionicons.calendar),
                                  // )
                                ],
                              ),
                              Container(
                                child: formTextField(
                                  investedAmt,
                                  "Invested Amount",
                                  "Enter Invested Amount",
                                  FieldRegex.integerRegExp,
                                ),
                              ),
                              Container(
                                child: formTextField(
                                  investedDate,
                                  "Invested Date",
                                  "Enter Invested Date",
                                  FieldRegex.integerRegExp,
                                ),
                              ),
                              if (
// model.fdStatus == "inHand"
                                  true) ...[
                                Container(
                                  child: formTextField(
                                    fdNo,
                                    "FD no",
                                    "Enter FD no",
                                    FieldRegex.integerRegExp,
                                  ),
                                ),
                                Container(
                                  child: formTextField(
                                    folioNo,
                                    "Folio no",
                                    "Enter Folio no",
                                    FieldRegex.integerRegExp,
                                  ),
                                ),
                                Container(
                                  child: formTextField(
                                    maturityAmt,
                                    "Maturity Amount",
                                    "Enter Maturity Amount",
                                    FieldRegex.integerRegExp,
                                  ),
                                ),
                                Container(
                                  child: formTextField(
                                    maturityDate,
                                    "Maturity Date",
                                    "Enter Maturity Date",
                                    FieldRegex.integerRegExp,
                                  ),
                                ),
                              ],
                              // Container(
                              //   child: formTextField(
                              //     controller.investedAmt,
                              //     "Invested Amount",
                              //     "Enter Invested Amount",
                              //     FieldRegex.integerRegExp,
                              //   ),
                              // ),

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
                              //     advisorName, "advisor Name", "Enter Nominee Name          "  ,      FieldRegex.alphabetRegExp,),
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
                              // genericPicker(
                              //     radius: 10,
                              //     prefixIcon: Ionicons.hourglass_outline,
                              //     height: 70,
                              //     width: MediaQuery.of(context).size.width,
                              //     controller.termList,
                              //     controller.termSelected,
                              //     "Choose Terms", (value) {
                              //   controller.selectTerm(value);
                              // }, context),

                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5)),
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 12),
                              //   child: Column(
                              //     children: [
                              //       Row(
                              //         // mainAxisAlignment:
                              //         //     MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Row(
                              //             children: [
                              //               // heading("Cummulative", 20),

                              //               CummulativeToggle(
                              //                   controller: controller,
                              //                   value:
                              //                       Cummulative.isCummulative),
                              //               heading("Cummulative", 20),
                              //             ],
                              //           ),
                              //           const SizedBox(
                              //             width: 50,
                              //           ),
                              //           Row(
                              //             children: [
                              //               CummulativeToggle(
                              //                   controller: controller,
                              //                   value: Cummulative
                              //                       .isNonCummulative),
                              //               heading("Non Cummulative", 20),
                              //             ],
                              //           ),
                              //           const SizedBox(
                              //             width: 40,
                              //           ),
                              //           Expanded(
                              //             child: AbsorbPointer(
                              //               absorbing: controller
                              //                           .isCummulative ==
                              //                       Cummulative.isCummulative
                              //                   ? true
                              //                   : false,
                              //               child: genericPicker(
                              //                 controller.cTermList,
                              //                 controller.cTermSelected,
                              //                 "Cummulative Term",
                              //                 (p0) {
                              //                   controller.selectCterm(p0);
                              //                 },
                              //                 context,
                              //               ),
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: formTextField(
                              //         controller.nomineeName,
                              //         "Nominee Name",
                              //         "Enter Nominee Name",
                              //         FieldRegex.nameRegExp,
                              //       ),
                              //     ),
                              //     Expanded(
                              //       flex: 1,
                              //       child: formTextField(
                              //         controller.nomineeRelation,
                              //         "Nominee Relation",
                              //         "Enter Nominee Relation",
                              //         FieldRegex.nameRegExp,
                              //       ),
                              //     ),
                              //     Expanded(
                              //       flex: 1,
                              //       child: formTextField(
                              //         controller.nomineeDob,
                              //         "Nominee DOB",
                              //         "Enter Nominee DOB",
                              //         FieldRegex.dateRegExp,
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // streamNominees(controller.client_uid, context,
                              //     controller.nomineeName,
                              //     isSingle: false,
                              //     nomineeDate: controller.nomineeDob,
                              //     nomineeRelation: controller.nomineeRelation),
                              // streamNominees(provider.client_uid, context, nomineeName),

                              // genericPicker(
                              //     radius: 10,
                              //     prefixIcon: Ionicons.card_outline,
                              //     height: 70,
                              //     width: MediaQuery.of(context).size.width,
                              //     controller.payModeList,
                              //     controller.payModeSelected,
                              //     "Choose Payment Mode", (value) {
                              //   controller.selectpayMode(value);
                              // }, context),

                              // controller.payModeSelected == "Cheque"
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Expanded(
                              //             flex: 1,
                              //             child: formTextField(
                              //               controller.chequeNo,
                              //               "Cheque No",
                              //               "Enter Cheque",
                              //               FieldRegex.integerRegExp,
                              //               isCompulsory: false,
                              //             ),
                              //           ),
                              //           Expanded(
                              //               flex: 1,
                              //               child: formTextField(
                              //                 controller.bankDate,
                              //                 "Date:DD/MM/YYYY",
                              //                 "Enter Date",
                              //                 FieldRegex.dateRegExp,
                              //                 isCompulsory: false,
                              //               )),
                              //           Expanded(
                              //             flex: 1,
                              //             child: formTextField(
                              //               controller.bankName,
                              //               "Bank Name",
                              //               "Enter Bank Name",
                              //               FieldRegex.nameRegExp,
                              //               isCompulsory: false,
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     : const SizedBox(),

                              const Spacer(),
                              customButton("update to Database", () async {
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
                                  controller
                                      .editFd(
                                          widget.model.fdId,
                                          investedDate.text,
                                          maturityDate.text,
                                          int.parse(investedAmt.text),
                                          int.parse(maturityAmt.text),
                                          fdNo.text,
                                          folioNo.text)
                                      .then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // Navigator.pop(context);
                                  });
                                  //     print("Take 2");
                                  // addCommision(
                                  //     controller.client_member_name,
                                  //     "Na",
                                  //     int.parse(controller.investedAmt.text),
                                  //     textToDateTime(
                                  //         controller.initialDate.text),
                                  //     getFirstWord(controller.companyName),
                                  //     getFdCommission(int.parse(getFirstWord(
                                  //         controller.termSelected))),
                                  //     AppConsts.fd);
                                  // makeATransaction(
                                  //     controller.client_uid,
                                  //     docId,
                                  //     "NA",
                                  //     controller.companyName,
                                  //     textToDateTime(
                                  //         controller.initialDate.text),
                                  //     int.parse(getFirstWord(
                                  //         controller.termSelected)),
                                  //     int.parse(controller.investedAmt.text),
                                  //     0,
                                  //     DateTime.now());
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
}

// ignore: must_be_immutable
class CummulativeToggle extends StatelessWidget {
  FDProvider controller;
  Cummulative value;
  CummulativeToggle({super.key, required this.controller, required this.value});

  @override
  Widget build(BuildContext context) {
    return Radio<Cummulative>(
        activeColor: primaryColor,
        value: value,
        groupValue: controller.isCummulative,
        onChanged: (val) {
          controller.toggleCummulative(val!);
        });
  }
}
