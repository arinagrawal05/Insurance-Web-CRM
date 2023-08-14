import 'package:health_model/regex.dart';

import '../../shared/exports.dart';

// ignore: must_be_immutable
class EnterPolicyDetails extends StatefulWidget {
  String inceptionDate;
  EnterPolicyDetails({required this.inceptionDate});
  @override
  // ignore: library_private_types_in_public_api
  _EnterPolicyDetailsState createState() => _EnterPolicyDetailsState();
}

class _EnterPolicyDetailsState extends State<EnterPolicyDetails> {
  int withGST = 0;
  TextEditingController inceptionDate = TextEditingController();
  @override
  void initState() {
    super.initState();
    inceptionDate.text = widget.inceptionDate;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PolicyProvider>(context, listen: false);
    final statsProvider = Get.find<DashProvider>(
      tag: 'statsFor${ProductType.health.name}',
    );

    return Scaffold(
      body: GetBuilder<DashProvider>(
          init: DashProvider(),
          builder: (context) {
            return Consumer<PolicyProvider>(
                builder: (context, controller, child) {
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
                              child: formTextField(
                                controller.policyNumber,
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
                            inceptionDate,
                            "Inception Date:DD/MM/YYYY",
                            "Enter Inception Date",
                            FieldRegex.dateRegExp,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: buttonText(
                                  "With GST:${addWithGST(withGST)}", 14,
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
                        formTextField(
                          controller.nomineeName,
                          "Nominee Name",
                          "Enter Nominee Name",
                          FieldRegex.nameRegExp,
                        ),
                        streamNominees(provider.client_uid, context,
                            controller.nomineeName),
                        formTextField(
                          controller.advisorName,
                          "advisor Name",
                          "Enter Nominee Name",
                          FieldRegex.defaultRegExp,
                        ),
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
                              "Your policy will be issued from ${controller.issuedDate.text} to ${dateTimetoText(textToDateTime(controller.issuedDate.text).add(Duration(days: int.parse(AppUtils.getFirstWord(controller.termSelected)) * 365)))}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        customButton("Add to Database", () async {
                          if (
                              // controller.policyFormKey.currentState?.validate() ==
                              true) {
                            var uuid = const Uuid();
                            String docId = uuid.v4();

                            controller.performPolicyFunctions(
                                docId, statsProvider, inceptionDate.text);
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
            });
          }),
    );
  }
}
