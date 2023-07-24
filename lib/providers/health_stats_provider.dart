import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_data_model.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/charts.dart';
import 'package:health_model/shared/const.dart';

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

class HealthStatsProvider extends GetxController {
  final ProductType type;
  // int users_count = 0;
  // int policies_count = 0;
  ItemLabeling? labels;
  int companies_count = 0;
  int active_policies_count = 0;
  int lapped_policies_count = 0;
  int ported_policies_count = 0;
  int premiumAmtSum = 0;
  int healthPercent = 15;
  DateTime validityDate = DateTime.now();
  List<String> advisorList = [];
  String adminPin = "1234";
  int plans_count = 0;
  List<CompanyChartData> chartData = [];
  List<PolicyStatusChartData> policyStatusChartData = [];
  List<PolicyDistributionChartData> policyDistributionChartData = [];

  @override
  onInit() {
    super.onInit();
    if (type == ProductType.health) {
      labels = ItemLabeling(
          label1: 'Active', label2: 'Ported', label3: 'lapsed', label4: '_');
    } else if (type == ProductType.fd) {
      labels = ItemLabeling(
          label1: 'applied',
          label2: 'inHand',
          label3: 'handnover',
          label4: 'redeemed');
    }
  }

  HealthStatsProvider({required this.type});

  void getCompaniesChartData(companyType) {
    chartData = [];
    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: companyType)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          chartData.add(CompanyChartData(
              AppUtils.getFirstWord(value.docs[i]["name"]),
              value.docs[i]["total_bussiness"]));
          // print(chartData[i].x.toString());
          policyDistributionChartData.add(PolicyDistributionChartData(
              value.docs[i]["name"], value.docs[i]["policy_count"]));
        }
      }
    });
    update();
  }

  void calculatePolicyStatsFromHive() {
    print("take 00");

    PolicyHiveHelper.policyBox.values.where((policy) {
      print("take 01");

      if (policy.data == null) {
        print("take 02");

        return false;
      }
      print("take 1");
      if (type == ProductType.health) {
        print("take 2");

        if (policy is PolicyHiveModel) {
          PolicyHiveModel data = policy.data as PolicyHiveModel;
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
        print("take 3");
      } else if (type == ProductType.fd) {
        print("take 4");

        if (policy is FdHiveModel) {
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

        print("Stats computed");
        print('${labels!.label1} ${labels!.value1}');

        print('${labels!.label2} ${labels!.value2}');
        print('${labels!.label3} ${labels!.value3}');
        print('${labels!.label4} ${labels!.value4}');
      }

      return false;
    });
  }

  Future<void> getStats(String companyType) async {
    policyDistributionChartData = [];
    policyStatusChartData = [];
    FirebaseFirestore.instance
        .collection("Statistics")
        .doc("KdMlwAoBwwkdREqX3hIe")
        .get()
        .then((value) {
      premiumAmtSum = value["sum_premium_amt"];
      plans_count = value["plans_count"];
      adminPin = value["admin_pin"];
      advisorList = value["advisor_list"];
      healthPercent = value["health_commission_percent"];
      validityDate = value["validity_date"].toDate();
    });

    // await FirebaseFirestore.instance
    //     .collection("Policies")
    //     .where("type", isEqualTo: companyType)
    //     .get()
    //     .then((value) => {
    //           policies_count = value.docs.length,
    //         });  // await FirebaseFirestore.instance
    //     .collection("Policies")
    //     .where("policy_status", isEqualTo: "active")
    //     .get()
    //     .then((value) => {
    //           print("Active Policies${value.docs.length}"),
    //           policyStatusChartData.add(
    //             PolicyStatusChartData("Active", value.docs.length),
    //           ),
    //           active_policies_count = value.docs.length,
    //         });

    // await FirebaseFirestore.instance
    //     .collection("Policies")
    //     .where("policy_status", isEqualTo: "lapsed")
    //     .get()
    //     .then((value) => {
    //           policyStatusChartData.add(
    //             PolicyStatusChartData("lapsed", value.docs.length),
    //           ),
    //           lapped_policies_count = value.docs.length,
    //         });
    // await FirebaseFirestore.instance
    //     .collection("Policies")
    //     .where("policy_status", isEqualTo: "ported")
    //     .get()
    //     .then((value) => {
    //           policyStatusChartData.add(
    //             PolicyStatusChartData("Ported", value.docs.length),
    //           ),
    //           ported_policies_count = value.docs.length,
    //         });

    // await FirebaseFirestore.instance.collection("Users").get().then((value) => {
    //       users_count = value.docs.length,
    //     });
    await FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: companyType)
        .get()
        .then((value) => {
              companies_count = value.docs.length,
            });

    update();
  }

  // ThemeMode getCurrentThemes() {
  //   return themeMode;
  // }
}
