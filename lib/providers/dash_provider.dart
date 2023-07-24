import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_model/models/commission_model.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/models/user_model.dart';
import 'package:health_model/shared/exports.dart';

enum CurrentPage { dashboard, clients, company, policy, commision }

class DashProvider extends GetxController {
  CurrentPage pageState = CurrentPage.dashboard;
  // CurrentPage fDState = CurrentPage.dashboard;
  ProductType currentDashBoard = ProductType.health;
  // int dashFDIndex = 0;
  String dashName = "Health";

  void navigateToProduct(ProductType type, BuildContext context) {
    // final provider = Get.find<HealthStatsProvider>();

    // final filterProvider = Get.find<FilterProvider>();
    currentDashBoard = type;

    navigate(Dash(), context);
    print("Entered Again");
    // provider.getStats(EnumUtils.convertTypeToKey(ProductType.health));
    // provider.getCompaniesChartData(EnumUtils.convertTypeToKey(ProductType.health));
    // filterProvider.getCompanies(EnumUtils.convertTypeToKey(ProductType.health));
    update();
  }

  void changePage(
    CurrentPage page,
  ) {
    print('Change page called to $page');
    pageState = page;
    update();
  }
}
