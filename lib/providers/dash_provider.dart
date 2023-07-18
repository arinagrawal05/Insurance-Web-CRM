import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_model/models/commission_model.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/models/user_model.dart';

class DashProvider extends ChangeNotifier {
  int dashHealthIndex = 0;
  int dashFDIndex = 0;
  String dashName = "Home";

  TextEditingController userController = TextEditingController();
  TextEditingController commissionController = TextEditingController();
  TextEditingController policyController = TextEditingController();

  void changeDashName(
    String name,
  ) {
    dashName = name;
    notifyListeners();
  }

  void changeHealthDash(
    int currentIndex,
  ) {
    dashHealthIndex = currentIndex;
    notifyListeners();
  }

  void changeFDDash(
    int currentIndex,
  ) {
    dashFDIndex = currentIndex;
    notifyListeners();
  }

  List<UserModel> userModelList = [];
  List<UserModel> userSearchList = [];
  resetUserList() {
    userSearchList = userModelList;
  }

  searchUser(String query) {
    if (query != "") {
      resetUserList();
    }
    print(query);
    userSearchList = [];
    userModelList.forEach((element) {
      if (element.name.toLowerCase().contains(query.toLowerCase())) {
        userSearchList.add(element);
        // print("Selected");
      }
    });

    notifyListeners();
  }

  void getAllUsers() async {
    userModelList = [];
    FirebaseFirestore.instance.collection("Users").snapshots().listen((event) {
      for (var i = 0; i < event.docs.length; i++) {
        userModelList.add(UserModel.fromFirestore(event.docs[i]));
      }
    });

    // print("Got All Users");
  }

  List<PolicyData> policyModelList = [];
  List<PolicyData> policySearchList = [];
  void getAllPolicies(String type) async {
    policyModelList.clear();
    policySearchList.clear();
    FirebaseFirestore.instance
        .collection("Policies")
        .where("type", isEqualTo: type)
        // .orderBy("renewal_date")
        .snapshots()
        .listen((event) {
      for (var i = 0; i < event.docs.length; i++) {
        String type = event.docs[i].data()['type'];
        if (type == 'FD') {
          print('--------------------FD---------------');
        }
        policyModelList.add(PolicyData.fromFirestore(event.docs[i]));
      }
    });

    print("Got All Policies");
  }

  resetPolicyList() {
    policySearchList = policyModelList;
  }

  searchPolicy(String query) {
    if (query != "") {
      resetUserList();
    }
    print(query);
    policySearchList = [];
    policyModelList.forEach((element) {
      if (element.data.name.toLowerCase().contains(query.toLowerCase())) {
        policySearchList.add(element);
        // print("Selected");
      }
    });

    notifyListeners();
  }

  List<CommissionModel> commissionModelList = [];
  List<CommissionModel> commissionSearchList = [];
  void getAllCommissions(String type) async {
    commissionModelList.clear();
    commissionSearchList.clear();
    FirebaseFirestore.instance
        .collection("Commission")
        .where("commission_type", isEqualTo: type)
        .orderBy("commission_date")
        .snapshots()
        .listen((event) {
      for (var i = 0; i < event.docs.length; i++) {
        commissionModelList.add(CommissionModel.fromFirestore(event.docs[i]));
      }
    });

    print("Got All Commissions");
  }

  resetCommissionList() {
    commissionSearchList = commissionModelList;
  }

  searchCommission(String query) {
    if (query != "") {
      resetCommissionList();
    }
    print(query);
    commissionSearchList = [];
    commissionModelList.forEach((element) {
      if (element.name.toLowerCase().contains(query.toLowerCase())) {
        commissionSearchList.add(element);
        // print("Selected");
      }
    });

    notifyListeners();
  }
}
