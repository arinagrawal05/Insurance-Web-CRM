import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_model/hive/hive_model/commission_models/commission_hive_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommissionHiveHelper {
  static const String _commissionBoxName = 'commissionBox';
  static late Box<CommissionHiveModel> commissionBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    Hive.registerAdapter(CommissionHiveModelAdapter());
    commissionBox = await Hive.openBox<CommissionHiveModel>(_commissionBoxName);
    fetchCommissionsFromFirebase();
  }

  static Future<void> fetchCommissionsFromFirebase() async {
    final commissionsCollection =
        FirebaseFirestore.instance.collection('Commission');
    final snapshot = await commissionsCollection.get();

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await commissionBox.clear(); // Clear existing data before adding new users
    print('Hive cleared');
    for (var doc in snapshot.docs) {
      // print('Adding before');
      // print(doc.id);
      final commission = CommissionHiveModel.fromFirestore(doc);
      // userBox.add(user);
      commissionBox.put(doc.id, commission);
    }
  }

  static void printAllCommissions() {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    for (var i = 0; i < commissionBox.length; i++) {
      final user = commissionBox.getAt(i);
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

  static Future<void> updateSpecifiCommission(
      {required String documentID}) async {
    final commissionCollection =
        FirebaseFirestore.instance.collection('Commission');
    final snapshot = await commissionCollection.doc(documentID).get();

    print('updateSpecificCommission called for $documentID');

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);

    final commission = CommissionHiveModel.fromFirestore(snapshot);
    // userBox.add(user);
    if (commission != null) {
      commissionBox.put(documentID, commission);
      // print('Adding ${policy.data!.name}');
    }
  }

  static void deleteSpecificCommission({required String documentID}) {
    commissionBox.delete(documentID);
    // print('Adding ${policy.data!.name}');
  }

  static Future<void> deleteAllCommissionData() async {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await commissionBox.clear();
  }
}
