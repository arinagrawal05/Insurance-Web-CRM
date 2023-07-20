import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_model/models/user_model.dart';
import 'package:health_model/shared/enum_utils.dart';

import '../hive/hive_model/user_hive_model.dart';

class AppConsts {
  static String health = "Health";
  static String fd = "FD";
  static UserHiveModel userModel = UserHiveModel(
    name: "Arin Agrawal",
    address: "Choubey Colony",
    phone: "7898291900",
    email: "arinagrawal07128@gmailcom",
    userid: "06885b49-8870-40df-a27a-46326b409a10",
    isMale: true,
    dob: DateTime.now(),
    membersCount: 3,
  );

  static List<String> healthPolicyStatusList = [
    "all status",
    "active",
    "ported",
    "lapsed",
  ];
  static List<String> fDStatusList = [
    "all status",
    "applied",
    "claimed",
    "released",
  ];

  static List<String> getStatusList(ProductType type) {
    if (type == ProductType.health) {
      return healthPolicyStatusList;
    } else {
      return fDStatusList;
    }
  }
}
