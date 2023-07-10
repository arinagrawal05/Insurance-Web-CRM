import 'package:flutter/material.dart';

class FDStatsProvider extends ChangeNotifier {
  int users_count = 0;
  int policies_count = 0;
  // int companies_count = 0;
  // int active_policies_count = 0;
  // int lapped_policies_count = 0;
  // int ported_policies_count = 0;
  // int premiumAmtSum = 0;
  // int healthPercent = 15;
  // List advisorList = [];
  // String adminPin = "1234";
  // int plans_count = 0;
  // List<CompanyChartData> chartData = [];
  // List<PolicyStatusChartData> policyStatusChartData = [];
  // List<PolicyDistributionChartData> policyDistributionChartData = [];

  // void getCompaniesChartData() {
  //   FirebaseFirestore.instance.collection("Companies").get().then((value) {
  //     if (value.docs.length > 0) {
  //       for (var i = 0; i < value.docs.length; i++) {
  //         chartData.add(CompanyChartData(getFirstWord(value.docs[i]["name"]),
  //             value.docs[i]["total_bussiness"]));
  //         policyDistributionChartData.add(PolicyDistributionChartData(
  //             value.docs[i]["name"], value.docs[i]["policy_count"]));
  //       }
  //     }
  //   });
  //   notifyListeners();
  // }

  // Future<void> getStats() async {
  //   policyDistributionChartData = [];
  //   policyStatusChartData = [];
  //   FirebaseFirestore.instance
  //       .collection("Statistics")
  //       .doc("KdMlwAoBwwkdREqX3hIe")
  //       .get()
  //       .then((value) {
  //     premiumAmtSum = value["sum_premium_amt"];
  //     plans_count = value["plans_count"];
  //     adminPin = value["admin_pin"];
  //     advisorList = value["advisor_list"];
  //     healthPercent = value["health_commission_percent"];
  //   });

  //   await FirebaseFirestore.instance
  //       .collection("Policies")
  //       .get()
  //       .then((value) => {
  //             policies_count = value.docs.length,
  //           });

  //   await FirebaseFirestore.instance
  //       .collection("Policies")
  //       .where("policy_status", isEqualTo: "active")
  //       .get()
  //       .then((value) => {
  //             print("Active Policies" + value.docs.length.toString()),
  //             policyStatusChartData.add(
  //               PolicyStatusChartData("Active", value.docs.length),
  //             ),
  //             active_policies_count = value.docs.length,
  //           });

  //   await FirebaseFirestore.instance
  //       .collection("Policies")
  //       .where("policy_status", isEqualTo: "lapsed")
  //       .get()
  //       .then((value) => {
  //             policyStatusChartData.add(
  //               PolicyStatusChartData("lapsed", value.docs.length),
  //             ),
  //             lapped_policies_count = value.docs.length,
  //           });
  //   await FirebaseFirestore.instance
  //       .collection("Policies")
  //       .where("policy_status", isEqualTo: "ported")
  //       .get()
  //       .then((value) => {
  //             policyStatusChartData.add(
  //               PolicyStatusChartData("Ported", value.docs.length),
  //             ),
  //             ported_policies_count = value.docs.length,
  //           });
  //   await FirebaseFirestore.instance.collection("Users").get().then((value) => {
  //         users_count = value.docs.length,
  //       });
  //   await FirebaseFirestore.instance
  //       .collection("Companies")
  //       .get()
  //       .then((value) => {
  //             companies_count = value.docs.length,
  //           });

  //   notifyListeners();
  // }

  // ThemeMode getCurrentThemes() {
  //   return themeMode;
  // }
}
