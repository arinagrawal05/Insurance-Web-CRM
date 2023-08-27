import 'package:flutter/material.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/hive/hive_model/policy_models/life_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_data_model.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/const.dart';
import 'package:hive/hive.dart';

class ItemLabeling {
  int value1 = 0;
  int value2 = 0;

  int value3 = 0;

  int value4 = 0;

  final String? label1;
  final String? label2;
  final String? label3;
  final String? label4;

  ItemLabeling({this.label1, this.label2, this.label3, this.label4});
}

class GeneralStatsProvider extends GetxController {
  final ProductType type;
  // int users_count = 0;
  // int policies_count = 0;
  ItemLabeling? labels;

  int plans_count = 0;
  int companies_count = 0;
  Box<PolicyDataHiveModel>? policyBox;

  List<CompanyChartData> chartCompanyData = [];
  List<PolicyStatusChartData> policyStatusChartData = [];
  List<PolicyDistributionChartData> policyDistributionChartData = [];

  @override
  onInit() {
    super.onInit();
    print("object GeneralStatsProvider $type init called");
    if (type == ProductType.health) {
      labels = ItemLabeling(
          label1: 'Active', label2: 'Ported', label3: 'lapsed', label4: '_');
    } else if (type == ProductType.life) {
      labels = ItemLabeling(
          label1: 'applied', label2: 'state2', label3: 'state3', label4: '_');
    } else if (type == ProductType.fd) {
      labels = ItemLabeling(
          label1: 'applied',
          label2: 'inHand',
          label3: 'handover',
          label4: 'redeemed');
    }
    Future.delayed(
      Duration(seconds: 2),
      () {
        calculatePolicyStatsFromHive();
      },
    );
    getCompaniesChartData(EnumUtils.convertTypeToKey(type));

    if (type == ProductType.health) {
      policyBox = PolicyHiveHelper.policyBox;
    } else if (type == ProductType.life) {
      policyBox = PolicyHiveHelper.lifeBox;
    } else {
      policyBox = PolicyHiveHelper.fDBox;
    }
  }

  GeneralStatsProvider({required this.type});
  void getCompaniesChartData(companyType) {
    chartCompanyData = [];
    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: companyType)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        companies_count = value.docs.length;
        for (var i = 0; i < value.docs.length; i++) {
          chartCompanyData.add(CompanyChartData(
              AppUtils.getFirstWord(value.docs[i]["name"]),
              value.docs[i]["total_bussiness"]));
          // print(chartData[i].x.toString());
          policyDistributionChartData.add(PolicyDistributionChartData(
              value.docs[i]["name"], value.docs[i]["policy_count"]));
        }
      }
      update();
    });
  }

  void calculatePolicyStatsFromHive() {
    // print("take 00");
    // print("Take 2 ${policyBox!.values.length}");

    if (policyBox == null) {
      print('Policy box is null so returning');
      return;
    }

    // print("Take 21 ${policyBox!.values.length}");

    policyBox!.values.where((policy) {
      // print("take 01");

      if (policy.data == null) {
        // print("take 02");

        return false;
      }
      // print("take 1");
      if (type == ProductType.health) {
        // print("take 2");

        if (policy.data is PolicyHiveModel) {
          PolicyHiveModel data = policy.data as PolicyHiveModel;
          // print("take 2a ${data.policyStatus}");
          switch (data.policyStatus) {
            case 'active':
              labels!.value1 += 1;
            case 'ported':
              labels!.value2 += 1;
            case 'lapsed':
              labels!.value3 += 1;

              break;
            default:
          }
        }
        // print("take 3");
      } else if (type == ProductType.life) {
        // print("take 4");

        if (policy.data is LifeHiveModel) {
          LifeHiveModel data = policy.data as LifeHiveModel;
          switch (data.lifeStatus) {
            case 'applied':
              labels!.value1 += 1;
            case 'state2':
              labels!.value2 += 1;
            case 'state3':
              labels!.value3 += 1;

              break;
            default:
          }
        }
      } else if (type == ProductType.fd) {
        // print("take 4");

        if (policy.data is FdHiveModel) {
          FdHiveModel data = policy.data as FdHiveModel;
          switch (data.fdStatus) {
            case 'applied':
              labels!.value1 += 1;
            case 'inHand':
              labels!.value2 += 1;
            case 'handover':
              labels!.value3 += 1;
            case 'redeemed':
              labels!.value4 += 1;

              break;
            default:
          }
        }
      }
      // print("Stats computed");
      // print('${labels!.label1} ${labels!.value1}');

      // print('${labels!.label2} ${labels!.value2}');
      // print('${labels!.label3} ${labels!.value3}');
      // print('${labels!.label4} ${labels!.value4}');
      policyStatusChartData.clear();
      if (labels!.label1 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label1.toString(), labels!.value1));
      }

      if (labels!.label2 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label2.toString(), labels!.value2));
      }
      if (labels!.label3 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label3.toString(), labels!.value3));
      }
      if (labels!.label4 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label4.toString(), labels!.value4));
      }
      update();
      return false;
    }).toList();
  }

  // ThemeMode getCurrentThemes() {
  //   return themeMode;
  // }
  int get getPolicyCount => policyBox!.length;
}
