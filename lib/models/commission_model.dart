// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class CommissionModel {
//   String name;
//   String policyID;
//   String policyNo;
//   Timestamp issuedDate;
//   Timestamp commissionDate;
//   bool isPending;
//   int premiumAmt;
//   int commissionAmt;
//   String companyName;
//   String commissionType;

//   String commissionId;
//   // String headUserid;

//   CommissionModel(
//       {required this.name,
//       required this.commissionAmt,
//       required this.commissionDate,
//       required this.isPending,
//       required this.premiumAmt,
//       required this.policyID,
//       required this.policyNo,
//       required this.issuedDate,
//       required this.commissionId,
//       required this.companyName,
//       required this.commissionType

//       // required this.headUserid,
//       });

//   Map<String, dynamic> toMap() {
//     return {
//       "policy_id": policyID,
//       "name": name,
//       "commission_date": commissionDate,
//       "policy_no": policyNo,
//       "issued_date": issuedDate,
//       "isPending": isPending,
//       "premium_amt": premiumAmt,
//       "commission_amt": commissionAmt,
//       "commission_id": commissionId,
//       "company_name": companyName,
//       "commission_type": commissionType,
//     };
//   }

//   factory CommissionModel.fromFirestore(DocumentSnapshot doc) {
//     dynamic map = doc.data();

//     return CommissionModel(
//       name: map['name'],
//       policyID: map['policy_id'],
//       issuedDate: map['issued_date'],
//       policyNo: map['policy_no'],
//       isPending: map['isPending'],
//       premiumAmt: map['premium_amt'],
//       commissionDate: map['commission_date'],
//       commissionAmt: map['commission_amt'],
//       companyName: map['company_name'],
//       commissionId: map['commission_id'],
//       commissionType: map['commission_type'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CommissionModel.fromJson(String source) =>
//       CommissionModel.fromFirestore(json.decode(source));
// }
