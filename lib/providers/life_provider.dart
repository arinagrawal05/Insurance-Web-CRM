// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/functions.dart';

import '../shared/enum_utils.dart';

class LifeProvider extends ChangeNotifier {
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
  Iterable<MapEntry<int, num>> slabList = {const MapEntry(24, 0.8)};
  // String companyName = "";
  String companyName = "";
  String companyLogo = "";
  String companyID = "";

  String planName = "";
  String planID = "";
  // String companyName = "";
  Payterm payterm = Payterm.quarterly;
  String payModeSelected = "Cheque";
  String paidTermSelected = "1 year";
  String maturedTermSelected = "1 year";
  bool isFresh = true;

  void toggleFresh(bool isfresh) {
    isFresh = isfresh;
    notifyListeners();
  }

  // List<String> cTermList = [
  //   "By Month",
  //   "By 6 months",
  //   "By Year",
  // ];
  List<String> payModeList = [
    "Cheque",
    "Net banking",
    "Credit/Debit",
    "UPI",
  ];

  List<String> termList = [
    "1 Year",
    "2 Years",
    "3 Years",
    "4 Years",
    "5 Years",
    "6 Years",
    "7 Years",
    "8 Years",
    "9 Years",
    "10 Years",
    "11 Years",
    "12 Years",
    "13 Years",
    "14 Years",
    "15 Years",
    "16 Years",
    "17 Years",
    "18 Years",
    "19 Years",
    "20 Years",
    "21 Years",
    "22 Years",
    "23 Years",
    "24 Years",
    "25 Years",
    "26 Years",
    "27 Years",
    "28 Years",
    "29 Years",
    "30 Years",
    "31 Years",
    "32 Years",
    "33 Years",
    "34 Years",
    "35 Years",
    "36 Years",
    "37 Years",
    "38 Years",
    "39 Years",
    "40 Years",
    "41 Years",
    "42 Years",
    "43 Years",
    "44 Years",
    "45 Years",
    "46 Years",
    "47 Years",
    "49 Years",
    "50 Years",
  ];

  void selectpayMode(String mode) {
    payModeSelected = mode;
    notifyListeners();
  }

  void selectPaidTerm(String term) {
    paidTermSelected = term;
    notifyListeners();
  }

  void selectMaturedterm(String term) {
    maturedTermSelected = term;
    notifyListeners();
  }

  void togglePayterm(Payterm isOn) {
    payterm = isOn;
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

  void setPlan(String Pname, String Pid) {
    planName = Pname;
    planID = Pid;
    print("Plan Data Set!!");

    notifyListeners();
  }

  void performLifePolicyFunctions(
    String docId,
  ) {
    addLife(docId);

    print("take 1");
    // if (AppConsts.isProductionMode) {
    //   print("take 2");
    //   updateCompanybussiness(int.parse(premiumAmt.text), companyID);
    //   print("take 3");
    //   updateCompanyPlans(companyID, "policy_count");
    //   print("take 4");
    addCommision(
        client_member_name,
        lifeNumber.text,
        int.parse(premiumAmt.text),
        textToDateTime(issuedDate.text),
        AppUtils.getFirstWord(companyName),
        0,
        "Life");
    print("take 5");
    makeATransaction(
        client_uid,
        docId,
        lifeNumber.text,
        companyName,
        textToDateTime(issuedDate.text),
        getLifeTerm(payterm),
        int.parse(premiumAmt.text),
        1,
        textToDateTime(issuedDate.text)
            .add(Duration(days: getLifeTerm(payterm) * 30)));
    print("take 6");
    // }
    // clearFields();
    print("take 0");
    // clearPort();
  }

  Future<void> addLife(String docId) async {
    print("adding life");
    var body = {
      "company_logo": companyLogo,
      "company_name": companyName,
      "company_id": companyID,
      "plan_id": planID,
      "plan_name": planName,
      "life_no": lifeNumber.text,
      "life_id": docId,
      "head_uid": client_uid,
      "head_name": client_head_name,
      "name": client_member_name,
      "uid": client_member_uid,
      "dob": client_dob,
      "address": client_address,
      "isMale": client_isMale,
      "phone": client_phone,
      "email": client_email,
      "life_status": "enforced",
      "premium_amt": addLifeWithGST(int.parse(premiumAmt.text), isFirst: true),
      "payterm": payterm.name,
      "type": AppConsts.life,

      "commitment_date": textToDateTime(initialDate.text),
      "maturity_date": textToDateTime(initialDate.text).add(Duration(
          days: 365 * int.parse(AppUtils.getFirstWord(maturedTermSelected)))),
      "pay_till_date": textToDateTime(initialDate.text).add(Duration(
          days: 365 * int.parse(AppUtils.getFirstWord(paidTermSelected)))),
      "renewal_date":
          textToDateTime(initialDate.text).add(getLifeDuration(payterm)),
      "last_renewed_date": textToDateTime(initialDate.text),

      "nominee_name": nomineeName.text,
      "nominee_relation": nomineeRelation.text,
      "nominee_dob": textToDateTime(nomineeDob.text),
      "sum_assured": int.parse(sumAssured.text),
      // "fd_taken_date": Timestamp.now(),
      // "fd_given_date": Timestamp.now(),
      // "port_company_name": portCompanyNameController.text,
      // "port_fd_no": portFdNo.text,
      // "port_maturity_date": textToDateTime(portMaturityDate.text),
      // "port_maturity_amt": portMaturityAmt.text,
      "payMode": payModeSelected,
      "times_paid": 1,

      // "isCummulative":
      //     isCummulative == Cummulative.isCummulative ? true : false,
      // "cummulative_term": cTermSelected,
      "bank_details":
          "${chequeNo.text} || ${bankName.text} || ${bankDate.text}",
      // "isFresh": isFresh,
    };

    print('Sending ' + body.toString());
    AppUtils.showSnackMessage("Life Successfully Added", "");
    await FirebaseFirestore.instance
        .collection("Policies")
        .doc(docId)
        .set(body)
        .then((value) {
      AppUtils.showSnackMessage("Life added", "yes");

      PolicyHiveHelper.fetchLifePoliciesFromFirebase();
    });
  }

  // Future<void> editLife(String docId, String initialDate, String maturityDate,
  //     int investedAmt, int maturityAmt, String fdNo, String folioNo) async {
  //   var body = {
  //     "initial_date": textToDateTime(initialDate),
  //     "invested_amt": investedAmt,
  //     "maturity_date": textToDateTime(maturityDate),
  //     "maturity_amt": maturityAmt,
  //     "fd_no": fdNo,
  //     "folio_no": folioNo,
  //   };

  //   print('Sending ' + body.toString());
  //   // AppUtils.showSnackMessage("FD Successfully Edited", "");
  //   await FirebaseFirestore.instance
  //       .collection("Policies")
  //       .doc(docId)
  //       .update(body)
  //       .then((value) {
  //     AppUtils.showSnackMessage("FD Successfully Edited", "");

  //     PolicyHiveHelper.fetchFDPoliciesFromFirebase();
  //   });
  // }

  // Future<void> renewLife(String docId, int investedAmt) async {
  //   var body = {
  //     "initial_date": textToDateTime(initialDate.text),
  //     "maturity_date": textToDateTime(initialDate.text).add(
  //         Duration(days: 30 * int.parse(AppUtils.getFirstWord(termSelected)))),
  //     "fd_status": "applied",
  //     "invested_amt": investedAmt,
  //     "type": AppConsts.fd,
  //     "premium_term": int.parse(AppUtils.getFirstWord(termSelected)),
  //     "fd_taken_date": Timestamp.now(),
  //     "fd_given_date": Timestamp.now(),
  //     "payMode": payModeSelected,
  //     "bank_details":
  //         "${chequeNo.text} || ${bankName.text} || ${bankDate.text}",
  //     "fd_no": "NA",
  //     "status_date": DateTime.now(),
  //   };

  //   print('Sending ' + body.toString());
  //   AppUtils.showSnackMessage("FD Successfully Added", "");
  //   await FirebaseFirestore.instance
  //       .collection("Policies")
  //       .doc(docId)
  //       .update(body)
  //       .then((value) {
  //     PolicyHiveHelper.fetchFDPoliciesFromFirebase();
  //   });
  // }

  final TextEditingController lifeNumber = TextEditingController();
  final TextEditingController sumAssured = TextEditingController();
  final TextEditingController premiumAmt = TextEditingController();
  final TextEditingController issuedDate =
      TextEditingController(text: todayTextFormat());
  // final TextEditingController inceptionDate =
  //     TextEditingController(text: todayTextFormat());

  final TextEditingController nomineeName = TextEditingController();
  final TextEditingController nomineeRelation = TextEditingController();
  final TextEditingController nomineeDob = TextEditingController();
  final TextEditingController advisorName = TextEditingController();
  final TextEditingController chequeNo = TextEditingController();
  final TextEditingController bankDate = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  TextEditingController initialDate =
      TextEditingController(text: todayTextFormat());
  final lifeFormKey = GlobalKey<FormState>();

  void clearFields() {
    lifeNumber.text = "";
    sumAssured.text = "";
    premiumAmt.text = "";
    issuedDate.text = todayTextFormat();
    nomineeName.text = "";
    advisorName.text = "";
    chequeNo.text = "";
    bankDate.text = "";
    bankName.text = "";
    paidTermSelected = "1 Year";
    payModeSelected = "Credit/Debit";
    ChangeNotifier();
  }
}
