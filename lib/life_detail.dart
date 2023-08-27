import 'package:health_model/dialogs/dialog.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/hive/hive_model/policy_models/life_model.dart';
import 'package:health_model/policy_flow/edit_fd.dart';
import 'package:health_model/renew_fd.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/statements.dart';
import 'package:health_model/stepper.dart';

// ignore: must_be_immutable
class LifeDetailPage extends StatelessWidget {
  LifeHiveModel model;
  LifeDetailPage({required this.model});
  late TooltipBehavior tooltip = TooltipBehavior();

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    // final provider = Provider.of<StatsProvider>(context, listen: true);
    // PolicyModel model = model;
    // final provider = Provider.of<PolicyProvider>(context, listen: false);

    return Scaffold(
      appBar: genericAppbar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                decoration: dashBoxDex(context),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: heading(" Client Profile", 18),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 45),
                      // height: 200,
                      // width: 150,
                      child: const Icon(
                        Ionicons.person_outline,
                        size: 80,
                      ),
                    ),
                    Column(
                      children: [
                        heading(model.name, 22),
                      ],
                    ),
                    heading1("${model.headName}'s member", 15),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    userDetailShow(
                        "phone", model.phone, Ionicons.phone_portrait_outline),
                    userDetailShow("email", model.email, Ionicons.mail),
                    userDetailShow("Birthday", dateTimetoText(model.dob),
                        Ionicons.medical_outline),
                    userDetailShow(
                        "Gender",
                        model.isMale ? "Male" : "Female",
                        model.isMale
                            ? Ionicons.man_outline
                            : Ionicons.woman_outline),
                    userDetailShow(
                        "Address", model.address, Ionicons.home_outline),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  // color: const Color.fromRGBO(0, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onLongPress: () {
                                  AppUtils.showSnackMessage(
                                      model.lifeID, "This is Fd Id");
                                },
                                child: heading("About FD", 18)),

                            Row(
                              children: [
                                // model.maturityDate.isAfter(DateTime.now())
                                //     ? model.lifeStatus == "applied"
                                //         ?
                                customButton("Recieve Certificate", () {
                                  renewLiftDialog(model);
                                  // Get.snackbar(
                                  //   "hello",
                                  //   "this is message",
                                  //   snackPosition: SnackPosition.BOTTOM,
                                  // );
                                  // print("object");
                                  // navigate(RenewPolicyPage(model: model),
                                  // context);
                                }, context, isExpanded: false)
                                // :
                                //  model.lifeStatus == "inHand"
                                //             ? customButton(
                                //                 "handover to customer", () {
                                //                 print("object");
                                //                 genericConfirmSheet(
                                //                     context,
                                //                     Statements.handoverFD,
                                //                     "handover", () {
                                //                   FirebaseFirestore.instance
                                //                       .collection("Policies")
                                //                       .doc(model.lifeID)
                                //                       .update({
                                //                     "fd_given_date":
                                //                         DateTime.now(),
                                //                     "fd_status": "handover"
                                //                   }).then((value) {
                                //                     PolicyHiveHelper
                                //                         .fetchFDPoliciesFromFirebase();
                                //                     Navigator.pop(context);
                                //                     Navigator.pop(context);
                                //                   });
                                //                 });
                                //                 // navigate(
                                //                 //     RenewPolicyPage(model: model), context);
                                //               }, context, isExpanded: false)
                                //             : Container()
                                //     : Row(
                                //         children: [
                                //           customButton("Renew", () {
                                //             // AppUtils.showSnackMessage(
                                //             // "FD Redeemed Successfuly",
                                //             // "This amount is given to client");
                                //             // print("object");
                                //             navigate(RenewFdPage(model: model),
                                //                 context);
                                //           }, context, isExpanded: false)
                                //         ],
                                //       ),
                                // model.fdStatus == "handover"
                                //     ? customButton("Redeem", () {
                                //         print("object");
                                //         genericConfirmSheet(context,
                                //             Statements.redeemFD, "Redeem", () {
                                //           FirebaseFirestore.instance
                                //               .collection("Policies")
                                //               .doc(model.fdId)
                                //               .update({
                                //             "status_date": DateTime.now(),
                                //             "fd_status": "redeemed"
                                //           }).then((value) {
                                //             AppUtils.showSnackMessage(
                                //                 "This FD is Successfully Redeemed",
                                //                 "");
                                //             PolicyHiveHelper
                                //                 .fetchFDPoliciesFromFirebase();
                                //             Navigator.pop(context);
                                //             Navigator.pop(context);
                                //           });
                                //         });
                                //         // navigate(
                                //         //     RenewPolicyPage(model: model), context);
                                //       }, context, isExpanded: false)
                                //     : Container(),
                                // customButton(
                                //   "Edit FD",
                                //   () {
                                //     // navigate(EditDetailsPage(model: model),
                                //     // context);
                                //   },
                                //   context,
                                //   isExpanded: false,
                                // ),
                                // customDeleteButton(Icons.edit, Colors.blue,
                                //     () async {
                                //   navigate(
                                //       EditFdDetails(model: model), context);
                                // }, context),
                                // customDeleteButton(
                                //     Ionicons.trash_outline, Colors.red.shade500,
                                //     () async {
                                //   genericConfirmSheet(
                                //       context, Statements.removeFD, "FD", () {
                                //     FirebaseFirestore.instance
                                //         .collection("Policies")
                                //         .doc(model.fdId)
                                //         .delete()
                                //         .then((value) {
                                //       PolicyHiveHelper
                                //           .fetchFDPoliciesFromFirebase();
                                //       // PolicyHiveHelper.deleteSpecificPolicy(
                                //       //     documentID: model.fdId);
                                //       Navigator.pop(context);

                                //       Navigator.pop(context);
                                //     });
                                //   });
                                // }, context),
                              ],
                            )
                            // Container(),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: dashBoxDex(context),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                productTileText(
                                  "Life No: ${model.lifeNo}",
                                  22,
                                ),
                                // Text(
                                //   model.policyNo,
                                //   style: GoogleFonts.nunito(
                                //       fontSize: 22,
                                //       color: Colors.green.shade300,
                                //       fontWeight: FontWeight.w500),
                                // ),
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          // launchURL(
                                          // "https://wa.me/${model.phone}?text=${fDRenewalDraftMsg(model)}");
                                        },
                                        child: Icon(
                                          Ionicons.logo_whatsapp,
                                          color: Colors.green.shade300,
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          AppUtils.showSnackMessage(
                                              "This is paid by " +
                                                  model.payMode,
                                              model.payMode == "Cheque"
                                                  ? "bank Details: " +
                                                      model.bankDetails
                                                  : "");
                                        },
                                        child: const Icon(
                                          Ionicons.information_circle_outline,
                                          size: 30,
                                        ))
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                productTileText(
                                  "Invested Amount ",
                                  22,
                                ),
                                Text(
                                  "RS ${model.premuimAmt.toString()}",
                                  style: GoogleFonts.nunito(
                                      fontSize: 22,
                                      color: Colors.green.shade300,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            productTileText(
                              "Company: ${model.companyName}",
                              22,
                            ),
                            productTileText(
                              "Deposit Date: ${dateTimetoText(model.commitmentDate)}",
                              22,
                            ),
                            productTileText(
                              "Expected Maturity Date: ${dateTimetoText(model.maturityDate)}",
                              22,
                            ),
                            (model.isMale)
                                ? Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Ionicons.information_circle_outline,
                                          size: 45,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              heading(
                                                  "This FD is Non Cummulative",
                                                  20),
                                              heading1(
                                                  "it is ${model.payingTerm}",
                                                  16)
                                              // heading(
                                              //     "This FD is Ported From ${model.portCompanyName} on ${dateTimetoText(model.portMaturityDate)}",
                                              //     20),
                                              // heading1(
                                              //     "Ported FD no is ${model.portFdNo}",
                                              //     16)
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: heading("Timeline", 18),
                      ),
                      // Row(
                      //   children: [
                      // Padding(
                      // padding: const EdgeInsets.all(30),
                      // child: StepperWidget(
                      //   model: model,
                      //   currentStep: stepNumber(
                      //       EnumUtils.convertNameToFdStatus(
                      //           model.fdStatus)),
                      // ))
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: heading("Transactions", 18),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: dashBoxDex(context),
                        padding: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              fDTransactionHeader(),
                              // model.inceptionDate == model.issuedDate
                              //     ? Container()
                              //     : inceptionWidget(model.inceptionDate, context),
                              streamTransactions("policy_id", model.lifeID),
                              // model.fdStatus == "applied"
                              //     ? Container()
                              //     : statusFooter(model.fdStatus,
                              //         model.initialDate, context)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}

int stepNumber(FDStatus status) {
  switch (status) {
    case FDStatus.applied:
      return 0;
    case FDStatus.inHand:
      return 1;

    case FDStatus.handover:
      return 2;
    case FDStatus.redeemed:
      return 3;
    default:
      return 0;
  }
}

Widget inceptionWidget(DateTime inceptionDate, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    // color: Theme.of(context).scaffoldBackgroundColor,
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(vertical: 3),
    child: simpleText("Inception Date: ${dateTimetoText(inceptionDate)}", 16),
    // child: Text()
  );
}
