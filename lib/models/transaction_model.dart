import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TansactionModel {
  String transactionId;
  String policyID;
  String type;
  String userid;
  String policyNo;
  String companyName;
  int premuimAmt;
  int membersCount;
  int terms;
  Timestamp beginsDate;
  Timestamp timestamp;

  TansactionModel({
    required this.transactionId,
    required this.policyID,
    required this.policyNo,
    required this.timestamp,
    required this.membersCount,
    required this.userid,
    required this.premuimAmt,
    required this.beginsDate,
    required this.companyName,
    required this.terms,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "transaction_id": transactionId,
      "userid": userid,
      "premium_amt": premuimAmt,
      "begins_date": beginsDate,
      "policy_id": policyID,
      "policy_no": policyNo,
      "company_name": companyName,
      "terms": terms,
      "members_count": membersCount,
      "timestamp": timestamp,
      "type": type,
    };
  }

  factory TansactionModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return TansactionModel(
      transactionId: map['transaction_id'] ?? "NA",
      userid: map['userid'] ?? "NA",
      premuimAmt: map['premium_amt'] ?? 0,
      beginsDate: map['begins_date'] ?? Timestamp.now(),
      policyID: map['policy_id'] ?? "NA",
      policyNo: map['policy_no'] ?? "NA",
      companyName: map['company_name'] ?? "NA",
      terms: map['terms'] ?? 0,
      membersCount: map['members_count'] ?? 0,
      timestamp: map['timestamp'] ?? Timestamp.now(),
      type: map['type'] ?? "Generic",

      // address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TansactionModel.fromJson(String source) =>
      TansactionModel.fromFirestore(json.decode(source));
}
