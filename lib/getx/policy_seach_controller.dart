import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/hive/hive_model/commission_models/commission_hive_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_data_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/shared/enum_utils.dart';
import 'package:health_model/shared/exports.dart';
import 'package:hive/hive.dart';

import '../hive/hive_model/policy_models/generic_investment_data.dart';
import '../shared/functions.dart';

class PolicySearchController extends GetxController {
  List<PolicyDataHiveModel> policies = <PolicyDataHiveModel>[];
  Box<PolicyDataHiveModel>? policyBox;
  TextEditingController searchController = TextEditingController();
  final ProductType type;

  PolicySearchController({required this.type});
  String companyFilter = 'All Companies';
  HealthStatus healthStatusFilter = HealthStatus.active;
  FDStatus fDStatusFilter = FDStatus.applied;

// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user PolicySearchController init called $type');
    policyBox = PolicyHiveHelper.policyBox;
    policies.addAll(policyBox!.values.toList());
    filterpolicies();
    getCompanies();
    super.onInit();
  }

  void filterpolicies() {
    String query = searchController.text;

    print(query);
    policies.clear();
    policies = policyBox!.values.where((commission) {
      if (commission.data == null) {
        return false;
      }
      // print(' case 1 ${commission.data!.name} ${commission.data!.type} $type');

      if (!((type == ProductType.health &&
              commission.data is PolicyHiveModel) ||
          (type == ProductType.fd && commission.data is FdHiveModel))) {
        // print(
        //     ' case 1a ${(type == ProductType.health && commission.data is PolicyHiveModel)} $type');
        // print(
        //     ' case 1b ${(type == ProductType.fd && commission.data is FdHiveModel)} $type');
        return false;
      }
      // print(' case 2 ${commission.data!.name}');

      // if (!(type == ProductType.fd && commission.data is FdModel)) {
      //   return false;
      // }
      // print(' case 3 ${commission.data!.name}');

      if (!(commission.data!.name
          .toLowerCase()
          .contains(query.toLowerCase()))) {
        return false;
      }
      // print(' case 4 ${commission.data!.name}');
      // print(' case 4a ${companyFilter}');
      // print(' case 4b ${commission.data!.companyName}');

      if (!(companyFilter == 'All Companies' ||
          companyFilter == getFirstWord(commission.data!.companyName))) {
        return false;
      }
      // print(' case 5 ${commission.data!.name}');

      if (!checkStatusFilter(commission.data!)) {
        return false;
      }

      // print(' case 6 ${commission.data!.name}');

      return true;
    }).toList();
    update();
  }

  bool checkStatusFilter(GenericInvestmentHiveData data) {
    if (type == ProductType.health) {
      PolicyHiveModel health = data as PolicyHiveModel;
      if (health.policyStatus == healthStatusFilter.name ||
          healthStatusFilter == HealthStatus.allStatus) {
        return true;
      }
    }

    if (type == ProductType.fd) {
      FdHiveModel health = data as FdHiveModel;
      if (health.fdStatus == fDStatusFilter.name ||
          fDStatusFilter == FDStatus.allStatus) {
        return true;
      }
    }
    return false;
  }

  void changeCompany(String newCompany) {
    companyFilter = newCompany;
    filterpolicies();
  }

  void changeStatus({HealthStatus? healthStatus, FDStatus? fdStatus}) {
    if (healthStatus != null) {
      healthStatusFilter = healthStatus;
    }
    if (fdStatus != null) {
      fdStatus = fdStatus;
    }
    filterpolicies();
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

  List<String> get getCurrentStatusList => AppConsts.getStatusList(type);
}
