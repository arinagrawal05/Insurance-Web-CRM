import 'package:health_model/providers/life_provider.dart';
import 'package:health_model/regex.dart';

import '../../shared/exports.dart';

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
  TextEditingController payingTerm = TextEditingController();
  @override
  void initState() {
    super.initState();
    payingTerm.text = "1";
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
                    payingTerm,
                    "Paying Term",
                    "Enter Paying Term",
                    FieldRegex.dateRegExp,
                  ),
                ),
                TextFormField(
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
                          "With GST:${addLifeWithGST(withGST, int.parse(payingTerm.text[0]))}",
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
                formTextField(
                  controller.advisorName,
                  "advisor Name",
                  "Enter Nominee Name",
                  FieldRegex.defaultRegExp,
                ),
                renderAdvisor(
                    statsProvider.advisorList, context, controller.advisorName),
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
                      "Your policy will be issued from ${controller.issuedDate.text} to ${dateTimetoText(textToDateTime(controller.issuedDate.text).add(Duration(days: int.parse(AppUtils.getFirstWord(payingTerm.text)) * 365)))}",
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
                              FieldRegex.nameRegExp,
                              isCompulsory: false,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: formTextField(
                                controller.bankDate,
                                "Date:DD/MM/YYYY",
                                "Enter Date",
                                FieldRegex.dateRegExp,
                                isCompulsory: false,
                              )),
                          Expanded(
                            flex: 1,
                            child: formTextField(
                              controller.chequeNo,
                              "Cheque No",
                              "Enter Cheque",
                              FieldRegex.integerRegExp,
                              isCompulsory: false,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                customButton("Add Life to Database", () async {
                  if (controller.lifeFormKey.currentState?.validate() == true) {
                    // var uuid = const Uuid();
                    // String docId = uuid.v4();

                    controller.performLifePolicyFunctions(
                      "aello",
                    );
                    Navigator.pop(context);
                    // Navigator.pop(context);
                    // Navigator.pop(context);
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
