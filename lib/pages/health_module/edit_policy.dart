import '/shared/exports.dart';

// ignore: must_be_immutable
class EditDetailsPage extends StatefulWidget {
  PolicyHiveModel model;

  EditDetailsPage({
    super.key,
    required this.model,
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
    issuedDate.text = dateTimetoText(widget.model.issuedDate);
    inceptionDate.text = dateTimetoText(widget.model.inceptionDate);
    nomineeName.text = widget.model.nomineeName;
    advisorName.text = widget.model.advisorName;
    withGST = widget.model.premuimAmt;

    // defaultTerm = widget.model.advisorName;
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<PolicyProvider>(context, listen: true);
    final statsProvider = Get.find<DashProvider>();

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
                        policyNumber,
                        "Policy Number",
                        "Enter Policy Number",
                        FieldRegex.defaultRegExp,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: formTextField(
                          sumAssured,
                          "Sum Assured",
                          "Enter Sum Assured",
                          FieldRegex.integerRegExp,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        issuedDate,
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
                formTextField(premiumAmt, "premium Amount",
                    "Enter premium Amount", FieldRegex.integerRegExp,
                    isCompulsory: true, onChange: (val) {
                  setState(() {
                    withGST = int.parse(val);
                  });
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buttonText("With GST:${addHealthWithGST(withGST)}", 14,
                      color: Colors.redAccent),
                ),
                formTextField(
                  nomineeName,
                  "Nominee Name",
                  "Enter Nominee Name",
                  FieldRegex.nameRegExp,
                ),
                streamNominees(widget.model.userid, context, nomineeName),
                formTextField(
                  advisorName,
                  "advisor Name",
                  "Enter Nominee Name",
                  FieldRegex.defaultRegExp,
                ),
                renderAdvisor(statsProvider.advisorList, context, advisorName),
                genericPicker(
                    radius: 10,
                    prefixIcon: Ionicons.hourglass_outline,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    provider.termList,
                    provider.termSelected,
                    "Choose Terms", (value) {
                  provider.selectTerm(value);
                }, context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buttonText(
                      "Your policy will be issued from ${issuedDate.text} to ${dateTimetoText(textToDateTime(issuedDate.text).add(Duration(days: int.parse(AppUtils.getFirstWord(provider.termSelected)) * 365)))}",
                      14,
                      color: Colors.greenAccent),
                ),
                PaymodeSystem(
                    bankDate: provider.bankDate,
                    chequeNo: provider.chequeNo,
                    bankName: provider.bankName,
                    onSelectionDone: (value) {
                      provider.selectpayMode(value);
                    },
                    termSelected: provider.payModeSelected),
                SizedBox(
                  height: 20,
                ),
                customButton("Update In Database", () async {
                  if (_policyFormKey.currentState?.validate() == true) {
                    // updateStats(
                    //     "sum_premium_amt",
                    //     statsProvider.premiumAmtSum +
                    //         int.parse(premiumAmt.text));

                    // updateCompanybussiness(
                    //     widget.model.premuimAmt, provider.companyID,
                    //     negative: true);

                    updatePolicy(
                        textToDateTime(issuedDate.text),
                        textToDateTime(inceptionDate.text),
                        widget.model.policyID,
                        provider.termSelected);

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

  void updatePolicy(DateTime issuedDate, DateTime inceptionDate, String docId,
      String termSelected) {
    int term = int.parse(AppUtils.getFirstWord(termSelected));
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
    }).then((value) {
      PolicyHiveHelper.fetchHealthPoliciesFromFirebase();
    });
  }
}
