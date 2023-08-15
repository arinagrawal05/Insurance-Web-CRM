import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:health_model/hive/hive_helpers/user_hive_helper.dart';
import 'package:health_model/hive/hive_model/user_hive_model.dart';
import 'package:hive/hive.dart';

class UserSearchController extends GetxController {
  List<UserHiveModel> users = <UserHiveModel>[];
  Box<UserHiveModel>? userBox;
  TextEditingController searchController = TextEditingController();

// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user UserSearchController init called');
    userBox = UserHiveHelper.userBox;
    users.addAll(userBox!.values.toList());
    super.onInit();
  }

  reset() {
    users.clear();
    userBox = UserHiveHelper.userBox;
    users.addAll(userBox!.values.toList());
    update();
  }

  void filterUsers(String query) {
    print(query);
    users.clear();
    users = userBox!.values
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }
}
