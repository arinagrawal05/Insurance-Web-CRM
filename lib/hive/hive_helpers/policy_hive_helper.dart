import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_model/hive/hive_model/policy_models/fd_model.dart';
import 'package:health_model/hive/hive_model/policy_models/generic_investment_data.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_data_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:health_model/shared/exports.dart';
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

  static List<PolicyDataHiveModel> getPolicyByUser({required String userId}) {
    List<PolicyDataHiveModel>? policies;

    policies = policyBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }

      if (policy.data!.userid == userId) {
        return true;
      }

      return false;
    }).toList();

    return policies;
  }

  static List<PolicyDataHiveModel> getGracedPolicies() {
    List<PolicyDataHiveModel>? policies;

    policies = policyBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }
      if (policy.data is PolicyHiveModel) {
        PolicyHiveModel data = policy.data as PolicyHiveModel;
        if (data.renewalDate.isBefore(DateTime.now()) &&
            data.renewalDate
                .isAfter(DateTime.now().subtract(Duration(days: 30)))) {
          return true;
        }
      }

      return false;
    }).toList();

    return policies;
  }

  static List<PolicyDataHiveModel> getUpcomingPolicies() {
    List<PolicyDataHiveModel>? policies;

    policies = policyBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }
      if (policy.data is PolicyHiveModel) {
        PolicyHiveModel data = policy.data as PolicyHiveModel;
        if (data.renewalDate.isAfter(DateTime.now()) &&
            data.renewalDate.isBefore(DateTime.now().add(Duration(days: 30)))) {
          return true;
        }
      }

      return false;
    }).toList();

    return policies;
  }

  static Future<void> updateSpecificPolicy({required String documentID}) async {
    final policiesCollection =
        FirebaseFirestore.instance.collection('Policies');
    final snapshot = await policiesCollection.doc(documentID).get();

    print('updateSpecificPolicy called for $documentID');

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);

    final policy = PolicyDataHiveModel.fromFirestore(snapshot);
    // userBox.add(user);
    if (policy.data != null) {
      policyBox.put(documentID, policy);
      // print('Adding ${policy.data!.name}');
    }

    updatePolicyInSearhController();
  }

  static void updatePolicyInSearhController() {
    ProductType type = Get.find<DashProvider>().currentDashBoard;
    Get.find()<PolicySearchController>(tag: type.name).filterpolicies();
  }

  static void deleteSpecificPolicy({required String documentID}) {
    policyBox.delete(documentID);
    updatePolicyInSearhController();

    // print('Adding ${policy.data!.name}');
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
