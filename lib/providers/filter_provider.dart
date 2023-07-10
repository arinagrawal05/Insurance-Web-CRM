import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

class FilterProvider extends ChangeNotifier {
  DateTime toDate = foreverMore;
  DateTime fromDate = foreverAgo;
  num commissionSuma = 0;
  String companyFilter = "all companies";
  String statusFilter = "active";

  String filterName = "by Date";

  int tooltime = 0;
  List<String> statusList = [
    "all status",
    "active",
    "ported",
    "lapsed",
  ];
  List<String> companyList = [
    "all companies",
    // "Niva",
    // "Star",
    // "none",
  ];

  void changeCompany(String newOne) {
    companyFilter = newOne;
    notifyListeners();
  }

  void changeStatus(String newOne) {
    statusFilter = newOne;
    notifyListeners();
  }

  void closeToolTip() {
    tooltime = 1;

    notifyListeners();
  }

  void clearSum() {
    commissionSuma = 0;

    notifyListeners();
  }

  void filterByWeek() {
    fromDate = oneWeekAgo;
    toDate = now;

    notifyListeners();
  }

  void filterByMonth() {
    fromDate = oneMonthAgo;
    toDate = now;
    filterName = "By Month";
    notifyListeners();
  }

  void filterByThreeMonths() {
    fromDate = threeMonthsAgo;
    toDate = now;

    notifyListeners();
  }

  void filterBySixMonths() {
    fromDate = sixMonthsAgo;
    toDate = now;

    notifyListeners();
  }

  void filterByYear() {
    fromDate = oneYearAgo;
    toDate = now;
    filterName = "By Year";

    notifyListeners();
  }

  void filterByTillNow() {
    fromDate = foreverAgo;
    toDate = foreverMore;
    filterName = "By Date";

    notifyListeners();
  }

  void filterByManual(DateTime fDate, DateTime tDate) {
    fromDate = fDate;
    toDate = tDate;
    filterName = "By Manual";

    notifyListeners();
  }

  void getCompanies(String type) {
    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: type)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          companyList.add(getFirstWord(value.docs[i]["name"]));
        }
      }
    });
    notifyListeners();
  }

  Future<num> sumCommission(bool isPending, String type) {
    num temp = 0;

    commissionSuma = 0;
    FirebaseFirestore.instance
        .collection("Commission")
        .where('commission_date', isGreaterThan: fromDate)
        .where('commission_date', isLessThan: toDate)
        .where("isPending", isEqualTo: true)
        .where("commission_type", isEqualTo: type)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i]["isPending"] == isPending) {
            if (value.docs[i]["company_name"] == companyFilter ||
                companyFilter == "all companies") {
              temp += value.docs[i]["commission_amt"];
            }
          }
        }
      }
      commissionSuma = temp;
    });
    notifyListeners();
    return Future(() => commissionSuma);
  }
}
