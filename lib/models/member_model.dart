import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  String name;
  // String address;
  // String phone;
  // String email;
  String relation;
  bool isMale;
  Timestamp dob;
  String userid;
  String headUserid;

  MemberModel(
      {required this.name,
      // required this.address,
      // required this.phone,
      // required this.email,
      required this.relation,
      required this.userid,
      required this.isMale,
      required this.dob,
      required this.headUserid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': dob,
      // 'phone': phone,
      // 'email': email,
      'isMale': isMale,
      'relation': relation,
      // 'address': address,
      'userid': userid,
      'head_userid': headUserid,
    };
  }

  factory MemberModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return MemberModel(
      name: map['name'] ?? "NA",
      // phone: map['phone'],
      // email: map['email'],
      // address: map['address'],
      userid: map['userid'] ?? "NA",
      isMale: map['isMale'] ?? true,
      dob: map['dob'] ?? DateTime.now(),
      relation: map['relation'] ?? "NA",
      headUserid: map['head_userid'] ?? "NA",
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberModel.fromJson(String source) =>
      MemberModel.fromFirestore(json.decode(source));
}
