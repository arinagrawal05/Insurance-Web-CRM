import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:health_model/hive/hive_helpers/commission_hive_helper.dart';
import 'package:health_model/hive/hive_model/commission_models/commission_hive_model.dart';
import 'package:health_model/shared/enum_utils.dart';
import 'package:health_model/shared/exports.dart';
import 'package:hive/hive.dart';

import '../shared/functions.dart';

class CommissionSearchController extends GetxController {
  List<CommissionHiveModel> commissions = <CommissionHiveModel>[];
  Box<CommissionHiveModel>? commissionBox;
  TextEditingController searchController = TextEditingController();
  final ProductType type;

  int currentSum = 0;

  CommissionSearchController({required this.type});
  String companyFilter = 'All Companies';
// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user CommissionSearchController init called');
    commissionBox = CommissionHiveHelper.commissionBox;
    commissions.addAll(commissionBox!.values.toList());
    getCompanies();
    super.onInit();
  }

  void filterCommissions() {
    String query = searchController.text;

    print(query);
    commissions.clear();
    currentSum = 0;
    commissions = commissionBox!.values.where((commission) {
      if (commission.name.toLowerCase().contains(query.toLowerCase())) {
        if (companyFilter == 'All Companies' ||
            companyFilter == commission.companyName) {
          currentSum += commission.commissionAmt;
          return true;
        }
      }

      return false;
    }).toList();
    update();
  }

  void changeCompany(String newCompany) {
    companyFilter = newCompany;
    filterCommissions();
  }

  List<String> companyList = [
    "All Companies",
  ];

  void getCompanies() {
    companyList = [
      "All Companies",
    ];
    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: EnumUtils().convertTypeToKey(type))
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          companyList.add(AppUtils.getFirstWord(value.docs[i]["name"]));
          print("Added ${AppUtils.getFirstWord(value.docs[i]["name"])}");
        }
      }
    });
    update();
  }
}
