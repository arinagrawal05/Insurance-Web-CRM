// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import '/shared/const.dart';

// class GenericInvestmentData {
//   final String type;
//   final String name;
//   final String address;
//   final String phone;
//   final String email;
//   final bool isMale;
//   final Timestamp dob;
//   final String userid;
//   final String companyName;
//   final String companyLogo;
//   final String companyID;
//   final String bankDetails;
//   final String payMode;

//   GenericInvestmentData(
//       {required this.name,
//       required this.address,
//       required this.phone,
//       required this.email,
//       required this.isMale,
//       required this.dob,
//       required this.userid,
//       required this.type,
//       required this.companyName,
//       required this.companyID,
//       required this.companyLogo,
//       required this.bankDetails,
//       required this.payMode});
// }

// class PolicyData {
//   final GenericInvestmentData data;

//   // fromjson(json) {
//   //   if (json['type'] == 'poilicy') {
//   //     data = PolicyModel.fromJson(json);
//   //   }
//   // }

//   factory PolicyData.fromFirestore(DocumentSnapshot doc) {
//     dynamic map = doc.data();

//     if (map['type'] == AppConsts.fd) {
//       return PolicyData(data: FdModel.fromMap(map));
//       // data = PolicyModel.fromMap(map);
//     } else {
//       return PolicyData(data: PolicyModel.fromMap(map));
//     }
//   }

//   PolicyData({required this.data});
// }

// class PolicyModel extends GenericInvestmentData {
//   String policyID;
//   String policyStatus;
//   String policyNo;
//   int membersCount;
//   int premuimAmt;
//   int sumAssured;
//   int premiumTerm;
//   Timestamp issuedDate;
//   Timestamp inceptionDate;
//   Timestamp renewalDate;

//   String planName;
//   String planID;
//   String advisorName;
//   String nomineeName;
//   bool isFresh;
//   String portCompanyName;
//   String portPolicyNo;
//   String portSumAssured;
//   Timestamp portIssueDate;
//   Timestamp statusDate;

//   // String headUserid;

//   PolicyModel({
//     required String type,
//     required String name,
//     required String address,
//     required String phone,
//     required String email,
//     required String userid,
//     required bool isMale,
//     required Timestamp dob,
//     required String companyName,
//     required String companyID,
//     required String companyLogo,
//     required String bankDetails,
//     required String payMode,
//     required this.membersCount,
//     required this.policyID,
//     required this.policyNo,
//     required this.policyStatus,
//     required this.premuimAmt,
//     required this.premiumTerm,
//     required this.sumAssured,
//     required this.issuedDate,
//     required this.renewalDate,
//     required this.planID,
//     required this.planName,
//     required this.advisorName,
//     required this.nomineeName,
//     required this.isFresh,
//     required this.portCompanyName,
//     required this.portPolicyNo,
//     required this.portIssueDate,
//     required this.portSumAssured,
//     required this.statusDate,
//     required this.inceptionDate,

//     // required this.headUserid,
//   }) : super(
//             type: type,
//             address: address,
//             dob: dob,
//             email: email,
//             isMale: isMale,
//             name: name,
//             phone: phone,
//             userid: userid,
//             companyName: companyName,
//             companyID: companyID,
//             companyLogo: companyLogo,
//             bankDetails: bankDetails,
//             payMode: payMode);

//   Map<String, dynamic> toMap() {
//     return {
//       "company_name": companyName,
//       "company_logo": companyLogo,
//       "company_id": companyID,
//       "plan_name": planName,
//       "plan_id": planID,
//       "policy_id": policyID,
//       "uid": userid,
//       "dob": dob,
//       "members_count": membersCount,
//       "name": name,
//       "address": address,
//       "isMale": isMale,
//       "phone": phone,
//       "email": email,
//       "renewal_date": renewalDate,
//       "policy_no": policyNo,
//       "issued_date": issuedDate,
//       "policy_status": policyStatus,
//       "sum_assured": sumAssured,
//       "premium_amt": premuimAmt,
//       "premium_term": premiumTerm,
//       "nominee_name": nomineeName,
//       "advisor_name": advisorName,
//       "isFress": isFresh,
//       "payMode": payMode,
//       "port_company_name": portCompanyName,
//       "port_policy_no": portPolicyNo,
//       "port_issue_date": portIssueDate,
//       "port_sum_assured": portSumAssured,
//       "status_date": statusDate,
//       "inception_date": inceptionDate,
//     };
//   }

//   factory PolicyModel.fromMap(Map map) {
//     return PolicyModel(
//       name: map['name'] ?? map['policy_id'],
//       phone: map['phone'] ?? 'NA',
//       email: map['email'] ?? 'NA',
//       address: map['address'] ?? 'NA',
//       userid: map['uid'] ?? 'NA',
//       isMale: map['isMale'] ?? 'NA',
//       dob: map['dob'] ?? Timestamp.now(),
//       membersCount: map['members_count'] ?? 0,
//       premiumTerm: map['premium_term'] ?? 0,
//       policyID: map['policy_id'] ?? "NA",
//       issuedDate: map['issued_date'] ?? Timestamp.now(),
//       policyNo: map['policy_no'] ?? "NA",
//       policyStatus: map['policy_status'] ?? "NA",
//       premuimAmt: map['premium_amt'] ?? 0,
//       renewalDate: map['renewal_date'] ?? Timestamp.now(),
//       sumAssured: map['sum_assured'] ?? 0,
//       companyName: map['company_name'] ?? "NA",
//       companyLogo: map['company_logo'] ?? "NA",
//       companyID: map['company_id'] ?? "NA",
//       bankDetails: map['bank_details'] ?? "NA",
//       planID: map['plan_id'] ?? "NA",
//       planName: map['plan_name'] ?? "NA",
//       nomineeName: map['nominee_name'] ?? "NA",
//       advisorName: map['advisor_name'] ?? "NA",
//       isFresh: map['isFress'] ?? "NA",
//       payMode: map['payMode'] ?? "NA",
//       portCompanyName: map['port_company_name'] ?? "NA",
//       portPolicyNo: map['port_policy_no'] ?? "NA",
//       portSumAssured: map['port_sum_assured'] ?? "NA",
//       portIssueDate: map['port_issue_date'],
//       statusDate: map['status_date'] ?? Timestamp.now(),
//       inceptionDate: map['inception_date'] ?? Timestamp.now(),
//       type: map['type'] ?? "NA",
//     );
//   }

//   String toJson() => json.encode(toMap());
// }

// class FdModel extends GenericInvestmentData {
//   String fdId;
//   String fdStatus;
//   Timestamp maturityDate;
//   Timestamp initialDate;
//   Timestamp certificateTakenDate;
//   Timestamp certificateGivenDate;

//   int fDterm;
//   int investedAmt;
//   String fdNomineeName;
//   String portCompanyName;
//   String portFdNo;
//   String portMaturityAmt;
//   Timestamp portMaturityDate;
//   bool isCummulative;
//   String fdNo;
//   String cummulativeTerm;

//   FdModel({
//     required String type,
//     required String name,
//     required String address,
//     required String phone,
//     required String email,
//     required String userid,
//     required String companyName,
//     required String companyLogo,
//     required String companyID,
//     required bool isMale,
//     required Timestamp dob,
//     required String bankDetails,
//     required String payMode,
//     required this.fdId,
//     required this.fdStatus,
//     required this.maturityDate,
//     required this.fdNomineeName,
//     required this.initialDate,
//     required this.investedAmt,
//     required this.portCompanyName,
//     required this.portFdNo,
//     required this.portMaturityAmt,
//     required this.portMaturityDate,
//     required this.fDterm,
//     required this.certificateGivenDate,
//     required this.certificateTakenDate,
//     required this.isCummulative,
//     required this.fdNo,
//     required this.cummulativeTerm,

//     // required this.headUserid,
//   }) : super(
//             type: type,
//             address: address,
//             dob: dob,
//             email: email,
//             isMale: isMale,
//             name: name,
//             phone: phone,
//             userid: userid,
//             companyName: companyName,
//             companyID: companyID,
//             companyLogo: companyLogo,
//             bankDetails: bankDetails,
//             payMode: payMode);

//   Map<String, dynamic> toMap() {
//     return {
//       "type": type,
//       "uid": userid,
//       "dob": dob,
//       "name": name,
//       "address": address,
//       "isMale": isMale,
//       "phone": phone,
//       "email": email,
//       "fd_id": fdId,
//       "fd_status": fdStatus,
//       "maturity_date": maturityDate,
//       "initial_date": initialDate,
//       // "invested_amt": investedAmt,
//       // "premium_term": fDterm,
//       // "nominee_name": fdNomineeName,
//       "fd_taken_date": Timestamp.now(),
//       "fd_given_date": Timestamp.now(),
//       // "port_company_name": portCompanyName,
//       "port_fd_no": portFdNo,
//       "port_maturity_date": portMaturityDate,
//       "port_maturity_amt": portMaturityAmt,
//       "payMode": payMode,
//       "isCummulative": isCummulative,
//       "fd_no": fdNo,
//       "cummulative_term": cummulativeTerm
//     };
//   }

//   factory FdModel.fromMap(Map map) {
//     return FdModel(
//       name: map['name'] ?? 'NA',
//       phone: map['phone'] ?? "NA",
//       email: map['email'] ?? "NA",
//       address: map['address'] ?? "NA",
//       userid: map['uid'] ?? "NA",
//       isMale: map['isMale'] ?? "NA",
//       dob: map['dob'] ?? Timestamp.now(),
//       type: map['type'] ?? "NA",
//       fdId: map['fd_id'] ?? "NA",
//       companyName: map['company_name'] ?? "NA",
//       companyID: map['company_id'] ?? "NA",
//       companyLogo: map['company_logo'] ?? "NA",
//       fdStatus: map['fd_status'] ?? 'NA',
//       maturityDate: map['maturity_date'] ?? Timestamp.now(),
//       initialDate: map['initial_date'] ?? Timestamp.now(),
//       fDterm: map['premium_term'] ?? 0,
//       investedAmt: map['invested_amt'] ?? 0,
//       fdNomineeName: map['nominee_name'] ?? "NA",
//       certificateTakenDate: map['fd_taken_date'] ?? Timestamp.now(),
//       certificateGivenDate: map['fd_given_date'] ?? Timestamp.now(),
//       portCompanyName: map['port_company_name'] ?? "NA",
//       portFdNo: map['port_fd_no'] ?? "NA",
//       portMaturityDate: map['port_maturity_date'] ?? Timestamp.now(),
//       portMaturityAmt: map['port_maturity_amt'] ?? "NA",
//       payMode: map['payMode'] ?? "NA",
//       isCummulative: map['isCummulative'] ?? "NA",
//       fdNo: map['fd_no'] ?? "NA",
//       cummulativeTerm: map['cummulative_term'] ?? "NA",
//       bankDetails: map['bank_details'] ?? "NA",
//     );
//   }

//   String toJson() => json.encode(toMap());
// }
