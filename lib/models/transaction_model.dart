import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TansactionModel {
  String transactionId;
  String policyID;

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
    };
  }

  factory TansactionModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return TansactionModel(
      transactionId: map['transaction_id'],
      userid: map['userid'],
      premuimAmt: map['premium_amt'],
      beginsDate: map['begins_date'],
      policyID: map['policy_id'],
      policyNo: map['policy_no'],
      companyName: map['company_name'],
      terms: map['terms'],
      membersCount: map['members_count'],
      timestamp: map['timestamp'],

      // address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TansactionModel.fromJson(String source) =>
      TansactionModel.fromFirestore(json.decode(source));
}
