import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/hive/hive_model/policy_models/life_model.dart';
import 'package:health_model/widgets/pay_system.dart';
import 'package:health_model/shared/regex.dart';
import 'package:health_model/shared/exports.dart';

void adminDialog(
  BuildContext context,
  String companyId,
  String planId,
  //  int count
) {
  final statsProvider = Get.find<DashProvider>();

  TextEditingController advisorListField =
      TextEditingController(text: statsProvider.advisorList.join(","));

  TextEditingController pinField =
      TextEditingController(text: statsProvider.adminPin);
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading("Add Advisors", 20),
                  customTextfield(advisorListField, "Add advisors", context,
                      isExpanded: true),
                  customTextfield(pinField, "Admins Pin", context,
                      isExpanded: true),
                  const Spacer(),
                  customButton("Save Panel Settings", () {
                    // List list = advisorListField.text.split(",");
                    FirebaseFirestore.instance
                        .collection("Statistics")
                        .doc("KdMlwAoBwwkdREqX3hIe")
                        .update({
                      "advisor_list": advisorListField.text.split(","),
                      "admin_pin": pinField.text,
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  }, context)
                ],
              ),
            ),
          ));
}

void showCertificateDialog(FdHiveModel model) {
  // final statsProvider = Get.find<DashProvider>();

  TextEditingController fdNoController = TextEditingController();
  TextEditingController folioController = TextEditingController();

  TextEditingController maturityAmt = TextEditingController();

  TextEditingController maturityDate =
      TextEditingController(text: dateTimetoText(model.maturityDate));
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
                    FieldRegex.integerRegExp,
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
                      updateCompanybussiness(
                          model.investedAmt, model.companyID);
                      updateCompanyPlans(model.companyID, "policy_count");
                      addCommision(
                          model.name,
                          model.fdNo,
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
                          textToDateTime(maturityDate.text));
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
              width: 700.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // heading("${model.companyName}'s Renewal", 22),
                  Row(
                    children: [
                      companyLogo(model.companyLogo, size: 60),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heading(model.companyName, 20),
                          heading1(
                              "payable till " +
                                  dateTimetoText(model.payingTillDate),
                              12),
                        ],
                      ),
                      Spacer(),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(7),
                          decoration: dashBoxDex(context)
                              .copyWith(color: Colors.black26),
                          child: simpleText(
                              (model.timesPaid + 1).toString() + "th Premuim",
                              12)),
                    ],
                  ),
                  Row(
                    children: [
                      productTileText(
                        "${dateTimetoText(model.renewalDate)}",
                        24,
                      ),
                      Expanded(
                          child: Divider(
                        endIndent: 10,
                        indent: 10,
                      )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Icon(Ionicons.cash_outline),
                            buttonText(model.payterm, 15, color: Colors.black45)
                          ],
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        endIndent: 10,
                        indent: 10,
                      )),
                      productTileText(
                        "${dateTimetoText(newDate)}",
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
                    //   print("Take 1");
                    //   updateCompanybussiness(
                    //       model.investedAmt, model.companyID);
                    //   updateCompanyPlans(model.companyID, "policy_count");
                    addCommision(model.name, model.lifeNo, model.premuimAmt,
                        DateTime.now(), model.companyName, 0, AppConsts.fd);
                    makeATransaction(
                        model.userid,
                        model.lifeID,
                        model.lifeNo,
                        model.companyName,
                        model.renewalDate,
                        getLifeTerm(
                            EnumUtils.convertNameToPayterm(model.payterm)),
                        model.premuimAmt,
                        model.timesPaid + 1,
                        newDate);
                    // }
                    renewLife();
                    // List list = advisorListField.text.split(",");
                  }, Get.context!)
                ],
              ),
            ),
          ));
}
