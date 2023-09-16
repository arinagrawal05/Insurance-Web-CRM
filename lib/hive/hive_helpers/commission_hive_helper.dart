import '/shared/exports.dart';

class CommissionHiveHelper {
  static const String _healthCommissionBoxName = 'healthCommissionBox';
  static const String _fDcommissionBoxName = 'fdCommissionBox';
  static const String _lifecommissionBoxName = 'lifeCommissionBox';
  static const String _motorcommissionBoxName = 'motorCommissionBox';

  static late Box<CommissionHiveModel> healthCommissionBox;
  static late Box<CommissionHiveModel> fDCommissionBox;
  static late Box<CommissionHiveModel> lifeCommissionBox;
  static late Box<CommissionHiveModel> motorCommissionBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    Hive.registerAdapter(CommissionHiveModelAdapter());
    healthCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_healthCommissionBoxName);
    fDCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_fDcommissionBoxName);
    lifeCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_lifecommissionBoxName);
    motorCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_motorcommissionBoxName);

    fetchCommissionsFromFirebase();
  }

  static Future<void> fetchCommissionsFromFirebase() async {
    print("my commission count 1");

    // fetchHealthCommissionFromFirebase();
    print("my commission count 2");

    final commissionsCollection = FirebaseFirestore.instance
        .collection('Commission')
        // .where("type", isEqualTo: "Health")
        .orderBy("commission_date")
        .get();

    commissionsCollection.then((snapshot) async {
      await healthCommissionBox.clear();
      await fDCommissionBox.clear();
      await lifeCommissionBox.clear();
      await motorCommissionBox.clear();

      for (var doc in snapshot.docs) {
        final commission = CommissionHiveModel.fromFirestore(doc);

        if (doc.data()['commission_type'] == 'Health') {
          healthCommissionBox.add(commission);
        } else if (doc.data()['commission_type'] == 'Life') {
          lifeCommissionBox.add(commission);
        } else if (doc.data()['commission_type'] == 'Motor') {
          motorCommissionBox.add(commission);
        } else if (doc.data()['commission_type'] == 'FD') {
          fDCommissionBox.add(commission);
        }
        // try {
        //   CommissionSearchController commissionController =
        //       Get.find<CommissionSearchController>(tag: ProductType.life.name);
        //   if (commissionController.initialized) {
        //     commissionController.reset();
        //   }
        // } catch (e) {
        //   print('Error caught by handler $e');
        // }

        // print('Adding before');
        // print(doc.id);
        // userBox.add(user);
        // print(
        //     "Commision adding ${commission.name} ${commission.commissionType}");
      }
    });

    // FDcommissionsCollection.then((snapshot) async {
    //   await fDCommissionBox
    //       .clear(); // Clear existing data before adding new users
    //   print('Hive cleared');
    //   for (var doc in snapshot.docs) {
    //     // print('Adding before');
    //     // print(doc.id);
    //     final commission = CommissionHiveModel.fromFirestore(doc);
    //     // userBox.add(user);
    //     fDCommissionBox.add(commission);
    //   }
    // });

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  static Future<void> fetchHealthCommissionFromFirebase() async {
    final healthCollection = FirebaseFirestore.instance
        .collection('Commission')
        // .where("type", isEqualTo: "Health");
        .orderBy("commission_date");
//  FirebaseFirestore.instance.collection("collectionPath").doc("").update({data})
    healthCollection.get().then((snapshot) async {
      // print("LLLLL Firebase data policy ${snapshot.docs.length}");
      await healthCommissionBox
          .clear(); // Clear existing data before adding new users
      print('Commission Hive cleared' + snapshot.docs.length.toString());
      for (var doc in snapshot.docs) {
        // print('Adding before');
        // print(doc.id);
        final commission = CommissionHiveModel.fromFirestore(doc);
        // userBox.add(user);
        if (commission != null) {
          // policyBox.put(doc.id, policy);
          healthCommissionBox.add(commission);
          // PolicyHiveModel kk = life.data as PolicyHiveModel;
          // print(
          //     "LLLLL Adding data policy in hive ${kk.name} ${kk.renewalDate}");

          // print('Adding ${policy.data!.name}');
        }
        print("my commission " + commission.name);
      }
      print("my commission count 30 is");

      try {
        CommissionSearchController commissionController =
            Get.find<CommissionSearchController>(tag: ProductType.health.name);
        if (commissionController.initialized) {
          commissionController.reset();
        }
      } catch (e) {
        print('Error caught by handler $e');
      }
    });
    print("my commission count 31");

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  }

  // static void printAllCommissions() {
  //   // final userBox = Hive.box<UserHiveModel>(_userBoxName);
  //   for (var i = 0; i < commissionBox.length; i++) {
  //     final user = commissionBox.getAt(i);
  //     print('User ${i + 1}:');
  //     print('Name: ${user!.name}');
  //     // print('Address: ${user.address}');
  //     // print('Phone: ${user.phone}');
  //     // print('Email: ${user.email}');
  //     // print('Is Male: ${user.isMale}');
  //     // print('Date of Birth: ${user.dob}');
  //     // print('UserID: ${user.userid}');
  //     // print('Members Count: ${user.membersCount}');
  //     // print('------------------------');
  //   }
  // }

  static Future<void> updateSpecifiCommission(
      {required String documentID, required String type}) async {
    final commissionCollection =
        FirebaseFirestore.instance.collection('Commission');
    final snapshot = await commissionCollection.doc(documentID).get();

    print('updateSpecificCommission called for $documentID');

    final commission = CommissionHiveModel.fromFirestore(snapshot);
    // lifeCommissionBox.add(commission);
    if (type == "Health") {
      healthCommissionBox.put(documentID, commission);
    } else if (type == "Life") {
      lifeCommissionBox.put(documentID, commission);
      print("object happened");
    } else if (type == "FD") {
      fDCommissionBox.put(documentID, commission);
    } else if (type == "Motor") {
      motorCommissionBox.put(documentID, commission);
    }
  }

  static void deleteSpecificCommission({required String documentID}) {
    // commissionBox.delete(documentID);
    // print('Adding ${policy.data!.name}');
  }

  static Future<void> deleteAllCommissionData() async {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await healthCommissionBox.clear();
    await fDCommissionBox.clear();
    await lifeCommissionBox.clear();
    await motorCommissionBox.clear();
  }
}
