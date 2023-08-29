import 'package:health_model/shared/exports.dart';

class CommissionHiveHelper {
  static const String _healthCommissionBoxName = 'healthCommissionBox';
  static const String _fDcommissionBoxName = 'fdCommissionBox';
  static const String _lifecommissionBoxName = 'lifeCommissionBox';

  static late Box<CommissionHiveModel> healthCommissionBox;
  static late Box<CommissionHiveModel> fDCommissionBox;
  static late Box<CommissionHiveModel> lifeCommissionBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    Hive.registerAdapter(CommissionHiveModelAdapter());
    healthCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_healthCommissionBoxName);
    fDCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_fDcommissionBoxName);
    lifeCommissionBox =
        await Hive.openBox<CommissionHiveModel>(_lifecommissionBoxName);

    fetchCommissionsFromFirebase();
  }

  static Future<void> fetchCommissionsFromFirebase() async {
    final commissionsCollection = FirebaseFirestore.instance
        .collection('Commission')
        // .where("type", isEqualTo: "Health")
        .orderBy("commission_date")
        .get();

    // final FDcommissionsCollection = FirebaseFirestore.instance
    //     .collection('Commission')
    //     .where("type", isEqualTo: "FD")
    //     .orderBy("commission_date")
    //     .get();

    commissionsCollection.then((snapshot) async {
      await healthCommissionBox
          .clear(); // Clear existing data before adding new users
      // print('health commision snapshot ${snapshot.docs.length}');
      for (var doc in snapshot.docs) {
        final commission = CommissionHiveModel.fromFirestore(doc);

        if (doc.data()['commission_type'] == 'Health') {
          healthCommissionBox.add(commission);
        } else if (doc.data()['commission_type'] == 'Life') {
          lifeCommissionBox.add(commission);
        } else if (doc.data()['commission_type'] == 'FD') {
          fDCommissionBox.add(commission);
        }
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
      {required String documentID}) async {
    // final commissionCollection =
    //     FirebaseFirestore.instance.collection('Commission');
    // final snapshot = await commissionCollection.doc(documentID).get();

    // print('updateSpecificCommission called for $documentID');

    // // final userBox = Hive.box<UserHiveModel>(_userBoxName);

    // final commission = CommissionHiveModel.fromFirestore(snapshot);
    // // userBox.add(user);
    // if (commission != null) {
    //   commissionBox.put(documentID, commission);
    //   // print('Adding ${policy.data!.name}');
    // }
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
  }
}
