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
      name: map['name'] ?? "NA",
      planCount: map['plans_count'] ?? 4,
      companyID: map['company_id'] ?? "NA",
      timestamp: map['timestamp'] ?? DateTime.now(),
      companyImg: map['logo'] ??
          "https://imgv2-1-f.scribdassets.com/img/document/473344411/original/ead1f8a603/1688887694?v=1",
      companyType: map['company_type'] ?? "NA",

      // address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromFirestore(json.decode(source));
}
