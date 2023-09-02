import 'package:to_csv/to_csv.dart' as exportCSV;

import 'exports.dart';

class ExcelFunctions {
  static void downloadHealthExcel() {
    List<List<String>> listOfLists = [];

    FirebaseFirestore.instance
        .collection("Policies")
        .where("type",
            isEqualTo: EnumUtils.convertTypeToKey(ProductType.health))
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

  static void downloadFDExcel() {
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

  static void downloadLifeExcel() {
    List<List<String>> listOfLists = [];

    FirebaseFirestore.instance
        .collection("Policies")
        .where("type", isEqualTo: EnumUtils.convertTypeToKey(ProductType.life))
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          List<String> temp = [
            value.docs[i]["life_no"],
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
            value.docs[i]["life_status"],
          ];
          listOfLists.add(temp);
          // DateTime renewalDate = value.docs[i]["renewal_date"].toDate();
        }
      }
      List<String> header = [
        "Life No",
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

  static void downloadMotorExcel() {
    List<List<String>> listOfLists = [];

    FirebaseFirestore.instance
        .collection("Policies")
        .where("type", isEqualTo: EnumUtils.convertTypeToKey(ProductType.motor))
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          List<String> temp = [
            value.docs[i]["motor_no"],
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
            value.docs[i]["motor_status"],
          ];
          listOfLists.add(temp);
          // DateTime renewalDate = value.docs[i]["renewal_date"].toDate();
        }
      }
      List<String> header = [
        "Motor No",
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
        "Motor Status"
      ];
      exportCSV.myCSV(header, listOfLists);
    });
  }

  static void downloadClientsExcel() {
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
}
