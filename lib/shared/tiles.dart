import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/choose_exist.dart';
import 'package:health_model/shared/drafted_msgs.dart';
import 'package:health_model/enter_fd.dart';
import 'package:health_model/models/commission_model.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/models/transaction_model.dart';
import 'package:health_model/policy_detail.dart';
import 'package:health_model/policy_flow/choose_company.dart';
import 'package:health_model/policy_flow/choose_fresh.dart';
import 'package:health_model/policy_flow/choose_plan.dart';
import 'package:health_model/policy_renew.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/fd_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/providers/user_provider.dart';
import 'package:health_model/shared/colors.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/company_model.dart';
import 'package:health_model/models/member_model.dart';
import 'package:health_model/models/plan_model.dart';
import 'package:health_model/models/user_model.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/sheets/commission_sheet.dart';
import 'package:health_model/sheets/confirm_sheet.dart';
import 'package:health_model/sheets/member_sheet.dart';
import 'package:health_model/policy_flow/enter_policy.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/user_detail.dart';
import 'package:health_model/choose_members.dart';
import 'package:health_model/view_plans.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget bDayuserTile(BuildContext context, UserModel model) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);

  // Timestamp time = model["d;
  return Container(
    // height: 120,
    // width: 250,    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),

    decoration: dashBoxDex(context, isContrast: true),
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
                        "Age: ${timeago.format(model.dob.toDate(), allowFromNow: true, locale: 'en_short')}",
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

Widget userTile(bool isChoosing, BuildContext context, UserModel model) {
  final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
  final fdProvider = Provider.of<FDProvider>(context, listen: false);

  final dashProvider = Provider.of<DashProvider>(context, listen: false);
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  // Timestamp time = model["d;
  return InkWell(
    onTap: isChoosing
        ? () {
            if (dashProvider.dashName == AppConsts.health) {
              policyProvider.setClient(
                  model.userid,
                  model.name,
                  model.email,
                  model.dob,
                  model.address,
                  model.phone,
                  model.isMale,
                  model.membersCount);
              navigate(ChooseCompany(), context);
            } else {
              fdProvider.setHeadClient(model.userid, model.name, model.email,
                  model.address, model.phone);
              navigate(
                  ChooseMember(headName: model.name, headUserid: model.userid),
                  context);
            }

            print("Choosing");
          }
        : () {
            userProvider.changeMemberCount(model.membersCount);
            userProvider.setUserid(model.userid);
            navigate(
                UserDetailPage(
                  model: model,
                ),
                context);
          },
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
                width: 290,
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
                        productTileText(model.email, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Phone", 16),
                  productTileText(model.phone, 14),
                ],
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
              Column(
                children: [
                  heading("Gender", 16),
                  productTileText(model.isMale ? "Male" : "Female", 14),
                ],
              ),
              Column(
                children: [
                  heading("Members", 16),
                  productTileText(model.membersCount.toString(), 14),
                ],
              ),
              if (!isChoosing)
                customButton("View User", () async {
                  userProvider.changeMemberCount(model.membersCount);

                  userProvider.setUserid(model.userid);
                  navigate(
                      UserDetailPage(
                        model: model,
                      ),
                      context);
                  // addMemberSheet(context, widget.userid, docId);
                }, context, isExpanded: false),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget memberTile(isChoosing, BuildContext context, MemberModel model) {
  final provider = Provider.of<UserProvider>(context, listen: true);
  final fdProvider = Provider.of<FDProvider>(context, listen: true);

  return InkWell(
    onTap: isChoosing
        ? () {
            fdProvider.setMemberClient(model.userid, model.name, model.relation,
                model.dob, model.isMale);
            navigate(ChooseCompany(), context);
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
                          Colors.blue.shade500,
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
                            confirmRemoveSheet(context, "Member", () {
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

Widget planTile(bool isChoosing, BuildContext context, PlanModel model) {
  final provider = Provider.of<PolicyProvider>(context, listen: false);

  // Timestamp time = model["d;
  return InkWell(
    onTap: isChoosing
        ? provider.portCompanyName == ""
            ? () {
                provider.setPlan(model.name, model.planID);
                navigate(ChooseFresh(), context);
              }
            : () {
                provider.setPlan(model.name, model.planID);
                navigate(
                    EnterPolicyDetails(
                      inceptionDate: todayTextFormat(),
                    ),
                    context);
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
                        confirmRemoveSheet(context, "Plan", () {
                          updateCompanyPlans(model.companyID, "plans_count",
                              toRemove: true);
                          FirebaseFirestore.instance
                              .collection("Companies")
                              .doc(model.companyID)
                              .collection("Plans")
                              .doc(model.planID)
                              .delete(); // addMemberSheet(context, widget.userid, docId);
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
  final provider = Provider.of<PolicyProvider>(context, listen: false);
  final fdprovider = Provider.of<FDProvider>(context, listen: false);

  final dashProvider = Provider.of<DashProvider>(context, listen: false);

  return InkWell(
    onTap: isChoosing
        ? () {
            if (dashProvider.dashName == AppConsts.health) {
              provider.setCompany(
                  model.name, model.companyID, model.companyImg);
              navigate(
                  ChoosePlan(
                      companyName: model.name, companyUserid: model.companyID),
                  context);
            } else {
              fdprovider.setCompany(
                  model.name, model.companyID, model.companyImg);

              navigate(ChooseExisting(), context);
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
                        dashName == AppConsts.health
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
                            confirmRemoveSheet(context, "Company", () {
                              FirebaseFirestore.instance
                                  .collection("Companies")
                                  .doc(model.companyID)
                                  .delete();
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

Widget fdTile(BuildContext context, FdModel model) {
  return InkWell(
    onTap: () {
      // navigate(
      //   PolicyDetailPage(model: model),
      //   context,
      // );
      // addMemberSheet(context, widget.userid, docId);
    },
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
                width: 300,
                child: Row(
                  children: [
                    companyLogo(model.companyLogo),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText(model.fdNo, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(
                      getFirstWord(model.companyName.toString()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Sum Invested", 16),
                  productTileText(model.investedAmt.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Invested Date", 16),
                  productTileText(
                      dateTimetoText(model.initialDate.toDate()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Term", 16),
                  productTileText(addWithGST(model.fDterm).toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Status", 16),
                  productTileText(model.fdStatus.toString(), 14),
                ],
              ),
              customButton("View FD", () async {
                // navigate(
                //   PolicyDetailPage(model: model),
                //   context,
                // );
                // addMemberSheet(context, widget.userid, docId);
              }, context, isExpanded: false)
            ],
          ),
        ],
      ),
    ),
  );
}

Widget policyTile(BuildContext context, PolicyModel model) {
  return InkWell(
    onTap: () {
      navigate(
        PolicyDetailPage(model: model),
        context,
      );
      // addMemberSheet(context, widget.userid, docId);
    },
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
                width: 300,
                child: Row(
                  children: [
                    companyLogo(model.companyLogo),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText(model.policyNo, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(
                      getFirstWord(model.companyName.toString()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Sum Assured", 16),
                  productTileText(model.sumAssured.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Renewal Date", 16),
                  productTileText(
                      dateTimetoText(model.renewalDate.toDate()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Premium", 16),
                  productTileText(addWithGST(model.premuimAmt).toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Status", 16),
                  productTileText(model.policyStatus.toString(), 14),
                ],
              ),
              customButton("View Policy", () async {
                navigate(
                  PolicyDetailPage(model: model),
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

Widget commissionTile(BuildContext context, CommissionModel model) {
  final statsProvider =
      Provider.of<HealthStatsProvider>(context, listen: false);

  // Timestamp time = model["d;
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
                width: 250,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText(model.policyNo, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(model.companyName.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Premium", 16),
                  productTileText(model.premiumAmt.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Commission", 16),
                  productTileText(model.commissionAmt.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Prem. Depo Date", 16),
                  productTileText(
                      dateTimetoText(model.commissionDate.toDate()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Received", 16),
                  productTileText(
                      model.issuedDate == model.commissionDate
                          ? "NA"
                          : dateTimetoText(model.commissionDate.toDate()),
                      14),
                ],
              ),
              model.isPending
                  ? customButton("Receive", () async {
                      confirmCommission(context, model, statsProvider);
                    }, context, isExpanded: false)
                  : customButton(
                      "Received",
                      null,
                      context,
                      isExpanded: false,
                      color: primaryColor.withOpacity(0.2),
                    )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget renewalTile(bool isPast, BuildContext context, PolicyModel model) {
  // final provider = Provider.of<PolicyProvider>(context, listen: false);
  // Duration diff = model.renewalDate.toDate().difference(DateTime.now());
  // Timestamp time = model["d;
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
                    CircleAvatar(
                      backgroundColor:
                          model.isMale! ? Colors.blueAccent : Colors.pinkAccent,
                      child: Center(
                        child: Icon(
                            model.isMale! ? Ionicons.male : Ionicons.female),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(model.name, 16),
                        productTileText(model.email, 14),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  heading("Company", 16),
                  productTileText(
                      getFirstWord(model.companyName.toString()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Sum Assured", 16),
                  productTileText(model.sumAssured.toString(), 14),
                ],
              ),
              Column(
                children: [
                  heading("Renewal Date", 16),
                  productTileText(
                      dateTimetoText(model.renewalDate.toDate()), 14),
                ],
              ),
              Column(
                children: [
                  heading("Basic Premium", 16),
                  productTileText(model.premuimAmt.toString(), 14),
                ],
              ),
              isPast
                  ? Column(
                      children: [
                        heading("Graced", 16),
                        productTileText(
                            "${DateTime.now().difference(model.renewalDate.toDate()).inDays} days",
                            14),
                      ],
                    )
                  : Column(
                      children: [
                        heading("Days to go", 16),
                        productTileText(
                            "${model.renewalDate.toDate().difference(DateTime.now()).inDays} days",
                            14),
                      ],
                    ),
              isGraced(model.renewalDate)
                  ? customButton("Renew", () async {
                      navigate(
                        RenewPolicyPage(model: model),
                        context,
                      );
                      // addMemberSheet(context, widget.userid, docId);
                    }, context, isExpanded: false)
                  : customButton("Laps", () async {
                      navigate(
                        ChooseMember(
                            headUserid: model.userid, headName: model.name),
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
  // Duration diff = model.renewalDate.toDate().difference(DateTime.now());
  // Timestamp time = model["d;
  return InkWell(
    onTap: null,
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
            productTileText(
                dateTimetoText(model.beginsDate
                    .toDate()
                    .add(Duration(days: model.terms * 365))),
                16),
            productTileText("${model.premuimAmt} Rs", 16),
            productTileText(dateTimetoText(model.timestamp.toDate()), 16),
          ],
        ),
      ),
    ),
  );
}
