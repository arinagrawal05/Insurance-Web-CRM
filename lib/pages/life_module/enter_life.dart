import 'package:health_model/providers/life_provider.dart';

import '../../../../shared/exports.dart';

// ignore: must_be_immutable
class EnterLifeDetails extends StatefulWidget {
  // String inceptionDate;
  // EnterLifeDetails({required this.inceptionDate});
  @override
  // ignore: library_private_types_in_public_api
  _EnterLifeDetailsState createState() => _EnterLifeDetailsState();
}

class _EnterLifeDetailsState extends State<EnterLifeDetails> {
  int withGST = 0;
  // TextEditingController payingTerm = TextEditingController();
  @override
  void initState() {
    super.initState();
    // inceptionDate.text = widget.inceptionDate;
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PolicyProvider>(context, listen: false);
    Get.put(DashProvider(), tag: 'statsFor${ProductType.life.name}');
    final statsProvider = Get.find<DashProvider>(
      tag: 'statsFor${ProductType.life.name}',
    );

    return Scaffold(
        body: Consumer<LifeProvider>(builder: (context, controller, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.lifeFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chooseHeader("Fill Life Details", 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        controller.lifeNumber,
                        "Policy Number",
                        "Enter Policy Number",
                        FieldRegex.defaultRegExp,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(
                          controller.sumAssured,
                          "Sum Assured",
                          "Enter Sum Assured",
                          FieldRegex.integerRegExp,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        controller.issuedDate,
                        "Commitment Date:DD/MM/YYYY",
                        "Enter Commitment Date",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.3,
                //   child: formTextField(
                //     payingTerm,
                //     "Paying Term",
                //     "Enter Paying Term",
                //     FieldRegex.dateRegExp,
                //   ),
                // ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            withGST = int.parse(val);
                          });
                        },
                        controller: controller.premiumAmt,
                        decoration: InputDecoration(
                          suffix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 21),
                            child: buttonText(
                                "With GST:${addLifeWithGST(withGST, isFirst: true)}",
                                14,
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
                    ),
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  PaytermToggle(
                                      controller: controller,
                                      value: Payterm.quarterly),
                                  heading("Quarterly", 20),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  PaytermToggle(
                                      controller: controller,
                                      value: Payterm.halfYearly),
                                  heading("Half Yearly", 20),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  PaytermToggle(
                                      controller: controller,
                                      value: Payterm.yearly),
                                  heading("Yearly", 20),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buttonText("Select Paid Terms", 14,
                                color: Colors.black),
                            genericPicker(
                                radius: 10,
                                prefixIcon: Ionicons.hourglass_outline,
                                height: 70,
                                width: MediaQuery.of(context).size.width,
                                controller.termList,
                                controller.paidTermSelected,
                                "Choose Paid Terms", (value) {
                              controller.selectPaidTerm(value);
                            }, context),
                            buttonText(
                                "Your last Renewal will be paid on ${dateTimetoText(textToDateTime(controller.issuedDate.text).add(Duration(days: int.parse(AppUtils.getFirstWord(controller.paidTermSelected)) * 365)))}",
                                14,
                                color: Colors.greenAccent),
                          ],
                        ),
                      )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buttonText("Select Matured Terms", 14,
                                  color: Colors.black),
                              genericPicker(
                                  radius: 10,
                                  prefixIcon: Ionicons.hourglass_outline,
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  controller.termList,
                                  controller.maturedTermSelected,
                                  "Choose Matured Terms", (value) {
                                controller.selectMaturedterm(value);
                              }, context),
                              buttonText(
                                  "Your policy will be matured on ${dateTimetoText(textToDateTime(controller.issuedDate.text).add(Duration(days: int.parse(AppUtils.getFirstWord(controller.maturedTermSelected)) * 365)))}",
                                  14,
                                  color: Colors.redAccent),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                formTextField(
                  controller.advisorName,
                  "advisor Name",
                  "Enter Nominee Name",
                  FieldRegex.defaultRegExp,
                ),
                renderAdvisor(
                    statsProvider.advisorList, context, controller.advisorName),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: formTextField(
                        controller.nomineeName,
                        "Nominee Name",
                        "Enter Nominee Name",
                        FieldRegex.nameRegExp,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: formTextField(
                        controller.nomineeRelation,
                        "Nominee Relation",
                        "Enter Nominee Relation",
                        FieldRegex.nameRegExp,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: formTextField(
                        controller.nomineeDob,
                        "Nominee DOB",
                        "Enter Nominee DOB",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
                ),
                streamNominees(
                    controller.client_uid, context, controller.nomineeName,
                    isSingle: false,
                    nomineeDate: controller.nomineeDob,
                    nomineeRelation: controller.nomineeRelation),

                PaymodeSystem(
                    bankDate: controller.bankDate,
                    chequeNo: controller.chequeNo,
                    bankName: controller.bankName,
                    onSelectionDone: (value) {
                      controller.selectpayMode(value);
                    },
                    termSelected: controller.payModeSelected),
                customButton("Add Life to Database", () async {
                  if (controller.lifeFormKey.currentState?.validate() == true) {
                    var uuid = const Uuid();
                    String docId = uuid.v4();

                    controller.performLifePolicyFunctions(
                      docId,
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                }, context),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

class PaytermToggle extends StatelessWidget {
  LifeProvider controller;
  Payterm value;
  PaytermToggle({super.key, required this.controller, required this.value});

  @override
  Widget build(BuildContext context) {
    return Radio<Payterm>(
        activeColor: primaryColor,
        value: value,
        groupValue: controller.payterm,
        onChanged: (val) {
          controller.togglePayterm(val!);
        });
  }
}
