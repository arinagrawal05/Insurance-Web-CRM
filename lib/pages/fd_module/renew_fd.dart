import 'package:flutter/cupertino.dart';
import '/widgets/pay_system.dart';
import '/shared/regex.dart';

import '../../../../shared/exports.dart';

// ignore: must_be_immutable
class RenewFdPage extends StatefulWidget {
  final FdHiveModel model;

  const RenewFdPage({super.key, required this.model});

  @override
  State<RenewFdPage> createState() => _RenewFdPageState();
}

final policyNumber = TextEditingController();

final investedAmt = TextEditingController();
final issuedDate = TextEditingController(text: todayTextFormat());

class _RenewFdPageState extends State<RenewFdPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    investedAmt.text = widget.model.maturityAmt != 0
        ? widget.model.maturityAmt.toString()
        : widget.model.investedAmt.toString();

    // setLoginPref(true);
  }

  // @override
  Widget build(BuildContext context) {
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 45),
                            // height: 200,
                            // width: 150,
                            child: Icon(
                              Ionicons.person_outline,
                              size: 80,
                            ),
                          ),
                          heading(widget.model.name, 22),
                          heading1(widget.model.headName + "'s member", 15),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          userDetailShow("phone", widget.model.phone,
                              Ionicons.phone_portrait_outline),
                          userDetailShow(
                              "email", widget.model.email, Ionicons.mail),
                          userDetailShow(
                              "Birthday",
                              dateTimetoText(widget.model.dob),
                              Ionicons.medical_outline),
                          userDetailShow(
                              "Gender",
                              widget.model.isMale ? "Male" : "Female",
                              widget.model.isMale
                                  ? Ionicons.man_outline
                                  : Ionicons.woman_outline),
                          userDetailShow("Address", widget.model.address,
                              Ionicons.home_outline),
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
                                  heading("Fill Renewal Details", 22),
                                  Container(
                                    width: 160,
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
                                  investedAmt,
                                  "Invested Amount",
                                  "Enter Invested Amount",
                                  FieldRegex.integerRegExp,
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
                              //           SizedBox(
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
                              //           SizedBox(
                              //             width: 40,
                              //           ),
                              //           Expanded(
                              //             child: AbsorbPointer(
                              //               absorbing: controller
                              //                           .isCummulative ==
                              //                       Cummulative.isNonCummulative
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

                              // streamNominees(provider.client_uid, context, nomineeName),
                              PaymodeSystem(
                                  bankDate: controller.bankDate,
                                  chequeNo: controller.chequeNo,
                                  bankName: controller.bankName,
                                  onSelectionDone: (value) {
                                    controller.selectpayMode(value);
                                  },
                                  termSelected: controller.payModeSelected),
                              const Spacer(),
                              customButton("Renew this FD", () async {
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
                                  controller.renewFd(widget.model.fdId,
                                      int.parse(investedAmt.text));

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

// ignore: must_be_immutable