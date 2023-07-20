import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_model/hive/hive_model/policy_models/fd_model.dart';
import 'package:health_model/hive/hive_model/policy_models/generic_investment_data.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_data_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_model/user_hive_model.dart';

class PolicyHiveHelper {
  static const String _policyBoxName = 'policyBox';
  static late Box<PolicyDataHiveModel> policyBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    Hive.registerAdapter(PolicyDataHiveModelAdapter());
    Hive.registerAdapter(GenericInvestmentHiveDataAdapter());
    Hive.registerAdapter(PolicyHiveModelAdapter());
    Hive.registerAdapter(FdHiveModelAdapter());

    policyBox = await Hive.openBox<PolicyDataHiveModel>(_policyBoxName);
    fetchPoliciesFromFirebase();
  }

  static Future<void> fetchPoliciesFromFirebase() async {
    final policiesCollection =
        FirebaseFirestore.instance.collection('Policies');
    final snapshot = await policiesCollection.get();

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await policyBox.clear(); // Clear existing data before adding new users
    print('Policy Hive cleared');
    for (var doc in snapshot.docs) {
      // print('Adding before');
      // print(doc.id);
      final policy = PolicyDataHiveModel.fromFirestore(doc);
      // userBox.add(user);
      if (policy.data != null) {
        policyBox.put(doc.id, policy);
        // print('Adding ${policy.data!.name}');
      }
    }
  }

  static void printAllUsers() {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    for (var i = 0; i < policyBox.length; i++) {
      final user = policyBox.getAt(i);
      print('User ${i + 1}:');
      print('Name: ${user!.data!.name}');
      // print('Address: ${user.address}');
      // print('Phone: ${user.phone}');
      // print('Email: ${user.email}');
      // print('Is Male: ${user.isMale}');
      // print('Date of Birth: ${user.dob}');
      // print('UserID: ${user.userid}');
      print('Members Count: ${user.data!.address}');
      // print('------------------------');
    }
  }

  static Future<void> deleteAllPolicyData() async {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await policyBox.clear();
  }
}
