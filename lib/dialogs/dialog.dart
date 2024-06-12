import 'dart:async';

import 'package:get/get_connect/http/src/utils/utils.dart';

import '/shared/exports.dart';

// void adminDialog(
//   BuildContext context,

//   //  int count
// ) {
//   showDialog(
//       useSafeArea: true,
//       context: context,
//       builder: (context) => Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)), //this right here
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [],
//               ),
//             ),
//           ));
// }

void showCertificateDialog(FdHiveModel model) {
  // final statsProvider = Get.find<DashProvider>();

  TextEditingController fdNoController = TextEditingController();
  TextEditingController folioController = TextEditingController();

  TextEditingController maturityAmt = TextEditingController();

  TextEditingController maturityDate =
      TextEditingController(text: dateTimetoText(model.renewalDate));
  void getCertificate() {
    FirebaseFirestore.instance.collection("Policies").doc(model.fdId).update({
      "maturity_date": textToDateTime(maturityDate.text),
      "maturity_amt": int.parse(maturityAmt.text),
      "fd_taken_date": Timestamp.now(),
      "fd_no": fdNoController.text,
      "fd_status": FDStatus.inHand.name,
      "folio_no": folioController.text,
    }).then((value) {
      PolicyHiveHelper.fetchFDPoliciesFromFirebase();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    });
  }

  showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              padding: const EdgeInsets.all(25.0),
              height: 550.0,
              width: 900.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  heading("Certificate Submission", 22),
                  formTextField(
                    folioController,
                    "Folio number",
                    "Enter Folio number",
                    FieldRegex.defaultRegExp,
                  ),
                  formTextField(
                    fdNoController,
                    "FD number",
                    "Enter FD number",
                    FieldRegex.defaultRegExp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: formTextField(
                      maturityAmt,
                      "Maturity Value",
                      "Enter Maturity Value",
                      FieldRegex.integerRegExp,
                    ),
                  ),
                  formTextField(
                    maturityDate,
                    "Maturity Date",
                    "Enter Maturity Date",
                    FieldRegex.dateRegExp,
                  ),

                  // textFormField(fdNoController, "FD number", Get.context!,
                  //     isExpanded: true),

                  const Spacer(),
                  customButton("Get Certificate", () {
                    if (AppConsts.isProductionMode) {
                      print("Take 1");
                      addCommision(
                          model.name,
                          fdNoController.text,
                          model.investedAmt,
                          DateTime.now(),
                          model.companyName,
                          getFdCommission(model.fDterm),
                          AppConsts.fd);
                      makeATransaction(
                          model.userid,
                          model.fdId,
                          fdNoController.text,
                          model.companyName,
                          model.initialDate,
                          model.fDterm,
                          model.investedAmt,
                          int.parse(maturityAmt.text),
                          textToDateTime(maturityDate.text),
                          AppConsts.fd);
                    }
                    getCertificate();
                    // List list = advisorListField.text.split(",");
                  }, Get.context!)
                ],
              ),
            ),
          ));
}

void showRenewLifeDialog(LifeHiveModel model) {
  // final statsProvider = Get.find<DashProvider>();
  DateTime newDate = model.renewalDate
      .add(getLifeDuration(EnumUtils.convertNameToPayterm(model.payterm)));
  final TextEditingController chequeNo = TextEditingController();
  final TextEditingController bankDate = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  String termSelected = "Cheque";

  void renewLife() {
    FirebaseFirestore.instance.collection("Policies").doc(model.lifeID).update({
      "last_renew_date": DateTime.now(),
      "renewal_date": newDate,
      "paymode": termSelected,
      "bank_details":
          "${chequeNo.text} || ${bankName.text} || ${bankDate.text}",
      "times_paid": model.timesPaid + 1,
      // "a"
      // "maturity_amt": int.parse(maturityAmt.text),
      // "fd_taken_date": Timestamp.now(),
      // "fd_no": fdNoController.text,
      // "fd_status": FDStatus.inHand.name,
      // "folio_no": folioController.text,
    }).then((value) {
      PolicyHiveHelper.fetchLifePoliciesFromFirebase();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    });
  }

  showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              padding: const EdgeInsets.all(25.0),
              height: 550.0,
              width: 700.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // heading("${model.companyName}'s Renewal", 22),
                  companyShowcase(context,
                      imgUrl: model.companyLogo,
                      leadingText: "${model.timesPaid + 1}th Premium",
                      title: model.companyName,
                      subtitle:
                          "payable till ${dateTimetoText(model.payingTillDate)}"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        productTileText(
                          "Premium",
                          24,
                        ),
                        productTileText(
                          "${model.premuimAmt}",
                          24,
                        ),
                        productTileText(
                            "+${addLifeWithGST(model.premuimAmt) - model.premuimAmt}",
                            24,
                            color: Colors.green),
                        productTileText(
                          "${addLifeWithGST(model.premuimAmt)}",
                          24,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      productTileText(
                        dateTimetoText(model.renewalDate),
                        24,
                      ),
                      const Expanded(
                          child: Divider(
                        endIndent: 10,
                        indent: 10,
                      )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            const Icon(Ionicons.cash_outline),
                            buttonText(
                              model.payterm,
                              15,
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        endIndent: 10,
                        indent: 10,
                      )),
                      productTileText(
                        dateTimetoText(newDate),
                        24,
                      ),
                    ],
                  )
                  // formTextField(
                  //   folioController,
                  //   "Folio number",
                  //   "Enter Folio number",
                  //   FieldRegex.defaultRegExp,
                  // ),
                  // formTextField(
                  //   fdNoController,
                  //   "FD number",
                  //   "Enter FD number",
                  //   FieldRegex.integerRegExp,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: formTextField(
                  //     maturityAmt,
                  //     "Maturity Value",
                  //     "Enter Maturity Value",
                  //     FieldRegex.integerRegExp,
                  //   ),
                  // ),
                  // formTextField(
                  //   maturityDate,
                  //   "Maturity Date",
                  //   "Enter Maturity Date",
                  //   FieldRegex.dateRegExp,
                  // ),
                  ,
                  const Spacer(),
                  PaymodeSystem(
                      bankDate: bankDate,
                      chequeNo: chequeNo,
                      bankName: bankName,
                      onSelectionDone: (val) {
                        termSelected = val;
                      },
                      termSelected: termSelected),
                  // textFormField(fdNoController, "FD number", Get.context!,
                  //     isExpanded: true),

                  const Spacer(),
                  customButton("Renew", () {
                    // if (AppConsts.isProductionMode) {

                    addCommision(model.name, model.lifeNo, model.premuimAmt,
                        DateTime.now(), model.companyName, 0, AppConsts.life);
                    makeATransaction(
                        model.userid,
                        model.lifeID,
                        model.lifeNo,
                        model.companyName,
                        model.renewalDate,
                        getLifeTerm(
                            EnumUtils.convertNameToPayterm(model.payterm)),
                        addLifeWithGST(model.premuimAmt, isFirst: false),
                        model.timesPaid + 1,
                        newDate,
                        AppConsts.life);
                    // }
                    renewLife();
                    // List list = advisorListField.text.split(",");
                  }, Get.context!)
                ],
              ),
            ),
          ));
}

// bool? isUnlocked;
// TextEditingController titleController = TextEditingController();
// await showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//     title: const Text(
//       'Add New Event',
//       textAlign: TextAlign.center,
//     ),
//     content: TextField(
//       controller: titleController,
//       textCapitalization: TextCapitalization.words,
//       decoration: const InputDecoration(
//         labelText: 'Title',
//       ),
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//           isUnlocked = false;
//         },
//         child: const Text('Cancel'),
//       ),
//       TextButton(
//         child: const Text('Unlock Add Event'),
//         onPressed: () {
//           if (titleController.text.isNotEmpty &&
//               titleController.text == pin) {
//             isUnlocked = true;
//             return;
//           }
//         },
//       )
//     ],
//   ),
// );
// if (isUnlocked != null) {
//   return isUnlocked!;
// } else {
//   return false;
// }
Future<bool?> showTextFieldDialog(BuildContext context, String pin) async {
  TextEditingController textFieldController = TextEditingController();
  Completer<bool?> completer = Completer<bool?>();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Pin'),
        content: TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            hintText: 'Enter Pin',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          TextButton(
            child: Text('Unlock'),
            onPressed: () {
              String text = textFieldController.text;
              bool isValid = text == pin; // Add your validation logic here
              Navigator.of(context).pop(isValid);
            },
          ),
        ],
      );
    },
  ).then((value) {
    completer.complete(value);
  });

  return completer.future;
}
