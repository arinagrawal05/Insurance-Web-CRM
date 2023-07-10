import 'package:flutter/material.dart';
import 'package:health_model/health_dashboard.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/view_commissions.dart';
import 'package:health_model/view_companies.dart';
import 'package:health_model/view_policies.dart';
import 'package:health_model/view_user.dart';
import 'package:health_model/shared/loading.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class HealthDash extends StatelessWidget {
  // List<ChartData> data;
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashProvider>(context, listen: true);
    final provider = Provider.of<HealthStatsProvider>(context, listen: true);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: dashBoxDex(context),
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // AspectRatio(
                  //     aspectRatio: 1,
                  //     child: Container(
                  //       child: Icon(
                  //         Ionicons.receipt_outline,
                  //         size: 20,
                  //       ),
                  //     )),
                  // // SizedBox(
                  // //   height: 50,
                  // // ),
                  sideBarTile("DashBoard", const Icon(Ionicons.diamond), () {
                    provider.getStats();
                    provider.getCompaniesChartData();
                    checkGraced();
                    // updateTemp();

                    dashProvider.changeHealthDash(0);
                  }, 0, dashProvider.dashHealthIndex),
                  sideBarTile("Clients", const Icon(Ionicons.person_outline),
                      () {
                    dashProvider.resetUserList();
                    dashProvider.changeHealthDash(1);
                  }, 1, dashProvider.dashHealthIndex),
                  sideBarTile("Companies", const Icon(Ionicons.build_outline),
                      () {
                    dashProvider.changeHealthDash(2);
                  }, 2, dashProvider.dashHealthIndex),
                  sideBarTile("Policies", const Icon(Ionicons.reader_outline),
                      () {
                    dashProvider.resetPolicyList();

                    dashProvider.changeHealthDash(3);
                  }, 3, dashProvider.dashHealthIndex),
                  sideBarTile("Commission", const Icon(Ionicons.cash_outline),
                      () {
                    dashProvider.resetCommissionList();

                    dashProvider.changeHealthDash(4);
                  }, 4, dashProvider.dashHealthIndex),
                  // Image.network(
                  //     "https://static.vecteezy.com/system/resources/previews/019/051/660/original/men-working-illustration-png.png")
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                // margin: EdgeInsets.all(4),
                // color: const Color.fromRGBO(0, 0, 0, 0),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: dashProvider.dashHealthIndex == 0
                    ? HealthDashboardPage()
                    : dashProvider.dashHealthIndex == 1
                        ? const UsersPage()
                        : dashProvider.dashHealthIndex == 2
                            ? CompaniesPage()
                            : dashProvider.dashHealthIndex == 3
                                ? PoliciesPage()
                                : CommissionsPage()),
          )
        ],
      ),
    );
  }
}
