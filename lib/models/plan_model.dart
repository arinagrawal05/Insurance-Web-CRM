import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  String planID;
  String companyID;
  String name;
  Timestamp timestamp;
  PlanModel({
    required this.name,
    required this.companyID,
    required this.planID,
    required this.timestamp,

    // required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'plan_name': name,
      'plan_id': planID,
      'company_id': companyID,
      'timestamp': timestamp,
    };
  }

  factory PlanModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return PlanModel(
      name: map['plan_name'],
      planID: map['plan_id'],
      companyID: map['company_id'],
      timestamp: map['timestamp'],

      // address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanModel.fromJson(String source) =>
      PlanModel.fromFirestore(json.decode(source));
}
