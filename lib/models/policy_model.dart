import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GenericInvestmentData {}

// class PolicyData {
//    String type;
//    GenericInvestmentData data;

//   fromjson(json) {
//     if (json['type'] == 'fd') {
//       data = FDData();
//     }
//   }

//   PolicyData({required this.data, required this.type});
// }

// class FDData extends GenericInvestmentData {
//   String phone;
//   String email;
//   bool isMale;
//   Timestamp dob;
//   String userid;
//   String policyID;
//   String policyStatus;
//   //
// }

class PolicyModel extends GenericInvestmentData {
  String name;
  String address;
  String phone;
  String email;
  bool isMale;
  Timestamp dob;
  String userid;
  String policyID;
  String policyStatus;
  String policyNo;

  int membersCount;
  int premuimAmt;
  int sumAssured;
  int premiumTerm;

  Timestamp issuedDate;
  Timestamp inceptionDate;
  Timestamp renewalDate;
  String companyName;
  String companyLogo;
  String companyID;
  String planName;
  String planID;
  String advisorName;
  String nomineeName;
  String payMode;
  bool isFresh;
  String portCompanyName;
  String portPolicyNo;
  String portSumAssured;
  Timestamp portIssueDate;
  Timestamp statusDate;

  // String headUserid;

  PolicyModel({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.userid,
    required this.isMale,
    required this.dob,
    required this.membersCount,
    required this.policyID,
    required this.policyNo,
    required this.policyStatus,
    required this.premuimAmt,
    required this.premiumTerm,
    required this.sumAssured,
    required this.issuedDate,
    required this.renewalDate,
    required this.companyID,
    required this.companyLogo,
    required this.companyName,
    required this.planID,
    required this.planName,
    required this.advisorName,
    required this.nomineeName,
    required this.payMode,
    required this.isFresh,
    required this.portCompanyName,
    required this.portPolicyNo,
    required this.portIssueDate,
    required this.portSumAssured,
    required this.statusDate,
    required this.inceptionDate,

    // required this.headUserid,
  });

  Map<String, dynamic> toMap() {
    return {
      "company_name": companyName,
      "company_logo": companyLogo,
      "company_id": companyID,
      "plan_name": planName,
      "plan_id": planID,
      "policy_id": policyID,
      "uid": userid,
      "dob": dob,
      "members_count": membersCount,
      "name": name,
      "address": address,
      "isMale": isMale,
      "phone": phone,
      "email": email,
      "renewal_date": renewalDate,
      "policy_no": policyNo,
      "issued_date": issuedDate,
      "policy_status": policyStatus,
      "sum_assured": sumAssured,
      "premium_amt": premuimAmt,
      "premium_term": premiumTerm,
      "nominee_name": nomineeName,
      "advisor_name": advisorName,
      "isFress": isFresh,
      "payMode": payMode,
      "port_company_name": portCompanyName,
      "port_policy_no": portPolicyNo,
      "port_issue_date": portIssueDate,
      "port_sum_assured": portSumAssured,
      "status_date": statusDate,
      "inception_date": inceptionDate,
    };
  }

  factory PolicyModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return PolicyModel(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      userid: map['uid'],
      isMale: map['isMale'],
      dob: map['dob'],
      membersCount: map['members_count'],
      premiumTerm: map['premium_term'],
      policyID: map['policy_id'],
      issuedDate: map['issued_date'],
      policyNo: map['policy_no'],
      policyStatus: map['policy_status'],
      premuimAmt: map['premium_amt'],
      renewalDate: map['renewal_date'],
      sumAssured: map['sum_assured'],
      companyName: map['company_name'],
      companyLogo: map['company_logo'],

      companyID: map['company_id'],
      planID: map['plan_id'],
      planName: map['plan_name'],
      nomineeName: map['nominee_name'],
      advisorName: map['advisor_name'],
      isFresh: map['isFress'],
      payMode: map['payMode'],
      portCompanyName: map['port_company_name'],
      portPolicyNo: map['port_policy_no'],
      portSumAssured: map['port_sum_assured'],
      portIssueDate: map['port_issue_date'],
      statusDate: map['status_date'],
      inceptionDate: map['inception_date'],

      // headUserid: map['head_userid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyModel.fromJson(String source) =>
      PolicyModel.fromFirestore(json.decode(source));
}
