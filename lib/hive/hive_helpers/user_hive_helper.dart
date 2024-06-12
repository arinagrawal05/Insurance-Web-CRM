import 'package:health_model/getx/document_search_controller.dart';
import 'package:health_model/hive/hive_model/doc_hive_model.dart';

import '/shared/exports.dart';

class UserHiveHelper {
  static const String _userBoxName = 'userBox';
  static const String _docBoxName = 'docBox';
  static late Box<UserHiveModel> userBox;
  static late Box<DocHiveModel> docBox;

  static Future<void> init() async {
    print("Hive initialized!!");
    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(DocHiveModelAdapter());
    userBox = await Hive.openBox<UserHiveModel>(_userBoxName);
    docBox = await Hive.openBox<DocHiveModel>(_docBoxName);
    fetchUsersFromFirebase();
    fetchDocFromFirebase();
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
      // print('Adding ${user.name} as a client');
    }
    try {
      UserSearchController searchController = Get.find<UserSearchController>();
      if (searchController.initialized) {
        searchController.reset();
      }
    } catch (e) {
      print('Error caught by handler $e');
    }
  }

  static Future<void> fetchDocFromFirebase() async {
    final docsCollection = FirebaseFirestore.instance.collection('Documents');
    final snapshot = await docsCollection.get();

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await docBox.clear(); // Clear existing data before adding new users
    print('Hive cleared');
    for (var doc in snapshot.docs) {
      // print('Adding before');
      // print(doc.id);
      final user = DocHiveModel.fromFirestore(doc);
      // userBox.add(user);
      docBox.put(doc.id, user);
      // print('Adding ${user.name} as a client');
    }
    try {
      DocumentSearchController searchController =
          Get.find<DocumentSearchController>();
      if (searchController.initialized) {
        searchController.reset();
      }
    } catch (e) {
      print('Error caught by handler $e');
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

  static Future<void> updateSpecifiUser({required String documentID}) async {
    final userCollection = FirebaseFirestore.instance.collection('Users');
    final snapshot = await userCollection.doc(documentID).get();

    print('updateSpecificUser called for $documentID');

    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    final user = UserHiveModel.fromFirestore(snapshot);
    // userBox.add(user);
    if (user != null) {
      userBox.put(documentID, user);
      // print('Adding ${policy.data!.name}');
    }
  }

  static void deleteSpecificUser({required String documentID}) {
    userBox.delete(documentID);
    // print('Adding ${policy.data!.name}');
  }

  static Future<void> deleteAllUserData() async {
    // final userBox = Hive.box<UserHiveModel>(_userBoxName);
    await userBox.clear();
  }

  static List<UserHiveModel> getUserByBirthday() {
    List<UserHiveModel>? birthdayUser;

    birthdayUser = userBox.values.where((user) {
      // if (policy.data == null) {
      //   return false;
      // }

      if (user.dob.day == DateTime.now().day &&
          user.dob.month == DateTime.now().month) {
        return true;
      }

      return false;
    }).toList();

    return birthdayUser;
  }

  static List<DocHiveModel> getDocumentByUser({required String userId}) {
    List<DocHiveModel>? userDocuments;

    userDocuments = docBox.values.where((document) {
      // if (policy.data == null) {
      //   return false;
      // }

      if (document.userId == userId) {
        return true;
      }

      return false;
    }).toList();

    return userDocuments;
  }
}
