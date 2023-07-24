import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/functions.dart';

final oneMonthMore = DateTime.now().add(const Duration(days: 30));

final now = DateTime.now();
final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
final oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
final threeMonthsAgo = DateTime.now().subtract(const Duration(days: 90));
final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 180));
final oneYearAgo = DateTime.now().subtract(const Duration(days: 365));
final foreverAgo = DateTime.now().subtract(const Duration(days: 30 * 365));
final foreverMore = DateTime.now().add(const Duration(days: 30 * 365));

class FilterProvider extends GetxController {
  DateTime toDate = foreverMore;
  DateTime fromDate = foreverAgo;
  num commissionSuma = 0;
  String companyFilter = "All Companies";
  String statusFilter = "active";

  String filterName = "by Date";

  int tooltime = 0;
  // List<String> policyStatusList = [
  //   "all status",
  //   "active",
  //   "ported",
  //   "lapsed",
  // ];
  // List<String> fDStatusList = [
  //   "all status",
  //   "applied",
  //   "claimed",
  //   "released",
  // ];

  // List<String> getStatusList(String dashName) {
  //   if (dashName == ProductType.health) {
  //     return policyStatusList;
  //   } else {
  //     return fDStatusList;
  //   }
  // }

  List<String> companyList = [
    "all companies",
    // "Niva",
    // "Star",
    // "none",
  ];
  // void setDefaultStatus(String status) {
  //   statusFilter = status;
  //   update();
  // }

  void changeCompany(String newOne) {
    companyFilter = newOne;
    update();
  }

  // void changeStatus(String newOne) {
  //   statusFilter = newOne;
  //   update();
  // }

  void closeToolTip() {
    tooltime = 1;

    update();
  }

  // void clearSum() {
  //   commissionSuma = 0;

  //   update();
  // }

  void filterByWeek() {
    fromDate = oneWeekAgo;
    toDate = now;

    update();
  }

  void filterByMonth() {
    fromDate = oneMonthAgo;
    toDate = now;
    filterName = "By Month";
    update();
  }

  void filterByThreeMonths() {
    fromDate = threeMonthsAgo;
    toDate = now;

    update();
  }

  void filterBySixMonths() {
    fromDate = sixMonthsAgo;
    toDate = now;

    update();
  }

  void filterByYear() {
    fromDate = oneYearAgo;
    toDate = now;
    filterName = "By Year";

    update();
  }

  void filterByTillNow() {
    fromDate = foreverAgo;
    toDate = foreverMore;
    filterName = "By Date";

    update();
  }

  void filterByManual(DateTime fDate, DateTime tDate) {
    fromDate = fDate;
    toDate = tDate;
    filterName = "By Manual";

    update();
  }

  void getCompanies(String type) {
    companyList = [
      "all companies",
    ];
    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: type)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          companyList.add(AppUtils.getFirstWord(value.docs[i]["name"]));
          print("Added " + AppUtils.getFirstWord(value.docs[i]["name"]));
        }
      }
    });
    update();
  }
}
