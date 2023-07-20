import 'package:health_model/shared/enum_utils.dart';

import '../../shared/exports.dart';

class Dash extends StatelessWidget {
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
                    provider.getStats(AppConsts.health);
                    provider.getCompaniesChartData(AppConsts.health);
                    checkGraced();
                    // updateTemp();

                    dashProvider.changeHealthDash(0);
                  }, 0, dashProvider.dashHealthIndex),
                  sideBarTile("Clients", const Icon(Ionicons.person_outline),
                      () {
                    // dashProvider.resetUserList();
                    dashProvider.changeHealthDash(1);
                  }, 1, dashProvider.dashHealthIndex),
                  sideBarTile("Companies", const Icon(Ionicons.build_outline),
                      () {
                    dashProvider.changeHealthDash(2);
                  }, 2, dashProvider.dashHealthIndex),
                  sideBarTile(getWord(dashProvider.dashName),
                      const Icon(Ionicons.reader_outline), () {
                    // dashProvider.resetPolicyList();

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
                                ? PoliciesPage(
                                    type: dashProvider.dashName ==
                                            AppConsts.health
                                        ? ProductType.health
                                        : ProductType.fd,
                                  )
                                : CommissionsPage(
                                    type: dashProvider.dashName ==
                                            AppConsts.health
                                        ? ProductType.health
                                        : ProductType.fd,
                                  )),
          )
        ],
      ),
    );
  }
}
