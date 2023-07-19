import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:health_model/hive/hive_helpers/commission_hive_helper.dart';
import 'package:health_model/hive/hive_model/commission_hive_model.dart';
import 'package:hive/hive.dart';

class CommissionSearchController extends GetxController {
  List<CommissionHiveModel> commissions = <CommissionHiveModel>[];
  Box<CommissionHiveModel>? commissionBox;
  TextEditingController searchController = TextEditingController();

// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user CommissionSearchController init called');
    commissionBox = CommissionHiveHelper.commissionBox;
    commissions.addAll(commissionBox!.values.toList());
    super.onInit();
  }

  void filterCommissions(String query) {
    print(query);
    commissions.clear();
    commissions = commissionBox!.values
        .where((commission) =>
            commission.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }
}
