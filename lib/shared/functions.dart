import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_model/hive/hive_helpers/commission_hive_helper.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/general_stats_provider.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/enum_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;
import 'package:intl/intl.dart';

class AppUtils {
  static String getFirstWord(String fullName) {
    List local = fullName.split(" ");
    return local[0];
  }

  static String getStatsControllerTag() {
    ProductType type = Get.find<DashProvider>().currentDashBoard;

    // GeneralStatsProvider statsController =
    //     Get.find<GeneralStatsProvider>(tag: 'statsFor${type.name}');

    return 'statsFor${type.name}';
  }

  static String formatAmount(int number) {
    final NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    return numberFormat.format(number);
  }

  static void showSnackMessage(String title, String subtitle) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.BOTTOM,
        barBlur: 3,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20));
  }
}

List bankDetailsConverter(String term) {
  List aa = term.split(" || ");
  return aa;
}

bool getGender(
  String selectedGender,
) {
  bool ans = true;
  switch (selectedGender) {
    case "Son":
      ans = true;

      break;
    case "Daughter":
      ans = false;

      break;
    case "Father":
      ans = true;

      break;
    case "Mother":
      ans = false;

      break;
    case "Sister":
      ans = false;

      break;
    case "Spouse":
      ans = false;

      break;
    case "Brother":
      ans = true;

      break;
    case "Head":
      ans = true;

      break;
    default:
      {
        return true;
      }
  }
  return ans;
}

int addWithGST(int number) {
  int some = number;
  some += (number * 18 / 100).round();
  return some;
}

String dateTimetoText(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

String todayTextFormat() {
  DateTime date = DateTime.now();
  return "${date.day}/${date.month}/${date.year}";
}

DateTime textToDateTime(String text) {
  List data = text.split("/");

  return DateTime(
    int.parse(data[2]),
    int.parse(data[1]),
    int.parse(data[0]),
  );
}

Future<Future> navigate(
  Widget pagename,
  BuildContext context,
) async {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => pagename,
    ),
  );
}

void downloadClientsExcel() {
  List<List<String>> listOfLists = [];

  FirebaseFirestore.instance.collection("Users").get().then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        List<String> temp = [
          value.docs[i]["name"],
          value.docs[i]["phone"],
          value.docs[i]["email"],
          dateTimetoText(value.docs[i]["dob"].toDate()),
          value.docs[i]["isMale"].toString(),
          value.docs[i]["address"],
          value.docs[i]["members_count"].toString(),
        ];
        listOfLists.add(temp);
        // DateTime renewalDate = value.docs[i]["renewal_date"].toDate();
      }
    }
    List<String> header = [
      "Policy No",
      "Name",
      "Phone",
      "Email",
      "dob",
      "Gender",
      "Address",
      "Members",
    ];
    exportCSV.myCSV(
      header,
      listOfLists,
    );
  });
}

void downloadHealthExcel() {
  List<List<String>> listOfLists = [];

  FirebaseFirestore.instance
      .collection("Policies")
      .where("type", isEqualTo: EnumUtils.convertTypeToKey(ProductType.health))
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        List<String> temp = [
          value.docs[i]["policy_no"],
          value.docs[i]["name"],
          value.docs[i]["phone"],
          value.docs[i]["email"],
          dateTimetoText(value.docs[i]["dob"].toDate()),
          value.docs[i]["isMale"].toString(),
          value.docs[i]["address"],
          value.docs[i]["company_name"],
          value.docs[i]["plan_name"],
          dateTimetoText(value.docs[i]["inception_date"].toDate()),
          dateTimetoText(value.docs[i]["issued_date"].toDate()),
          value.docs[i]["sum_assured"].toString(),
          value.docs[i]["premium_amt"].toString(),
          value.docs[i]["policy_status"],
        ];
        listOfLists.add(temp);
        // DateTime renewalDate = value.docs[i]["renewal_date"].toDate();
      }
    }
    List<String> header = [
      "Policy No",
      "Name",
      "Phone",
      "Email",
      "dob",
      "Gender",
      "Address",
      "Company",
      "Plan",
      "Inception Date",
      "Starting Date",
      "Sum Assured",
      "Premium Amount"
          "Policy Status"
    ];
    exportCSV.myCSV(header, listOfLists);
  });
}

void downloadFDExcel() {
  List<List<String>> listOfLists = [];

  FirebaseFirestore.instance
      .collection("Policies")
      .where("type", isEqualTo: EnumUtils.convertTypeToKey(ProductType.fd))
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        List<String> temp = [
          value.docs[i]["fd_no"],
          value.docs[i]["name"],
          value.docs[i]["phone"],
          value.docs[i]["email"],
          dateTimetoText(value.docs[i]["dob"].toDate()),
          value.docs[i]["isMale"].toString(),
          value.docs[i]["address"],
          value.docs[i]["company_name"],
          dateTimetoText(value.docs[i]["initial_date"].toDate()),
          // dateTimetoText(value.docs[i]["issued_date"].toDate()),
          // value.docs[i]["sum_assured"].toString(),
          // value.docs[i]["premium_amt"].toString(),
          value.docs[i]["fd_status"],
        ];
        listOfLists.add(temp);
        // DateTime renewalDate = value.docs[i]["renewal_date"].toDate();
      }
    }
    List<String> header = [
      "FD No",
      "Name",
      "Phone",
      "Email",
      "dob",
      "Gender",
      "Address",
      "Company",
      "Starting Date",
      // "Starting Date",
      // "Sum Assured",
      // "Premium Amount"
      "FD Status"
    ];
    exportCSV.myCSV(header, listOfLists);
  });
}

launchURL(String url) async {
  var link = Uri.parse(url);
  if (await canLaunchUrl(link)) {
    await launchUrl(link);
  } else {
    throw 'Could not launch $url';
  }
}

updatePolicyStatus(String policyID, String status, DateTime statusDate) {
  FirebaseFirestore.instance.collection("Policies").doc(policyID).update({
    "policy_status": status,
    "status_date": statusDate,
  });
}

void updateTemp() async {
  print("object");
  FirebaseFirestore.instance.collection("Commission").get().then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        FirebaseFirestore.instance
            .collection("Commission")
            .doc(value.docs[i]["commission_id"])
            .update({"commission_type": AppConsts.health});
      }
      print("Successfully Temp Updated");
    }
  });
  // FirebaseFirestore.instance
  //     .collection("Policies")
  //     .where("company_name", isEqualTo: "Care Health Insurance Co.")
  //     .get()
  //     .then((value) {
  //   if (value.docs.isNotEmpty) {
  //     for (var i = 0; i < value.docs.length; i++) {
  //       // print(value.docs[i]["policy_id"]);
  //       FirebaseFirestore.instance
  //           .collection("Policies")
  //           .doc(value.docs[i]["policy_id"])
  //           .update({
  //         "company_logo":
  //             "https://play-lh.googleusercontent.com/ZBdHZIdRgt-8pMRTHrSiJqLLQ_03SDr9LVfj_wZOUOgEb5CXA2_Dy-0pJdNKVicex-BS"
  //       });
  //     }
  // print("Successfully Temp Updated");
  // }
  // print("Successfully Temp Updated 2");
  // });
  // print("Successfully Temp Updated 3");
}

// bool selectedPolicy(PolicyModel policyModel, String companyFilter,
//     String statusFilter, DateTime fromDate, DateTime toDate) {
//   if (getFirstWord(policyModel.companyName) == companyFilter ||
//       companyFilter == "all companies") {
//     if (policyModel.policyStatus == statusFilter ||
//         statusFilter == "all status") {
//       if (policyModel.renewalDate.toDate().isAfter(fromDate) &&
//           policyModel.renewalDate.toDate().isBefore(toDate)) {
//         return true;
//       }
//     }
//   }
//   return false;
// }

// bool selectedFd(FdModel fdModel, String companyFilter, String statusFilter,
//     DateTime fromDate, DateTime toDate) {
//   if (getFirstWord(fdModel.companyName) == companyFilter ||
//       companyFilter == "all companies") {
//     if (fdModel.fdStatus == statusFilter || statusFilter == "all status") {
//       if (fdModel.initialDate.toDate().isAfter(fromDate) &&
//           fdModel.initialDate.toDate().isBefore(toDate)) {
//         return true;
//       }
//     }
//   }
//   return false;
// }

void deleteTemp() {
  print("called");
  FirebaseFirestore.instance
      .collection("Policies")
      .where("name", isEqualTo: "Rama Namdeo")
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        print(value.docs[i]["policy_id"].toString());
        print(value.docs.length);
        // FirebaseFirestore.instance
        //     .collection("Policies")
        //     .doc(value.docs[i]["fd_id"])
        //     .delete();
      }
      print("Successfully Temp Deleted");
    }
  });
}

void checkGraced() {
  FirebaseFirestore.instance
      .collection("Policies")
      .where("policy_status", isEqualTo: "active")
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        DateTime renewalDate = value.docs[i]["renewal_date"].toDate();

        if (DateTime.now().difference(renewalDate).inDays > 30) {
          FirebaseFirestore.instance
              .collection("Policies")
              .doc(value.docs[i]["policy_id"])
              .update(
                  {"policy_status": "lapsed", "status_date": DateTime.now()});
          print("Changed $i");
        }
      }
    }
  });
}

updateStats(String key, num value) {
  FirebaseFirestore.instance
      .collection("Statistics")
      .doc("KdMlwAoBwwkdREqX3hIe")
      .update({key: value});
}

updatePin(String pin) {
  FirebaseFirestore.instance
      .collection("Statistics")
      .doc("KdMlwAoBwwkdREqX3hIe")
      .update({"admin_pin": pin});
}

updateAdvisorList(List list) {
  FirebaseFirestore.instance
      .collection("Statistics")
      .doc("KdMlwAoBwwkdREqX3hIe")
      .update({"advisor_list": list});
}

// updatePin(int pin) {
//   FirebaseFirestore.instance
//       .collection("Statistics")
//       .doc("5X1uBjP4Wqedj4SZspCg")
//       .update({"admin_pin": pin});
// }

updateCompanybussiness(num number, String companyId, {negative = false}) {
  int current = 0;

  FirebaseFirestore.instance
      .collection("Companies")
      .where("company_id", isEqualTo: companyId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      current = value.docs[0]["total_bussiness"];
      if (negative) {
        FirebaseFirestore.instance
            .collection("Companies")
            .doc(companyId)
            .update({
          "total_bussiness": current - number,
        });
      } else {
        FirebaseFirestore.instance
            .collection("Companies")
            .doc(companyId)
            .update({
          "total_bussiness": current + number,
        });
      }
    }
  });
}

updateCompanyPlans(String companyId, String keyTerm, {bool toRemove = false}) {
  int plansCount = 0;
  FirebaseFirestore.instance
      .collection("Companies")
      .where("company_id", isEqualTo: companyId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      plansCount = value.docs[0][keyTerm];
      toRemove
          ? FirebaseFirestore.instance
              .collection("Companies")
              .doc(companyId)
              .update({
              keyTerm: plansCount - 1,
            })
          : FirebaseFirestore.instance
              .collection("Companies")
              .doc(companyId)
              .update({
              keyTerm: plansCount + 1,
            });
    }
  });
}

updateMembers(String userid, {bool toRemove = false}) {
  int membersCount = 0;
  FirebaseFirestore.instance
      .collection("Users")
      .where("userid", isEqualTo: userid)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      membersCount = value.docs[0]["members_count"];
      toRemove
          ? FirebaseFirestore.instance.collection("Users").doc(userid).update({
              "members_count": membersCount - 1,
            })
          : FirebaseFirestore.instance.collection("Users").doc(userid).update({
              "members_count": membersCount + 1,
            });
    }
  });
}

void addCommision(String clientName, String policyNo, int premiumAmt,
    DateTime issuedDate, String companyName, double percent, String type) {
  var uuid = const Uuid();
  String docId = uuid.v4();
  FirebaseFirestore.instance.collection("Commission").doc(docId).set({
    "commission_id": docId,
    "policy_id": docId,
    "name": clientName,
    "commission_type": type,
    "commission_date": issuedDate,
    "policy_no": policyNo,
    "issued_date": issuedDate,
    "isPending": true,
    "premium_amt": premiumAmt,
    "company_name": companyName,
    "commission_amt": (premiumAmt * (percent / 100)).roundToDouble().toInt(),
  });
}

void claimCommission(
    String commissionId, int commisionAmt, DateTime commisionDate) {
  FirebaseFirestore.instance.collection("Commission").doc(commissionId).update({
    "commission_amt": commisionAmt,
    "commission_date": commisionDate,
    "isPending": false
  }).then((value) {
    CommissionHiveHelper.updateSpecifiCommission(documentID: commissionId);
  });
}

void makeARenewal(DateTime nextRenewal, String policyID) {
  FirebaseFirestore.instance.collection("Policies").doc(policyID).update({
    "renewal_date": nextRenewal,
  });
}

void makeATransaction(
    userID,
    String policyID,
    String policyNo,
    companyName,
    DateTime beginsDate,
    int terms,
    int premuimAmt,
    int memberCount,
    DateTime timestamp) {
  var uuid = const Uuid();
  String docId = uuid.v4();
  FirebaseFirestore.instance.collection("Transactions").doc(docId).set({
    "transaction_id": docId,
    "userid": userID,
    "premium_amt": premuimAmt,
    "begins_date": beginsDate,
    "policy_id": policyID,
    "policy_no": policyNo,
    "company_name": companyName,
    "terms": terms,
    "members_count": memberCount,
    "timestamp": timestamp,
    "policy_status": "active",
  });
}

DocumentSnapshot<Object?>? getPolicy(String uid) {
  // DocumentSnapshot<Object?> initialSnapshot;

  FirebaseFirestore.instance
      .collection("Policies")
      .where("uid", isEqualTo: uid)
      .get()
      .then((value) {
    // if (value.docs.length > 0) {
    // for (var i = 0; i < value.docs.length; i++) {
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('Policies')
        .doc(value.docs[0]["policy_id"]);

    documentRef.get().then((snapshot) {
      return snapshot;
    });
    // }
    // }
  });
  return null;
}

String getWord(String dashName) {
  if (dashName == ProductType.health) {
    return "Policies";
  } else {
    return "Fds";
  }
}

double getFdCommission(
  int term,
) {
  double ans = 0.4;
  switch (term) {
    case 12:
      ans = 0.4;

      break;
    case 24:
      ans = 0.8;

      break;
    case 36:
      ans = 1.2;

      break;
    case 48:
      ans = 1.6;

      break;
    case 60:
      ans = 2.0;

      break;
    case 50:
      ans = 1.8;

      break;

    default:
      {
        return 0.4;
      }
  }
  return ans;
}

setLoginPref(bool isLogged) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogged", isLogged);
}

setThemePref(ThemeMode mode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("ThemeSettings", mode.name);
}
