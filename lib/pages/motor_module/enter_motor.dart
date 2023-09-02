import 'package:health_model/providers/life_provider.dart';

import '../../../../shared/exports.dart';
import '../../providers/motor_provider.dart';

// ignore: must_be_immutable
class EnterMotorDetails extends StatefulWidget {
  String? motorID;
  EnterMotorDetails({this.motorID});
  @override
  // ignore: library_private_types_in_public_api
  _EnterMotorDetailsState createState() => _EnterMotorDetailsState();
}

class _EnterMotorDetailsState extends State<EnterMotorDetails> {
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
    Get.put(DashProvider(), tag: 'statsFor${ProductType.motor.name}');
    final statsProvider = Get.find<DashProvider>(
      tag: 'statsFor${ProductType.motor.name}',
    );

    return Scaffold(
        body: Consumer<MotorProvider>(builder: (context, controller, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.motorFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chooseHeader("Fill motors Details", 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        controller.motorNumber,
                        "Policy Number",
                        "Enter Policy Number",
                        FieldRegex.defaultRegExp,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(
                          controller.sumAssured,
                          "Insured Declared Value",
                          "Enter Insured Declared Value",
                          FieldRegex.integerRegExp,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                          controller.issuedDate,
                          "Policy Date:DD/MM/YYYY",
                          "Enter Policy Date",
                          FieldRegex.dateRegExp, onChange: (val) {
                        controller.expiryDate.text = dateTimetoText(
                            textToDateTime(val).add(const Duration(days: 365)));
                      }),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: buttonText(
                                  "With GST:${addHealthWithGST(
                                    withGST,
                                  )}",
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
                    ],
                  ),
                ),
                formTextField(
                  controller.expiryDate,
                  "Expiry Date:DD/MM/YYYY",
                  "Enter Expiry Date",
                  FieldRegex.defaultRegExp,
                ),
                formTextField(
                  controller.previousCompany,
                  "Previous Company",
                  "Enter Previous Company",
                  FieldRegex.defaultRegExp,
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
                        controller.nomineeDob,
                        "Nominee DOB",
                        "Enter Nominee DOB",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
                ),
                // streamNominees(
                //     controller.client_uid, context, controller.nomineeName,
                //     isSingle: false,
                //     nomineeDate: controller.nomineeDob,
                //     nomineeRelation: controller.nomineeRelation),

                PaymodeSystem(
                    bankDate: controller.bankDate,
                    chequeNo: controller.chequeNo,
                    bankName: controller.bankName,
                    onSelectionDone: (value) {
                      controller.selectpayMode(value);
                    },
                    termSelected: controller.payModeSelected),
                customButton("Add General to Database", () async {
                  if (controller.motorFormKey.currentState?.validate() ==
                      true) {
                    if (widget.motorID == null) {
                      var uuid = const Uuid();
                      String docId = uuid.v4();

                      controller.performMotorPolicyFunctions(
                        "aello",
                      );
                    } else {
                      controller.renewMotor(
                        widget.motorID!,
                      );
                    }

                    // Navigator.pop(context);
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
    }));
  }
}
