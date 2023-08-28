// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/functions.dart';

enum Cummulative { isCummulative, isNonCummulative }

class FDProvider extends ChangeNotifier {
  String client_head_name = "";
  String client_member_name = "";

  String client_uid = "";
  String client_member_uid = "";
  String client_relation = "";

  String client_phone = "";
  String client_email = "";
  Timestamp client_dob = Timestamp.now();
  String client_address = "";
  bool client_isMale = true;
  Iterable<MapEntry<int, num>> slabList = {MapEntry(24, 0.8)};
  // String companyName = "";
  String companyName = "";
  String companyLogo = "";
  String companyID = "";
  // String companyName = "";
  Cummulative isCummulative = Cummulative.isNonCummulative;
  String payModeSelected = "Cheque";
  String termSelected = "12 Months";
  String cTermSelected = "By Month";
  bool isFresh = true;

  void toggleFresh(bool isfresh) {
    isFresh = isfresh;
    notifyListeners();
  }

  List<String> cTermList = [
    "By Month",
    "By 6 months",
    "By Year",
  ];

  List<String> termList = [
    "12 Months",
    "18 Months",
    "24 Months",
    "30 Months",
    "36 Months",
    "42 Months",
    "48 Months",
    "50 Months",
    "54 Months",
    "60 Months",
  ];

  void selectpayMode(String mode) {
    payModeSelected = mode;
    notifyListeners();
  }

  void selectTerm(String term) {
    termSelected = term;
    notifyListeners();
  }

  void selectCterm(String term) {
    cTermSelected = term;
    notifyListeners();
  }

  void toggleCummulative(Cummulative isOn) {
    isCummulative = isOn;
    notifyListeners();
  }

  // ThemeMode getCurrentThemes() {
  // return themeMode;
  // }
// }
  void setHeadClient(
    String Uid,
    String Uname,
    String Uemail,
    String Uaddress,
    String Uphone,
  ) {
    client_uid = Uid;
    client_head_name = Uname;
    client_phone = Uphone;
    client_email = Uemail;
    client_address = Uaddress;
    print("User Head Data Set!!");
    notifyListeners();
  }

  void setMemberClient(
    String Uid,
    String Uname,
    String Urelation,
    Timestamp Udob,
    bool UisMale,
  ) {
    client_member_uid = Uid;
    client_member_name = Uname;
    client_isMale = UisMale;
    client_dob = Udob;
    client_relation = Urelation;

    print("UserClient Data Set!!");
    notifyListeners();
  }

  void setCompany(String cname, String cid, String clogo) {
    companyName = cname;
    companyID = cid;
    companyLogo = clogo;
    print("Company Data Set!!");

    notifyListeners();
  }

  void getList() {
    FirebaseFirestore.instance.collection("Slab").get().then((value) {
      if (value.docs.length > 0) {
        for (var i = 0; i < value.docs.length; i++) {
          // MapEntry slab =
          //     MapEntry(value.docs[i]["term"], value.docs[i]["percent"]);

          print(value.docs[i]["percent"]);
          // slabList.
        }
      }
    });
    notifyListeners();
  }

  Future<void> addFd(String docId) async {
    var body = {
      "company_logo": companyLogo,
      "company_name": companyName,
      "company_id": companyID,
      "fd_id": docId,
      "head_uid": client_uid,
      "head_name": client_head_name,
      "name": client_member_name,
      "uid": client_member_uid,
      "dob": client_dob,
      "address": client_address,
      "isMale": client_isMale,
      "phone": client_phone,
      "email": client_email,
      "initial_date": textToDateTime(initialDate.text),
      "maturity_date": textToDateTime(initialDate.text).add(
          Duration(days: 30 * int.parse(AppUtils.getFirstWord(termSelected)))),
      "fd_status": "applied",
      "invested_amt": int.parse(investedAmt.text),
      "type": AppConsts.fd,
      "premium_term": int.parse(AppUtils.getFirstWord(termSelected)),
      "nominee_name": nomineeName.text,
      "nominee_relation": nomineeRelation.text,
      "nominee_dob": textToDateTime(nomineeDob.text),
      "fd_taken_date": Timestamp.now(),
      "fd_given_date": Timestamp.now(),
      "port_company_name": portCompanyNameController.text,
      "port_fd_no": portFdNo.text,
      "port_maturity_date": textToDateTime(portMaturityDate.text),
      "port_maturity_amt": portMaturityAmt.text,
      "payMode": payModeSelected,
      "isCummulative":
          isCummulative == Cummulative.isCummulative ? true : false,
      "cummulative_term": cTermSelected,
      "bank_details":
          "${chequeNo.text} || ${bankName.text} || ${bankDate.text}",
      "fd_no": "NA",
      "isFresh": isFresh,
      "status_date": DateTime.now(),
    };

    print('Sending ' + body.toString());
    AppUtils.showSnackMessage("FD Successfully Added", "");
    await FirebaseFirestore.instance
        .collection("Policies")
        .doc(docId)
        .set(body)
        .then((value) {
      PolicyHiveHelper.fetchFDPoliciesFromFirebase();
    });
  }

  Future<void> editFd(String docId, String initialDate, String maturityDate,
      int investedAmt, int maturityAmt, String fdNo, String folioNo) async {
    var body = {
      "initial_date": textToDateTime(initialDate),
      "invested_amt": investedAmt,
      "maturity_date": textToDateTime(maturityDate),
      "maturity_amt": maturityAmt,
      "fd_no": fdNo,
      "folio_no": folioNo,
    };

    print('Sending ' + body.toString());
    // AppUtils.showSnackMessage("FD Successfully Edited", "");
    await FirebaseFirestore.instance
        .collection("Policies")
        .doc(docId)
        .update(body)
        .then((value) {
      AppUtils.showSnackMessage("FD Successfully Edited", "");

      PolicyHiveHelper.fetchFDPoliciesFromFirebase();
    });
  }

  Future<void> renewFd(String docId, int investedAmt) async {
    var body = {
      "initial_date": textToDateTime(initialDate.text),
      "maturity_date": textToDateTime(initialDate.text).add(
          Duration(days: 30 * int.parse(AppUtils.getFirstWord(termSelected)))),
      "fd_status": "applied",
      "invested_amt": investedAmt,
      "type": AppConsts.fd,
      "premium_term": int.parse(AppUtils.getFirstWord(termSelected)),
      "fd_taken_date": Timestamp.now(),
      "fd_given_date": Timestamp.now(),
      "payMode": payModeSelected,
      "bank_details":
          "${chequeNo.text} || ${bankName.text} || ${bankDate.text}",
      "fd_no": "NA",
      "status_date": DateTime.now(),
    };

    print('Sending ' + body.toString());
    AppUtils.showSnackMessage("FD Successfully Added", "");
    await FirebaseFirestore.instance
        .collection("Policies")
        .doc(docId)
        .update(body)
        .then((value) {
      PolicyHiveHelper.fetchFDPoliciesFromFirebase();
    });
  }

  final TextEditingController portCompanyNameController =
      TextEditingController();

  final TextEditingController portFdNo = TextEditingController();

  final TextEditingController portMaturityAmt = TextEditingController();

  final TextEditingController portMaturityDate =
      TextEditingController(text: todayTextFormat());

  final freshFormKey = GlobalKey<FormState>();
  // final TextEditingController investedAmt = TextEditingController();

  final TextEditingController investedAmt = TextEditingController();
  final TextEditingController nomineeName = TextEditingController();
  final TextEditingController nomineeRelation = TextEditingController();
  final TextEditingController nomineeDob = TextEditingController();

  final TextEditingController chequeNo = TextEditingController();
  final TextEditingController bankDate = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  TextEditingController initialDate =
      TextEditingController(text: todayTextFormat());
  final fdFormKey = GlobalKey<FormState>();
}
