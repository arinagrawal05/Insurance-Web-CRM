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
  List genderdropDownData = [
    {"title": "1 year", "value": "1"},
    {"title": "2 years", "value": "2"},
    {"title": "3 years", "value": "3"},
  ];
  String defaultTerm = "";

  List paymentdropDownData = [
    {"title": "net Banking", "value": "net Banking"},
    {"title": "credit/debit", "value": "credit/debit"},
    {"title": "UPI", "value": "UPI"},
  ];

  // List paymentdropDownData = [
  //   {"title": "net Banking", "value": "net Banking"},
  //   {"title": "credit/debit", "value": "credit/debit"},
  //   {"title": "UPI", "value": "UPI"},
  // ];

  String defaultpaymode = "";

  int withGST = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    PolicyHiveModel model = widget.model;
    final statsProvider = Get.find<GeneralStatsProvider>();

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
                      child: formTextField(policyNumber, "New Policy Number",
                          "Enter New Policy Number"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: formTextField(
                        issuedDate,
                        "Renewal Date:DD/MM/YYYY",
                        "Enter Renewal Date",
                      ),
                    ),
                  ],
                ),

                formTextField(
                    premiumAmt, "premium Amount", "Enter premium Amount",
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

                fdropdown("Select Term Period", defaultTerm, genderdropDownData,
                    (value) {
                  print("selected Value $value");
                  setState(() {
                    defaultTerm = value!;
                  });
                }),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buttonText(
                      "Your policy will be issued from " +
                          dateTimetoText(startingDate) +
                          " to " +
                          dateTimetoText(startingDate.add(Duration(
                              days: (defaultTerm == ""
                                      ? 1
                                      : int.parse(defaultTerm)) *
                                  365))),
                      14,
                      color: Colors.greenAccent),
                ),
                fdropdown(
                    "Select Payment Mode", defaultpaymode, paymentdropDownData,
                    (value) {
                  print("selected Value $value");
                  setState(() {
                    defaultpaymode = value!;
                  });
                }),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     heading("Members", 20),
                //     customButton("Add Member", () async {
                //       var uuid = Uuid();
                //       String docId = uuid.v4();
                //       addMemberSheet(context, widget.userid, docId);
                //     }, context, isExpanded: false),
                //   ],
                // ),

                SizedBox(
                  height: 100,
                ),
                customButton("Renew", () async {
                  print(startingDate);
                  int term = defaultTerm == "" ? 1 : int.parse(defaultTerm);

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
