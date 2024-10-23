import 'package:health_model/hive/hive_model/doc_hive_model.dart';
import 'package:health_model/models/document_model.dart';
import 'package:health_model/test.dart';

import '/pages/motor_module/enter_vehicle.dart';
import '/providers/motor_provider.dart';
import '/pages/fd_module/renew_fd.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../shared/exports.dart';

Widget bDayuserTile(BuildContext context, UserHiveModel model) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);

  // Timestamp time = model["d;
  return Container(
    // height: 120,
    // width: 250,    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),

    decoration: dashBoxDex(
      context,
    ),
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(vertical: 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      model.isMale ? Colors.blueAccent : Colors.pinkAccent,
                  child: Center(
                    child: Icon(model.isMale ? Ionicons.male : Ionicons.female),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading(model.name, 15),
                    productTileText(
                        "Age: ${timeago.format(model.dob, allowFromNow: true, locale: 'en_short')}",
                        13),
                  ],
                ),
              ],
            ),
            customButton("Wish", () async {
              launchURL(
                  "https://wa.me/${model.phone}?text=${BDayWishDraftMsg(model)}"); // addMemberSheet(context, widget.userid, docId);
            }, context, isExpanded: false)
          ],
        ),
      ],
    ),
  );
}

Widget memberTile(isChoosing, BuildContext context, MemberModel model) {
  final provider = Provider.of<UserProvider>(context, listen: true);
  final fdProvider = Provider.of<FDProvider>(context, listen: true);
  final lifeProvider = Provider.of<LifeProvider>(context, listen: true);
  final motorProvider = Provider.of<MotorProvider>(context, listen: true);
  final dashProvider = Get.find<DashProvider>();

  return InkWell(
    onTap: isChoosing
        ? () {
            if (dashProvider.currentDashBoard == ProductType.life) {
              lifeProvider.setMemberClient(model.userid, model.name,
                  model.relation, model.dob, model.isMale);
              navigate(ChooseCompany(), context);
            } else if (dashProvider.currentDashBoard == ProductType.motor) {
              motorProvider.setMemberClient(model.userid, model.name,
                  model.relation, model.dob, model.isMale);
              navigate(ChooseCompany(), context);
            } else {
              fdProvider.setMemberClient(model.userid, model.name,
                  model.relation, model.dob, model.isMale);
              navigate(ChooseCompany(), context);
            }
          }
        : () {},
    child: Container(
      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 250,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          model.isMale ? Colors.blueAccent : Colors.pinkAccent,
                      child: Center(
                        child: Icon(
                            model.isMale ? Ionicons.male : Ionicons.female),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText(model.relation, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Age", 16),
                  productTileText(
                      timeago.format(model.dob.toDate(),
                          allowFromNow: true, locale: 'en_short'),
                      14),
                ],
              ),
              isChoosing
                  ? Container()
                  : Row(
                      children: [
                        customDeleteButton(
                          Ionicons.expand_outline,
                          primaryColor,
                          () async {
                            provider.selectRelation(model.relation);

                            addMemberSheet(context, model.userid, "", provider,
                                model: model);
                          },
                          context,
                        ),
                        customDeleteButton(
                          Ionicons.trash_outline,
                          Colors.red.shade500,
                          () async {
                            //       addMemberSheet(context, widget.userid, docId, provider,
                            // model: null);
                            genericConfirmSheet(
                                context, Statements.removeMember, "Member", () {
                              provider.decreaseMemberCount();
                              updateMembers(model.headUserid, toRemove: true);
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(model.headUserid)
                                  .collection("Members")
                                  .doc(model.userid)
                                  .delete(); // addMemberSheet(context, widget.userid, docId);
                              Navigator.of(context);
                            });
                          },
                          context,
                        ),
                      ],
                    )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget memberMiniTile(BuildContext context, MemberModel model) {
  return Container(
    decoration: dashBoxDex(context),
    padding: const EdgeInsets.all(4),
    margin: const EdgeInsets.symmetric(vertical: 1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading(model.name, 16),
                productTileText(model.relation, 14),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget documentMiniTile(BuildContext context, DocHiveModel model) {
  // Timestamp time = model["d;
  return InkWell(
    onTap: () {
      // navigate(MyHomePage(), context);
      launchURL(model.docUrl);
    },
    child: Container(
      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 270,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(model.docFormat == "application/pdf"
                          ? Ionicons.document
                          : Ionicons.image_outline),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.docName, 16),
                        productTileText(model.docType, 14),
                      ],
                    ),
                  ],
                ),
              ),
              customDeleteButton(
                Ionicons.trash_outline,
                Colors.red.shade500,
                () async {
                  genericConfirmSheet(
                      context, Statements.removeDocument, "Document", () {
                    FirebaseFirestore.instance
                        .collection("Documents")
                        .doc(model.docId)
                        .delete()
                        .then((value) {
                      UserHiveHelper.fetchDocFromFirebase();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  });
                },
                context,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget planTile(bool isChoosing, BuildContext context, PlanModel model) {
  final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
  final lifeProvider = Provider.of<LifeProvider>(context, listen: false);
  final dashProvider = Get.find<DashProvider>();

  // Timestamp time = model["d;
  return InkWell(
    onTap: isChoosing
        ? () {
            if (dashProvider.currentDashBoard == ProductType.health) {
              policyProvider.portCompanyName == ""
                  ? {
                      policyProvider.setPlan(model.name, model.planID),
                      navigate(ChooseFresh(), context),
                    }
                  : {
                      policyProvider.setPlan(model.name, model.planID),
                      navigate(
                          EnterPolicyDetails(
                            inceptionDate: todayTextFormat(),
                          ),
                          context),
                    };
            } else {
              lifeProvider.setPlan(model.name, model.planID);
              lifeProvider.clearFields();
              navigate(EnterLifeDetails(model: null), context);
            }
          }
        : null,
    child: Container(
      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 270,
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Center(
                        child: Icon(Ionicons.receipt_outline),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText(
                            "Created ${timeago.format(model.timestamp.toDate(), allowFromNow: true, locale: 'en_short')} ago",
                            14),
                      ],
                    ),
                  ],
                ),
              ),
              isChoosing
                  ? Container()
                  : customDeleteButton(
                      Ionicons.trash_outline,
                      Colors.red.shade500,
                      () async {
                        genericConfirmSheet(
                            context, Statements.removePlan, "Plan", () {
                          FirebaseFirestore.instance
                              .collection("Companies")
                              .doc(model.companyID)
                              .collection("Plans")
                              .doc(model.planID)
                              .delete(); // addMemberSheet(context, widget.userid, docId);
                          Navigator.pop(context);
                        });
                      },
                      context,
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget companyTile(bool isChoosing, String dashName, BuildContext context,
    CompanyModel model) {
  // Timestamp time = model["d;
  final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
  final fdprovider = Provider.of<FDProvider>(context, listen: false);
  final lifeProvider = Provider.of<LifeProvider>(context, listen: false);
  final motorProvider = Provider.of<MotorProvider>(context, listen: false);

  // final dashProvider = Provider.of<DashProvider>(context, listen: false);

  return InkWell(
    onLongPress: () {
      AppUtils.showSnackMessage(model.companyID, "This is companyID");
    },
    onTap: isChoosing
        ? () {
            if (dashName == EnumUtils.convertTypeToKey(ProductType.health)) {
              policyProvider.setCompany(
                  model.name, model.companyID, model.companyImg);
              navigate(
                  ChoosePlan(
                      companyName: model.name, companyId: model.companyID),
                  context);
            } else if (dashName ==
                EnumUtils.convertTypeToKey(ProductType.life)) {
              lifeProvider.setCompany(
                  model.name, model.companyID, model.companyImg);

              navigate(
                  ChoosePlan(
                      companyName: model.name, companyId: model.companyID),
                  context);
            } else if (dashName ==
                EnumUtils.convertTypeToKey(ProductType.motor)) {
              motorProvider.setCompany(
                  model.name, model.companyID, model.companyImg);

              navigate(EntervehiclesDetails(), context);
            } else {
              fdprovider.setCompany(
                  model.name, model.companyID, model.companyImg);

              navigate(ChooseExisting(), context);
            }
          }
        : () {
            navigate(
                AddCompanyPage(
                  companyid: model.companyID,
                  model: model,
                ),
                context);
          },
    child: Container(
      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 350,
                child: Row(
                  children: [
                    companyLogo(model.companyImg),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText("${model.planCount} Plans", 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Created", 16),
                  productTileText(dateTimetoText(model.timestamp.toDate()), 14),
                ],
              ),
              isChoosing
                  ? Container()
                  : Row(
                      children: [
                        dashName ==
                                EnumUtils.convertTypeToKey(ProductType.health)
                            ? customButton("View Plans", () async {
                                navigate(
                                    PlansPage(
                                        companyName: model.name,
                                        companyUserid: model.companyID),
                                    context);
                                //   var uuid = Uuid();
                                //   String docId = uuid.v4();
                                //   addPlanSheet(context, model.companyID, docId);
                                //
                              }, context, isExpanded: false)
                            : Container(),
                        customDeleteButton(
                          Ionicons.trash_outline,
                          Colors.red.shade500,
                          () async {
                            genericConfirmSheet(
                                context, Statements.removeCompany, "Company",
                                () {
                              FirebaseFirestore.instance
                                  .collection("Companies")
                                  .doc(model.companyID)
                                  .delete()
                                  .then((value) => Navigator.pop(context));
                            });
                            // addMemberSheet(context, widget.userid, docId);
                          },
                          context,
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget lifeRenewalTile(
    bool isPast, BuildContext context, PolicyDataHiveModel model) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);
  // Duration diff = model.renewalDate.toDate().difference(DateTime.now());
  // Timestamp time = model["d;
  LifeHiveModel thisModel = model.data as LifeHiveModel;
  return InkWell(
    onTap: null,
    child: Container(
      // height: 120,
      // width: 250,    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),

      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 270,
                child: Row(
                  children: [
                    companyLogo(model.data!.companyLogo),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.data!.name, 16),
                        productTileText(thisModel.lifeNo, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(
                      AppUtils.getFirstWord(thisModel.companyName.toString()),
                      14),
                ],
              ),
              Column(
                children: [
                  heading("Sum Assured", 16),
                  productTileText(thisModel.sumAssured.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Renewal Date", 16),
                  productTileText(dateTimetoText(thisModel.renewalDate), 14),
                ],
              ),
              Column(
                children: [
                  heading("Basic Premium", 16),
                  productTileText(thisModel.premuimAmt.toString(), 14),
                ],
              ),
              isPast
                  ? Column(
                      children: [
                        heading("Graced", 16),
                        productTileText(
                            "${30 - (DateTime.now().difference(thisModel.renewalDate).inDays)} days",
                            14),
                      ],
                    )
                  : Column(
                      children: [
                        heading("Days to go", 16),
                        productTileText(
                            "${thisModel.renewalDate.difference(DateTime.now()).inDays} days",
                            14),
                      ],
                    ),
              isGraced(thisModel.renewalDate)
                  ? customButton("Renew", () async {
                      showRenewLifeDialog(thisModel);

                      // addMemberSheet(context, widget.userid, docId);
                    }, context, isExpanded: false)
                  : customButton("Laps", () async {
                      navigate(
                        ChooseMember(
                            headUserid: model.data!.userid,
                            headName: model.data!.name),
                        context,
                      );
                      // addMemberSheet(context, widget.userid, docId);
                    }, context, isExpanded: false)
            ],
          ),
        ],
      ),
    ),
  );
}

Widget policyRenewalTile(
    bool isPast, BuildContext context, PolicyDataHiveModel model) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);
  // Duration diff = model.renewalDate.toDate().difference(DateTime.now());
  // Timestamp time = model["d;
  PolicyHiveModel thisModel = model.data as PolicyHiveModel;
  return InkWell(
    onTap: null,
    child: Container(
      // height: 120,
      // width: 250,    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),

      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 270,
                child: Row(
                  children: [
                    companyLogo(model.data!.companyLogo),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.data!.name, 16),
                        productTileText(thisModel.policyNo, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(
                      AppUtils.getFirstWord(thisModel.companyName.toString()),
                      14),
                ],
              ),
              Column(
                children: [
                  heading("Sum Assured", 16),
                  productTileText(thisModel.sumAssured.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Renewal Date", 16),
                  productTileText(dateTimetoText(thisModel.renewalDate), 14),
                ],
              ),
              Column(
                children: [
                  heading("Basic Premium", 16),
                  productTileText(thisModel.premuimAmt.toString(), 14),
                ],
              ),
              isPast
                  ? Column(
                      children: [
                        heading("Graced", 16),
                        productTileText(
                            "${30 - (DateTime.now().difference(thisModel.renewalDate).inDays)} days",
                            14),
                      ],
                    )
                  : Column(
                      children: [
                        heading("Days to go", 16),
                        productTileText(
                            "${thisModel.renewalDate.difference(DateTime.now()).inDays} days",
                            14),
                      ],
                    ),
              isGraced(thisModel.renewalDate)
                  ? customButton("Renew", () async {
                      navigate(
                        RenewPolicyPage(model: thisModel),
                        context,
                      );
                      // addMemberSheet(context, widget.userid, docId);
                    }, context, isExpanded: false)
                  : customButton("Laps", () async {
                      navigate(
                        ChooseMember(
                            headUserid: model.data!.userid,
                            headName: model.data!.name),
                        context,
                      );
                      // addMemberSheet(context, widget.userid, docId);
                    }, context, isExpanded: false)
            ],
          ),
        ],
      ),
    ),
  );
}

Widget fDRenewalTile(
    bool isPast, BuildContext context, PolicyDataHiveModel model) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);
  // Duration diff = model.renewalDate.toDate().difference(DateTime.now());
  // Timestamp time = model["d;
  FdHiveModel thisModel = model.data as FdHiveModel;
  return InkWell(
    onTap: null,
    child: Container(
      // height: 120,
      // width: 250,    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),

      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: 270,
                child: Row(
                  children: [
                    companyLogo(model.data!.companyLogo),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.data!.name, 15.5),
                        productTileText(thisModel.fdNo, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(
                      AppUtils.getFirstWord(thisModel.companyName.toString()),
                      14),
                ],
              ),
              Column(
                children: [
                  heading("Sum Assured", 16),
                  productTileText(thisModel.investedAmt.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Maturity Date", 16),
                  productTileText(dateTimetoText(thisModel.renewalDate), 14),
                ],
              ),
              Column(
                children: [
                  heading("Basic Premium", 16),
                  productTileText(thisModel.investedAmt.toString(), 14),
                ],
              ),
              isPast
                  ? Column(
                      children: [
                        heading("Maturity", 16),
                        productTileText(
                            "${30 - (DateTime.now().difference(thisModel.renewalDate).inDays)} days",
                            14),
                      ],
                    )
                  : Column(
                      children: [
                        heading("Days to go", 16),
                        productTileText(
                            "${thisModel.renewalDate.difference(DateTime.now()).inDays} days",
                            14),
                      ],
                    ),
              isGraced(thisModel.renewalDate)
                  ? Row(
                      children: [
                        customButton("Redeem", () async {
                          genericConfirmSheet(
                              context, Statements.redeemFD, "redeem", () {
                            FirebaseFirestore.instance
                                .collection("Policies")
                                .doc(thisModel.fdId)
                                .update({
                              "status_date": DateTime.now(),
                              "fd_status": "redeemed"
                            }).then((value) {
                              AppUtils.showSnackMessage(
                                  "This FD is Successfully Redeemed", "");
                              PolicyHiveHelper.fetchFDPoliciesFromFirebase();
                              Navigator.pop(context);
                            });
                          });
                        }, context,
                            isExpanded: false, color: Colors.red.shade500),
                        customButton("Renew", () async {
                          navigate(
                            RenewFdPage(model: thisModel),
                            context,
                          );
                          // addMemberSheet(context, widget.userid, docId);
                        }, context, isExpanded: false),
                      ],
                    )
                  : customButton("Laps", () async {
                      navigate(
                        ChooseMember(
                            headUserid: model.data!.userid,
                            headName: model.data!.name),
                        context,
                      );
                      // addMemberSheet(context, widget.userid, docId);
                    }, context, isExpanded: false)
            ],
          ),
        ],
      ),
    ),
  );
}

Widget transactionTile(BuildContext context, TansactionModel model, int index) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);
  // Duration diff = model.data!.renewalDate .difference(DateTime.now());
  // Timestamp time = model["d;
  DateTime addedDate;

  int premiumAmt = model.premuimAmt;
  String type = model.type;
  if (type == "NA") {
    if (model.terms >= 6) {
      type = "FD";
    } else if (model.membersCount == index && model.terms >= 1) {
      type = "Life";
    } else {
      type = "Health";
    }
  }

  if (type == "FD") {
    addedDate = model.timestamp.toDate();
  } else if (type == "Life") {
    addedDate = model.timestamp.toDate();
  } else {
    premiumAmt = addHealthWithGST(model.premuimAmt);
    addedDate =
        model.beginsDate.toDate().add(Duration(days: model.terms * 365));
  }
  return GestureDetector(
    // onLongPressStart: ,
    onDoubleTap: () {
      // print(type);
      // FirebaseFirestore.instance
      //     .collection("Transactions")
      //     .doc(model.transactionId)
      //     .delete();
    },
    onLongPress: () {
      AppUtils.showSnackMessage(
          model.transactionId, "This is transaction ID + $type");
    },
    child: Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productTileText("$index.", 16),
            productTileText(model.policyNo, 16),
            productTileText(dateTimetoText(model.beginsDate.toDate()), 16),
            productTileText(dateTimetoText(addedDate), 16),
            productTileText("${AppUtils.formatAmount(premiumAmt)} Rs", 16),
            productTileText(AppUtils.formatAmount(model.membersCount), 16),
          ],
        ),
      ),
    ),
  );
}
