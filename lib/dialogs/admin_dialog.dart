import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/shared/exports.dart';

void adminDialog(
  BuildContext context,
  String companyId,
  String planId,
  //  int count
) {
  final statsProvider = Get.find<GeneralStatsProvider>();

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
  TextEditingController fdNoController = TextEditingController();
  TextEditingController folioController = TextEditingController();

  TextEditingController maturityAmt = TextEditingController();

  TextEditingController maturityDate =
      TextEditingController(text: dateTimetoText(model.maturityDate));
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
                  ),
                  formTextField(
                    fdNoController,
                    "FD number",
                    "Enter FD number",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: formTextField(
                      maturityAmt,
                      "Maturity Value",
                      "Enter Maturity Value",
                    ),
                  ),
                  formTextField(
                      maturityDate, "Maturity Date", "Enter Maturity Date"),

                  // textFormField(fdNoController, "FD number", Get.context!,
                  //     isExpanded: true),

                  const Spacer(),
                  customButton("Get Certificate", () {
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
                    // List list = advisorListField.text.split(",");
                    FirebaseFirestore.instance
                        .collection("Policies")
                        .doc(model.fdId)
                        .update({
                      "maturity_date": textToDateTime(maturityDate.text),
                      "maturity_amt": int.parse(maturityAmt.text),
                      "fd_taken_date": Timestamp.now(),
                      "fd_no": fdNoController.text,
                      "fd_status": FDStatus.inHand.name,
                      "folio_no": folioController.text,
                    }).then((value) {
                      PolicyHiveHelper.updateSpecificPolicy(
                          documentID: model.fdId);
                      Navigator.pop(Get.context!);
                      Navigator.pop(Get.context!);
                    });
                  }, Get.context!)
                ],
              ),
            ),
          ));
}
