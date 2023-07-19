// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String name;
//   String address;
//   String phone;
//   String email;
//   // String relation;
//   bool isMale;
//   Timestamp dob;
//   String userid;
//   int membersCount;
//   // String headUserid;

//   UserModel(
//       {required this.name,
//       required this.address,
//       required this.phone,
//       required this.email,
//       // required this.relation,
//       required this.userid,
//       required this.isMale,
//       required this.dob,
//       required this.membersCount
//       // required this.headUserid
//       });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'dob': dob,
//       'phone': phone,
//       'email': email,
//       'isMale': isMale,
//       // 'relation': relation,
//       'address': address,
//       'userid': userid,
//       'members_count': membersCount
//       // 'head_userid': headUserid,
//     };
//   }

//   factory UserModel.fromFirestore(DocumentSnapshot doc) {
//     dynamic map = doc.data();

//     return UserModel(
//         name: map['name'],
//         phone: map['phone'],
//         email: map['email'],
//         address: map['address'],
//         userid: map['userid'],
//         isMale: map['isMale'],
//         dob: map['dob'],
//         membersCount: map['members_count']
//         // relation: map['relation'],
//         // headUserid: map['head_userid'],
//         );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromFirestore(json.decode(source));
// }
