import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/commission_model.dart';
import 'package:health_model/models/company_model.dart';
import 'package:health_model/models/member_model.dart';
import 'package:health_model/models/plan_model.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/models/transaction_model.dart';
import 'package:health_model/models/user_model.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/shared/tiles.dart';

Widget streamUsers(bool isChoosing, {bool isBirthday = false}) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Users")
        // .orderBy("timestamp", descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Clients");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");
                if (isBirthday) {
                  DateTime birthday =
                      UserModel.fromFirestore(snapshot.data!.docs[index])
                          .dob
                          .toDate();
                  if (birthday.day == DateTime.now().day &&
                      birthday.month == DateTime.now().month) {
                    return bDayuserTile(
                      context,
                      UserModel.fromFirestore(snapshot.data!.docs[index]),
                    );
                  }
                } else {
                  return userTile(
                    isChoosing,
                    context,
                    UserModel.fromFirestore(snapshot.data!.docs[index]),
                  );
                }
                return null;
              });
        }
      }
    },
  );
}

Widget streamMembers(headID, {bool isMini = false, bool isChoosing = false}) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Users")
        .doc(headID)
        .collection("Members")
        // .orderBy(
        //   "relation",
        // )
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Members");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");
                if (isMini) {
                  // return Text(
                  // MemberModel.fromFirestore(snapshot.data!.docs[index]).name);
                  return memberMiniTile(
                    context,
                    MemberModel.fromFirestore(snapshot.data!.docs[index]),
                  );
                } else {
                  return memberTile(
                    isChoosing,
                    context,
                    MemberModel.fromFirestore(snapshot.data!.docs[index]),
                  );
                }
              });
        }
      }
    },
  );
}

Widget streamCompanies(bool isChoosing, String type) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: type)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Companies");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");
                return companyTile(
                  isChoosing,
                  type,
                  context,
                  CompanyModel.fromFirestore(snapshot.data!.docs[index]),
                );
              });
        }
      }
    },
  );
}

streamPlans(bool isChoosing, String companyUserid) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Companies")
        .doc(companyUserid)
        .collection("Plans")
        // .orderBy("timestamp", descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Plans");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");
                return planTile(
                  isChoosing,
                  context,
                  PlanModel.fromFirestore(snapshot.data!.docs[index]),
                );
              });
        }
      }
    },
  );
}

Widget streamPolicies(bool isChoosing, String companyFilter,
    String statusFilter, DateTime fromDate, DateTime toDate) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Policies")
        .where('renewal_date', isGreaterThanOrEqualTo: fromDate)
        .where('renewal_date', isLessThanOrEqualTo: toDate)
        .orderBy("renewal_date", descending: false)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Policies");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");

                if (getFirstWord(PolicyModel.fromFirestore(
                                snapshot.data!.docs[index])
                            .companyName) ==
                        companyFilter ||
                    companyFilter == "all companies") {
                  if (PolicyModel.fromFirestore(snapshot.data!.docs[index])
                              .policyStatus ==
                          statusFilter ||
                      statusFilter == "all status") {
                    return policyTile(
                      context,
                      PolicyModel.fromFirestore(snapshot.data!.docs[index]),
                    );
                  }
                }
                return Container();
              });
        }
      }
    },
  );
}

Widget streamUserPolicies(bool isChoosing, String companyFilter,
    String statusFilter, DateTime fromDate, DateTime toDate) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("Policies").snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Policies");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");

                if (getFirstWord(PolicyModel.fromFirestore(
                                snapshot.data!.docs[index])
                            .companyName) ==
                        companyFilter ||
                    companyFilter == "all companies") {
                  if (PolicyModel.fromFirestore(snapshot.data!.docs[index])
                              .policyStatus ==
                          statusFilter ||
                      statusFilter == "all status") {
                    return policyTile(
                      context,
                      PolicyModel.fromFirestore(snapshot.data!.docs[index]),
                    );
                  }
                }
                return Container();
              });
        }
      }
    },
  );
}

Widget streamCommissions(bool? isPending, String name, String companyFilter,
    DateTime fromDate, DateTime toDate) {
  // final now = DateTime.now();
  // final oneMonthAgo = now.subtract(const Duration(days: 30));

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Commission")
        .where('commission_date', isGreaterThan: fromDate)
        .where('commission_date', isLessThan: toDate)
        .orderBy(
          "commission_date",
        )
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Commission Files");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");
                if (CommissionModel.fromFirestore(snapshot.data!.docs[index])
                        .commissionType ==
                    name) {
                  if (CommissionModel.fromFirestore(snapshot.data!.docs[index])
                          .isPending ==
                      isPending) {
                    if (CommissionModel.fromFirestore(
                                    snapshot.data!.docs[index])
                                .companyName ==
                            companyFilter ||
                        companyFilter == "all companies") {
                      return commissionTile(
                        context,
                        CommissionModel.fromFirestore(
                            snapshot.data!.docs[index]),
                      );
                    }
                    // else {
                    //   return commissionTile(
                    //     context,
                    //     CommissionModel.fromFirestore(snapshot.data!.docs[index]),
                    //   );
                    // }
                  }
                }
                return Container();
              });
        }
      }
    },
  );
}

Widget streamRenewals(bool isPast, DateTime fromDate, DateTime toDate) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Policies")
        // .where("policy_status", isEqualTo: "active")
        .where('renewal_date', isGreaterThan: fromDate)
        .where('renewal_date', isLessThan: toDate)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return isPast
            ? customCircularLoader("Graced Policies")
            : customCircularLoader("Upcoming Policies");
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return noDataWidget();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // return Text("erfdfv");

                return renewalTile(
                  isPast,
                  context,
                  PolicyModel.fromFirestore(snapshot.data!.docs[index]),
                );
              });
        }
      }
    },
  );
}

Widget streamTransactions(String filterKey, String filterValue) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Transactions")
        .where(filterKey, isEqualTo: filterValue)
        // .orderBy("timestamp", descending: true)

        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return customCircularLoader("Transactions");
      } else {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // return Text("erfdfv");
              return transactionTile(
                  context,
                  TansactionModel.fromFirestore(snapshot.data!.docs[index]),
                  index + 1);
            });
      }
    },
  );
}

Widget streamNominees(
    String headID, BuildContext context, TextEditingController nomineeName) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
    width: MediaQuery.of(context).size.width,
    height: 28,
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(headID)
          .collection("Members")
          // .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // MemberModel.fromFirestore(snapshot.data!.docs[index])
                // return Text("erfdfv");

                return tag(
                    MemberModel.fromFirestore(snapshot.data!.docs[index]).name,
                    nomineeName,
                    context);
              });
        }
      },
    ),
  );
}

Widget renderAdvisor(
    List advisorList, BuildContext context, TextEditingController advisorName) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
    width: MediaQuery.of(context).size.width,
    height: 28,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: advisorList.length,
        itemBuilder: (context, index) {
          // MemberModel.fromFirestore(snapshot.data!.docs[index])
          // return Text("erfdfv");

          return tag(advisorList[index], advisorName, context);
        }),
  );
}
