import 'package:health_model/regex.dart';

import '../../shared/exports.dart';

// ignore: must_be_immutable
class RenewPolicyPage extends StatefulWidget {
  PolicyHiveModel model;
  RenewPolicyPage({required this.model});
  @override
  _RenewPolicyPageState createState() => _RenewPolicyPageState();
}

class _RenewPolicyPageState extends State<RenewPolicyPage> {
  final policyNumber = TextEditingController();

  final premiumAmt = TextEditingController();
  final issuedDate = TextEditingController(text: todayTextFormat());

  final _policyFormKey = GlobalKey<FormState>();

  int withGST = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    PolicyHiveModel model = widget.model;
    final statsProvider = Get.find<DashProvider>();
    final provider = Provider.of<PolicyProvider>(context, listen: true);

    DateTime startingDate = textToDateTime(issuedDate.text);
    if (model.renewalDate.isAfter(textToDateTime(issuedDate.text))) {
      startingDate = model.renewalDate;
    } else {
      startingDate = textToDateTime(issuedDate.text);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _policyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chooseHeader("Renew Fill Details", 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        policyNumber,
                        "New Policy Number",
                        "Enter New Policy Number",
                        FieldRegex.integerRegExp,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        issuedDate,
                        "Renewal Date:DD/MM/YYYY",
                        "Enter Renewal Date",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
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
                  child: buttonText(
                      "With GST:" + addWithGST(withGST).toString(), 14,
                      color: Colors.redAccent),
                ),

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
                      "Your policy will be issued from " +
                          dateTimetoText(startingDate) +
                          " to " +
                          dateTimetoText(startingDate.add(Duration(
                              days: (int.parse(AppUtils.getFirstWord(
                                      provider.termSelected))) *
                                  365))),
                      14,
                      color: Colors.greenAccent),
                ),
                genericPicker(
                    radius: 10,
                    prefixIcon: Ionicons.card_outline,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    provider.payModeList,
                    provider.payModeSelected,
                    "Choose Payment Mode", (value) {
                  provider.selectpayMode(value);
                }, context),
                provider.payModeSelected == "Cheque"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: formTextField(
                              provider.bankName,
                              "Bank Name",
                              "Enter Bank Name",
                              FieldRegex.nameRegExp,
                              isCompulsory: false,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: formTextField(
                                provider.bankDate,
                                "Date:DD/MM/YYYY",
                                "Enter Date",
                                FieldRegex.dateRegExp,
                                isCompulsory: false,
                              )),
                          Expanded(
                            flex: 1,
                            child: formTextField(
                              provider.chequeNo,
                              "Cheque No",
                              "Enter Cheque",
                              FieldRegex.integerRegExp,
                              isCompulsory: false,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                // fdropdown(
                //     "Select Payment Mode", defaultpaymode, paymentdropDownData,
                //     (value) {
                //   print("selected Value $value");
                //   setState(() {
                //     defaultpaymode = value!;
                //   });
                // }),

                SizedBox(
                  height: 100,
                ),
                customButton("Renew", () async {
                  print(startingDate);
                  int term =
                      int.parse(AppUtils.getFirstWord(provider.termSelected));

                  // var uuid = Uuid();
                  // String docId = uuid.v4();
                  if (_policyFormKey.currentState?.validate() == true) {
                    updateStats(
                        "sum_premium_amt",
                        statsProvider.premiumAmtSum +
                            int.parse(premiumAmt.text));
                    updateCompanybussiness(
                        int.parse(premiumAmt.text), model.companyID);
                    makeARenewal(
                      startingDate.add(Duration(days: term * 365)),
                      model.policyID,
                    );
                    addCommision(
                        model.name,
                        policyNumber.text,
                        int.parse(premiumAmt.text),
                        textToDateTime(issuedDate.text),
                        AppUtils.getFirstWord(model.companyName),
                        statsProvider.healthPercent.toDouble(),
                        "Health");
                    makeATransaction(
                      model.userid,
                      model.policyID,
                      policyNumber.text,
                      model.companyName,
                      startingDate,
                      term,
                      int.parse(premiumAmt.text),
                      model.membersCount,
                      textToDateTime(issuedDate.text),
                    );

                    // print(widget);
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
}
