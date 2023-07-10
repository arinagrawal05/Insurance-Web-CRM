import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  int planCount;
  String companyID;
  String name;
  String companyImg;
  String companyType;

  Timestamp timestamp;

  CompanyModel({
    required this.name,
    required this.companyID,
    required this.planCount,
    required this.timestamp,
    required this.companyImg,
    required this.companyType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plans_count': planCount,
      'company_id': companyID,
      'timestamp': timestamp,
      "logo": companyImg,
      "company_type": companyType,
    };
  }

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return CompanyModel(
      name: map['name'],
      planCount: map['plans_count'],
      companyID: map['company_id'],
      timestamp: map['timestamp'],
      companyImg: map['logo'],
      companyType: map['company_type'],

      // address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromFirestore(json.decode(source));
}
