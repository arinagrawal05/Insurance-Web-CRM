import 'package:intl/intl.dart';
import 'package:health_model/shared/exports.dart';

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

int addHealthWithGST(int number) {
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
  num sum = 0;
  FirebaseFirestore.instance
      .collection("Policies")
      .where("invested_amt", isEqualTo: "426381")
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      for (var i = 0; i < value.docs.length; i++) {
        print(value.docs[i]["fd_id"]);
        // sum += value.docs[i]["invested_amt"];
        //   FirebaseFirestore.instance
        //       .collection("Commission")
        //       .doc(value.docs[i]["commission_id"])
        //       .update({"commission_type": AppConsts.health});
        // }
        print("Successfully Temp Updated " + sum.toString());
      }
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

// updatePin(String pin) {
//   FirebaseFirestore.instance
//       .collection("Statistics")
//       .doc("KdMlwAoBwwkdREqX3hIe")
//       .update({"admin_pin": pin});
// }

// updateAdvisorList(List list) {
//   FirebaseFirestore.instance
//       .collection("Statistics")
//       .doc("KdMlwAoBwwkdREqX3hIe")
//       .update({"advisor_list": list});
// }

// updatePin(int pin) {
//   FirebaseFirestore.instance
//       .collection("Statistics")
//       .doc("5X1uBjP4Wqedj4SZspCg")
//       .update({"admin_pin": pin});
// }

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
    "isPending": false,
  }).then((value) {
    // CommissionHiveHelper.updateSpecifiCommission(
    //     documentID: commissionId, type: AppConsts.life);
    // print("Refetched Commissions ${AppConsts.life}");
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
    DateTime timestamp,
    String type) {
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
    "type": type,
  });
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

Duration getLifeDuration(
  LifePayterm term,
) {
  if (term == LifePayterm.monthly) {
    return const Duration(days: 30);
  } else if (term == LifePayterm.quarterly) {
    return const Duration(days: 91);
  } else if (term == LifePayterm.halfYearly) {
    return const Duration(days: 182);
  } else {
    return const Duration(days: 365);
  }
}

int getLifeTerm(LifePayterm term) {
  if (term == LifePayterm.monthly) {
    return 30;
  } else if (term == LifePayterm.quarterly) {
    return 91;
  } else if (term == LifePayterm.halfYearly) {
    return 182;
  } else {
    return 365;
  }
}

int addLifeWithGST(int number, {bool isFirst = false}) {
  int some = number;

  if (isFirst) {
    some += (number * 4.5 / 100).round();
    return some;
  } else {
    some += (number * 2.25 / 100).round();
    return some;
  }
}

setLoginPref(bool isLogged) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogged", isLogged);
}

setThemePref(ThemeMode mode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("ThemeSettings", mode.name);
}
