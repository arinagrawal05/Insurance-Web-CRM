import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/enum_utils.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/general_stats_provider.dart';

class PolicyProvider extends ChangeNotifier {
  String client_name = "";
  String client_uid = "";
  String client_phone = "";
  String client_email = "";
  DateTime client_dob = DateTime.now();
  String client_address = "";
  bool client_isMale = true;
  int membersCount = 0;
  String companyName = "";
  String companyLogo = "";
  String companyID = "";
  String planName = "";
  String planID = "";
  String portCompanyName = "";
  String portPolicyNo = "";
  String portSumAssured = "";

  String portPolicyID = "";
  bool isFresh = true;
  DateTime portIssueDate = DateTime.now();

  String payModeSelected = "Credit/Debit";
  String termSelected = "1 Year";

  List<String> payModeList = [
    "Net banking",
    "Credit/Debit",
    "UPI",
    "Cheque",
  ];

  List<String> termList = [
    "1 Year",
    "2 Years",
    "3 Years",
  ];
  void selectpayMode(String mode) {
    payModeSelected = mode;
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   policyNumber.dispose();
  // }

  void selectTerm(String term) {
    termSelected = term;
    notifyListeners();
  }

  void feedPort(String companyName, String policyNo, String sumAssured,
      String policyIDa, DateTime portIssueDatea) {
    portCompanyName = companyName;
    portPolicyNo = policyNo;
    portPolicyID = policyIDa;
    portIssueDate = portIssueDatea;

    portSumAssured = sumAssured;
    isFresh = false;
    notifyListeners();
  }

  void clearPort() {
    portCompanyName = "";
    portPolicyNo = "";
    portPolicyID = "";
    isFresh = true;
    portIssueDate = DateTime.now();

    notifyListeners();
  }
  // String companyName = "";

  // String companyName = "";

  void setClient(String Uid, String Uname, String Uemail, DateTime Udob,
      String Uaddress, String Uphone, bool UisMale, int UmembersCount) {
    client_uid = Uid;
    client_name = Uname;
    client_phone = Uphone;
    client_email = Uemail;
    client_isMale = UisMale;
    client_dob = Udob;
    client_address = Uaddress;
    membersCount = UmembersCount;
    print("USer Data Set!!");
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

  // ThemeMode getCurrentThemes() {
  //   return themeMode;
  // }

  void performPolicyFunctions(
    String docId,
    DashProvider statsProvider,
    String inceptionDate,
  ) {
    addPolicy(
        textToDateTime(issuedDate.text), textToDateTime(inceptionDate), docId);

    print("take 1");
    if (AppConsts.isProductionMode) {
      updateStats("sum_premium_amt",
          statsProvider.premiumAmtSum + int.parse(premiumAmt.text));
      print("take 2");
      updateCompanybussiness(int.parse(premiumAmt.text), companyID);
      print("take 3");
      updateCompanyPlans(companyID, "policy_count");
      print("take 4");
      addCommision(
          client_name,
          policyNumber.text,
          int.parse(premiumAmt.text),
          textToDateTime(issuedDate.text),
          AppUtils.getFirstWord(companyName),
          statsProvider.healthPercent.toDouble(),
          "Health");
      print("take 5");
      makeATransaction(
          client_uid,
          docId,
          policyNumber.text,
          companyName,
          textToDateTime(issuedDate.text),
          int.parse(AppUtils.getFirstWord(termSelected)),
          int.parse(premiumAmt.text),
          membersCount,
          textToDateTime(issuedDate.text));
      print("take 6");
    }
    clearFields();
    print("take 0");
    clearPort();
  }

  void addPolicy(
    DateTime issuedDate,
    DateTime inceptionDate,
    String docId,
  ) {
    FirebaseFirestore.instance.collection("Policies").doc(docId).set({
      "company_name": companyName,
      "company_logo": companyLogo,
      "company_id": companyID,
      "plan_name": planName,
      "plan_id": planID,
      "policy_id": docId,
      "uid": client_uid,
      "dob": client_dob,
      "members_count": membersCount,
      "name": client_name,
      "address": client_address,
      "isMale": client_isMale,
      "phone": client_phone,
      "email": client_email,
      "renewal_date": issuedDate.add(
          Duration(days: 365 * int.parse(AppUtils.getFirstWord(termSelected)))),
      "policy_no": policyNumber.text,
      "issued_date": issuedDate,
      "inception_date": inceptionDate,
      "policy_status": "active",
      "sum_assured": int.parse(sumAssured.text),
      "premium_amt": int.parse(premiumAmt.text),
      "premium_term": int.parse(AppUtils.getFirstWord(termSelected)),
      "nominee_name": nomineeName.text,
      "advisor_name": advisorName.text,
      "isFress": isFresh,
      "port_company_name": portCompanyName,
      "port_policy_no": portPolicyNo,
      "port_issue_date": portIssueDate,
      "port_sum_assured": portSumAssured,
      "payMode": payModeSelected,
      "status_date": Timestamp.now(),
      "bank_details":
          "${chequeNo.text} || ${bankName.text} || ${bankDate.text}",
      "type": EnumUtils.convertTypeToKey(ProductType.health),
    }).then((value) {
      PolicyHiveHelper.fetchHealthPoliciesFromFirebase();
    });
  }

  final TextEditingController portCompanyNameController =
      TextEditingController();

  final TextEditingController portPolicyNoController = TextEditingController();

  final TextEditingController portSumAssuredController =
      TextEditingController();

  final TextEditingController postIssuedDate =
      TextEditingController(text: todayTextFormat());

  final freshFormKey = GlobalKey<FormState>();
  final TextEditingController policyNumber = TextEditingController();
  final TextEditingController sumAssured = TextEditingController();
  final TextEditingController premiumAmt = TextEditingController();
  final TextEditingController issuedDate =
      TextEditingController(text: todayTextFormat());
  // final TextEditingController inceptionDate =
  //     TextEditingController(text: todayTextFormat());

  final TextEditingController nomineeName = TextEditingController();
  final TextEditingController advisorName = TextEditingController();
  final TextEditingController chequeNo = TextEditingController();
  final TextEditingController bankDate = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final policyFormKey = GlobalKey<FormState>();

  void clearFields() {
    print("Hello");
    policyNumber.text = "";
    sumAssured.text = "";
    premiumAmt.text = "";
    issuedDate.text = todayTextFormat();
    nomineeName.text = "";
    advisorName.text = "";
    chequeNo.text = "";
    bankDate.text = "";
    bankName.text = "";
    portCompanyNameController.text = "";
    portSumAssuredController.text = "";
    portPolicyNoController.text = "";
    termSelected = "1 Year";
    payModeSelected = "Credit/Debit";
    ChangeNotifier();
  }
}
