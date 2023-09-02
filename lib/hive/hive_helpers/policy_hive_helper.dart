import 'package:health_model/hive/hive_model/policy_models/generic_investment_data.dart';
import 'package:health_model/hive/hive_model/policy_models/motor_model.dart';
import 'package:health_model/shared/exports.dart';

class PolicyHiveHelper {
  static const String _policyBoxName = 'policyBox';
  static const String _fDBoxName = 'fDBox';
  static const String _lifeBoxName = 'lifeBox';
  static const String _motorBoxName = 'motorBox';

  static late Box<PolicyDataHiveModel> policyBox;
  static late Box<PolicyDataHiveModel> fDBox;
  static late Box<PolicyDataHiveModel> lifeBox;
  static late Box<PolicyDataHiveModel> motorBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    Hive.registerAdapter(PolicyDataHiveModelAdapter());
    Hive.registerAdapter(GenericInvestmentHiveDataAdapter());
    Hive.registerAdapter(PolicyHiveModelAdapter());
    Hive.registerAdapter(FdHiveModelAdapter());
    Hive.registerAdapter(LifeHiveModelAdapter());
    Hive.registerAdapter(MotorHiveModelAdapter());

    policyBox = await Hive.openBox<PolicyDataHiveModel>(_policyBoxName);
    fDBox = await Hive.openBox<PolicyDataHiveModel>(_fDBoxName);
    lifeBox = await Hive.openBox<PolicyDataHiveModel>(_lifeBoxName);
    motorBox = await Hive.openBox<PolicyDataHiveModel>(_motorBoxName);

    Get.put(
        GeneralStatsProvider(
          type: ProductType.health,
        ),
        tag: 'statsFor${ProductType.health.name}');
    Get.put(
        GeneralStatsProvider(
          type: ProductType.fd,
        ),
        tag: 'statsFor${ProductType.fd.name}');
    Get.put(
        GeneralStatsProvider(
          type: ProductType.life,
        ),
        tag: 'statsFor${ProductType.life.name}');
    Get.put(
        GeneralStatsProvider(
          type: ProductType.motor,
        ),
        tag: 'statsFor${ProductType.motor.name}');
    fetchPoliciesFromFirebase();
  }

  static Future<void> fetchPoliciesFromFirebase() async {
    fetchFDPoliciesFromFirebase();
    fetchHealthPoliciesFromFirebase();
    fetchLifePoliciesFromFirebase();
    fetchMotorPoliciesFromFirebase();

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  static Future<void> fetchMotorPoliciesFromFirebase() async {
    final motorCollection = FirebaseFirestore.instance
        .collection('Policies')
        .where("type", isEqualTo: "Motor")
        .orderBy("renewal_date");

    motorCollection.get().then((snapshot) async {
      // print("LLLLL Firebase data policy ${snapshot.docs.length}");
      await motorBox.clear(); // Clear existing data before adding new users
      print('Policy Hive cleared');
      for (var doc in snapshot.docs) {
        // print('Adding before');
        // print(doc.id);
        final life = PolicyDataHiveModel.fromFirestore(doc);
        // userBox.add(user);
        if (life.data != null) {
          // policyBox.put(doc.id, policy);
          motorBox.add(life);
          // PolicyHiveModel kk = life.data as PolicyHiveModel;
          // print(
          //     "LLLLL Adding data policy in hive ${kk.name} ${kk.renewalDate}");

          // print('Adding ${policy.data!.name}');
        }
      }
      try {
        PolicySearchController searchController =
            Get.find<PolicySearchController>(tag: ProductType.motor.name);
        if (searchController.initialized) {
          searchController.reset();
        }
      } catch (e) {
        print('Error caught by handler $e');
      }
    });

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  static Future<void> fetchLifePoliciesFromFirebase() async {
    final lifeCollection = FirebaseFirestore.instance
        .collection('Policies')
        .where("type", isEqualTo: "Life")
        .orderBy("renewal_date");

    lifeCollection.get().then((snapshot) async {
      // print("LLLLL Firebase data policy ${snapshot.docs.length}");
      await lifeBox.clear(); // Clear existing data before adding new users
      print('Policy Hive cleared');
      for (var doc in snapshot.docs) {
        // print('Adding before');
        // print(doc.id);
        final life = PolicyDataHiveModel.fromFirestore(doc);
        // userBox.add(user);
        if (life.data != null) {
          // policyBox.put(doc.id, policy);
          lifeBox.add(life);
          // PolicyHiveModel kk = life.data as PolicyHiveModel;
          // print(
          //     "LLLLL Adding data policy in hive ${kk.name} ${kk.renewalDate}");

          // print('Adding ${policy.data!.name}');
        }
      }
      try {
        PolicySearchController searchController =
            Get.find<PolicySearchController>(tag: ProductType.life.name);
        if (searchController.initialized) {
          searchController.reset();
        }
      } catch (e) {
        print('Error caught by handler $e');
      }
    });

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  static Future<void> fetchHealthPoliciesFromFirebase() async {
    final policiesCollection = FirebaseFirestore.instance
        .collection('Policies')
        .where("type", isEqualTo: "Health")
        .orderBy("renewal_date");

    policiesCollection.get().then((snapshot) async {
      // print("LLLLL Firebase data policy ${snapshot.docs.length}");
      await policyBox.clear(); // Clear existing data before adding new users
      print('Policy Hive cleared');
      for (var doc in snapshot.docs) {
        // print('Adding before');
        // print(doc.id);
        final health = PolicyDataHiveModel.fromFirestore(doc);
        // userBox.add(user);
        if (health.data != null) {
          // policyBox.put(doc.id, policy);
          policyBox.add(health);
          // PolicyHiveModel kk = policy.data as PolicyHiveModel;
          // print(
          //     "LLLLL Adding data policy in hive ${kk.name} ${kk.renewalDate}");

          // print('Adding ${policy.data!.name}');
        }
      }
      try {
        PolicySearchController searchController =
            Get.find<PolicySearchController>(tag: ProductType.health.name);
        if (searchController.initialized) {
          searchController.reset();
        }
      } catch (e) {
        print('Error caught by handler $e');
      }
    });

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  static Future<void> fetchFDPoliciesFromFirebase() async {
    final fDCollection = FirebaseFirestore.instance
        .collection('Policies')
        .where("type", isEqualTo: "FD")
        .orderBy("maturity_date");
    print("LLLLL alert Firebase data FD");

    fDCollection.get().then((snapshot) async {
      await fDBox.clear(); // Clear existing data before adding new users
      print('Policy Hive cleared');
      for (var doc in snapshot.docs) {
        // print('Adding before');
        // print(doc.id);
        final fd = PolicyDataHiveModel.fromFirestore(doc);
        // userBox.add(user);
        if (fd.data != null) {
          fDBox.add(fd);
          // print('Adding ${policy.data!.name}');
          // FdHiveModel kk = policy.data as FdHiveModel;
          // print(
          //     "LLLLL Adding data fd in hive ${kk.name} ${kk.maturityDate} ${kk.fDterm}");
        }
      }

      try {
        PolicySearchController searchController =
            Get.find<PolicySearchController>(tag: ProductType.fd.name);
        if (searchController.initialized) {
          searchController.reset();
        }
      } catch (e) {
        print('Error caught by handler $e');
      }

      // print("LLLLL Hive data FD ${fDBox.length}");
    });

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  static List<PolicyDataHiveModel> getPolicyByUser({required String userId}) {
    List<PolicyDataHiveModel>? healthPolicies;

    healthPolicies = policyBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }

      if (policy.data!.userid == userId) {
        return true;
      }

      return false;
    }).toList();

    List<PolicyDataHiveModel>? fdPolicies;

    fdPolicies = fDBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }

      if (policy.data!.userid == userId) {
        return true;
      }

      return false;
    }).toList();
    List<PolicyDataHiveModel>? lifePolicies;

    lifePolicies = lifeBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }

      if (policy.data!.userid == userId) {
        return true;
      }

      return false;
    }).toList();
    List<PolicyDataHiveModel>? motorPolicies;

    motorPolicies = motorBox.values.where((policy) {
      if (policy.data == null) {
        return false;
      }

      if (policy.data!.userid == userId) {
        return true;
      }

      return false;
    }).toList();

    healthPolicies.addAll(fdPolicies);
    healthPolicies.addAll(lifePolicies);
    healthPolicies.addAll(motorPolicies);

    return healthPolicies;
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
                .isAfter(DateTime.now().subtract(const Duration(days: 30)))) {
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
            data.renewalDate
                .isBefore(DateTime.now().add(const Duration(days: 30)))) {
          return true;
        }
      }

      return false;
    }).toList();

    return policies;
  }

  static List<PolicyDataHiveModel> getMaturatedFDs() {
    List<PolicyDataHiveModel>? policies;

    policies = fDBox.values.where((fd) {
      if (fd.data == null) {
        return false;
      }
      if (fd.data is FdHiveModel) {
        FdHiveModel data = fd.data as FdHiveModel;
        if (data.maturityDate.isBefore(DateTime.now()) &&
            data.maturityDate
                .isAfter(DateTime.now().subtract(const Duration(days: 30)))) {
          return true;
        }
      }

      return false;
    }).toList();

    return policies;
  }

  static List<PolicyDataHiveModel> getUpcomingFds() {
    List<PolicyDataHiveModel>? policies;

    policies = fDBox.values.where((fd) {
      if (fd.data == null) {
        return false;
      }
      if (fd.data is FdHiveModel) {
        FdHiveModel data = fd.data as FdHiveModel;
        if (data.maturityDate.isAfter(DateTime.now()) &&
            data.maturityDate
                .isBefore(DateTime.now().add(const Duration(days: 30)))) {
          return true;
        }
      }

      return false;
    }).toList();

    return policies;
  }

  static List<PolicyDataHiveModel> getGracedLifes() {
    List<PolicyDataHiveModel>? policies;

    policies = lifeBox.values.where((life) {
      if (life.data == null) {
        return false;
      }
      if (life.data is LifeHiveModel) {
        LifeHiveModel data = life.data as LifeHiveModel;
        if (data.renewalDate.isBefore(DateTime.now()) &&
            data.renewalDate
                .isAfter(DateTime.now().subtract(const Duration(days: 180)))) {
          return true;
        }
      }

      return false;
    }).toList();

    return policies;
  }

  static List<PolicyDataHiveModel> getUpcomingLifes() {
    List<PolicyDataHiveModel>? policies;

    policies = lifeBox.values.where((life) {
      if (life.data == null) {
        return false;
      }
      if (life.data is LifeHiveModel) {
        LifeHiveModel data = life.data as LifeHiveModel;
        if (data.renewalDate.isAfter(DateTime.now()) &&
            data.renewalDate
                .isBefore(DateTime.now().add(const Duration(days: 30)))) {
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

    // updatePolicyInSearhController();
  }

  static void updatePolicyInSearchController() {
    ProductType type = Get.find<DashProvider>().currentDashBoard;
    Get.find()<PolicySearchController>(tag: type.name).filterpolicies();
  }

  static void deleteSpecificPolicy({required String documentID}) {
    policyBox.delete(documentID);
    updatePolicyInSearchController();

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
