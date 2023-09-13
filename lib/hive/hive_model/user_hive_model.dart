import 'package:health_model/shared/exports.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 0)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String email;

  @HiveField(4)
  bool isMale;

  @HiveField(5)
  DateTime dob;

  @HiveField(6)
  String userid;

  @HiveField(7)
  int membersCount;

  UserHiveModel({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.isMale,
    required this.dob,
    required this.userid,
    required this.membersCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': dob,
      'phone': phone,
      'email': email,
      'isMale': isMale,
      // 'relation': relation,
      'address': address,
      'userid': userid,
      'members_count': membersCount
      // 'head_userid': headUserid,
    };
  }

  factory UserHiveModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return UserHiveModel(
      name: map['name'] ?? "NA",
      phone: map['phone'] ?? "NA",
      email: map['email'] ?? "NA",
      address: map['address'] ?? "NA",
      userid: map['userid'] ?? "NA",
      isMale: map['isMale'] ?? true,
      dob: map['dob'].toDate() ?? DateTime.now(),
      membersCount: map['members_count'] ?? 1,
      // relation: map['relation'],
      // headUserid: map['head_userid'],
    );
  }
}
