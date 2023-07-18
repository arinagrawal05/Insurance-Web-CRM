import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_model/getx/user_search_controller.dart';
import 'package:health_model/hive/hive_helpers/user_hive_helper.dart';
import 'package:health_model/hive/hive_model/user_hive_model.dart';
import 'package:health_model/models/user_model.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      UserHiveHelper.fetchUsersFromFirebase();
                    },
                    icon: Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      UserHiveHelper.deleteAllUserData();
                      print(UserHiveHelper.userBox.length.toString());
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            body: Scaffold(body: Builder(builder: (context) {
              return GetBuilder<UserSearchController>(
                  init: UserSearchController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        customTextfield(
                            controller.searchController, "Search", context,
                            onChange: (query) {
                          controller.filterUsers(query);
                        }),
                        Expanded(
                          child: ListView.builder(
                            // shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.users.length,
                            itemBuilder: (context, index) {
                              final user = controller.users[index];

                              return ListTile(
                                title: Text(user!.name),
                                subtitle: Text(user.email),
                                onTap: () {
                                  // Handle user selection
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  });
            }))));
  }
}
