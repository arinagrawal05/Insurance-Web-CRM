import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_model/models/user_model.dart';

class AppConsts {
  static String health = "Health";
  static String fd = "FD";
  static UserModel userModel = UserModel(
    name: "Arin Agrawal",
    address: "Choubey Colony",
    phone: "7898291900",
    email: "arinagrawal07128@gmailcom",
    userid: "06885b49-8870-40df-a27a-46326b409a10",
    isMale: true,
    dob: Timestamp.now(),
    membersCount: 3,
  );
}
