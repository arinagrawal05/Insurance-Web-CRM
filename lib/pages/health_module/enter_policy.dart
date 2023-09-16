import '../../../shared/exports.dart';

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
    // final provider = Provider.of<PolicyProvider>(context, listen: false);
    Get.put(DashProvider(), tag: 'statsFor${ProductType.health.name}');
    final statsProvider = Get.find<DashProvider>(
      tag: 'statsFor${ProductType.health.name}',
    );

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
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: buttonText(
                          "With GST:${addHealthWithGST(withGST)}", 14,
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
                    if (!FieldRegex.integerRegExp.hasMatch(value!)) {
                      return 'premium Amount does not match the criteria';
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
                streamNominees(
                    controller.client_uid, context, controller.nomineeName),
                formTextField(
                  controller.advisorName,
                  "advisor Name",
                  "Enter Nominee Name",
                  FieldRegex.defaultRegExp,
                ),
                renderAdvisor(
                  statsProvider.advisorList,
                  context,
                  controller.advisorName,
                ),
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
                PaymodeSystem(
                    bankDate: controller.bankDate,
                    chequeNo: controller.chequeNo,
                    bankName: controller.bankName,
                    onSelectionDone: (value) {
                      controller.selectpayMode(value);
                    },
                    termSelected: controller.payModeSelected),
                customButton("Add to Database", () async {
                  if (
                      // controller.policyFormKey.currentState?.validate() ==
                      true) {
                    var uuid = const Uuid();
                    String docId = uuid.v4();

                    controller.performHealthPolicyFunctions(
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
    }));
  }
}
