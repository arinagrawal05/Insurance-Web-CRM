import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_model/getx/user_search_controller.dart';
import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import 'package:health_model/hive/hive_helpers/user_hive_helper.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_data_model.dart';
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
                      PolicyHiveHelper.fetchPoliciesFromFirebase();
                    },
                    icon: Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      PolicyHiveHelper.deleteAllPolicyData();
                      print(UserHiveHelper.userBox.length.toString());
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            body: ValueListenableBuilder<Box<PolicyDataHiveModel>>(
              valueListenable: PolicyHiveHelper.policyBox.listenable(),
              builder: (context, box, _) {
                if (box.isEmpty) {
                  return Center(
                    child: Text('No users found'),
                  );
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final user = box.getAt(index);

                    if (user == null || user.data == null) {
                      return Container();
                    }
                    return ListTile(
                      title: Text(user!.data!.name),
                      // subtitle: Text(user.email),
                      onTap: () {
                        // Handle user selection
                      },
                    );
                  },
                );
              },
            )));
    // body: Scaffold(body: Builder(builder: (context) {
    //   return GetBuilder<UserSearchController>(
    //       init: UserSearchController(),
    //       builder: (controller) {
    //         return Column(
    //           children: [
    //             customTextfield(
    //                 controller.searchController, "Search", context,
    //                 onChange: (query) {
    //               controller.filterUsers(query);
    //             }),
    //             Expanded(
    //               child: ListView.builder(
    //                 // shrinkWrap: true,
    //                 // physics: NeverScrollableScrollPhysics(),
    //                 itemCount: controller.users.length,
    //                 itemBuilder: (context, index) {
    //                   final user = controller.users[index];

    //                   return ListTile(
    //                     title: Text(user!.name),
    //                     subtitle: Text(user.email),
    //                     onTap: () {
    //                       // Handle user selection
    //                     },
    //                   );
    //                 },
    //               ),
    //             ),
    //           ],
    //         );
    //       });
    // }))));
  }
}
