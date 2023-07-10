import 'package:flutter/material.dart';
import 'package:health_model/fd_dashboard.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/view_commissions.dart';
import 'package:health_model/view_companies.dart';
import 'package:health_model/view_policies.dart';
import 'package:health_model/view_user.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class FDDash extends StatefulWidget {
  @override
  _FDDashState createState() => _FDDashState();
}

class _FDDashState extends State<FDDash> {
  // List<ChartData> data;
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashProvider>(context, listen: true);
    // final provider = Provider.of<FDProvider>(context, listen: true);

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
                    // provider.getStats();
                    // provider.getCompaniesChartData();
                    // checkGraced();
                    // updateTemp();

                    dashProvider.changeFDDash(0);
                  }, 0, dashProvider.dashFDIndex),
                  sideBarTile("Clients", const Icon(Ionicons.person_outline),
                      () {
                    dashProvider.changeFDDash(1);
                  }, 1, dashProvider.dashFDIndex),
                  sideBarTile("Companies", const Icon(Ionicons.build_outline),
                      () {
                    dashProvider.changeFDDash(2);
                  }, 2, dashProvider.dashFDIndex),
                  sideBarTile("Policies", const Icon(Ionicons.reader_outline),
                      () {
                    dashProvider.changeFDDash(3);
                  }, 3, dashProvider.dashFDIndex),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: sideBarTile(
                        "Commission", const Icon(Ionicons.cash_outline), () {
                      dashProvider.changeFDDash(4);
                    }, 4, dashProvider.dashFDIndex),
                  ),
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
                child: dashProvider.dashFDIndex == 0
                    ? FdDashboardPage()
                    : dashProvider.dashFDIndex == 1
                        ? const UsersPage()
                        : dashProvider.dashFDIndex == 2
                            ? CompaniesPage()
                            : dashProvider.dashFDIndex == 3
                                ? PoliciesPage()
                                : CommissionsPage()),
          )
        ],
      ),
    );
  }
}
