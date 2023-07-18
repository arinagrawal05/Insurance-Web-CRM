import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_model/user_hive_model.dart';

class UserHiveHelper {
  static const String _userBoxName = 'userBox';
  static late Box<UserHiveModel> userBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    await Hive.initFlutter();
    Hive.registerAdapter(UserHiveModelAdapter());
    userBox = await Hive.openBox<UserHiveModel>(_userBoxName);
  }

  static Future<void> fetchUsersFromFirebase() async {
    final usersCollection = FirebaseFirestore.instance.collection('Users');
    final snapshot = await usersCollection.get();

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await userBox.clear(); // Clear existing data before adding new users
    print('Hive cleared');
    for (var doc in snapshot.docs) {
      // print('Adding before');
      // print(doc.id);
      final user = UserHiveModel.fromFirestore(doc);
      // userBox.add(user);
      userBox.put(doc.id, user);
      print('Adding ${user.name}');
    }
  }

  static void printAllUsers() {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    for (var i = 0; i < userBox.length; i++) {
      final user = userBox.getAt(i);
      print('User ${i + 1}:');
      print('Name: ${user!.name}');
      // print('Address: ${user.address}');
      // print('Phone: ${user.phone}');
      // print('Email: ${user.email}');
      // print('Is Male: ${user.isMale}');
      // print('Date of Birth: ${user.dob}');
      // print('UserID: ${user.userid}');
      // print('Members Count: ${user.membersCount}');
      // print('------------------------');
    }
  }

  static Future<void> deleteAllUserData() async {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await userBox.clear();
  }
}
