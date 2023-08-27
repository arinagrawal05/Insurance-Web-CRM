import 'package:health_model/shared/enum_utils.dart';

import '../../shared/exports.dart';

class Dash extends StatelessWidget {
  // List<ChartData> data;
  @override
  Widget build(BuildContext context) {
    // final dashProvider = Get.find<DashProvider>();
    // final provider = Provider.of<.>(context, listen: true);

    return GetBuilder<DashProvider>(builder: (dashProvider) {
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
                      // provider.getStats(ProductType.health);
                      // provider.getCompaniesChartData(ProductType.health);
                      checkGraced();
                      // updateTemp();

                      dashProvider.changePage(CurrentPage.dashboard);
                    }, CurrentPage.dashboard, dashProvider.pageState),
                    sideBarTile("Clients", const Icon(Ionicons.person_outline),
                        () {
                      // dashProvider.resetUserList();
                      dashProvider.changePage(CurrentPage.clients);
                    }, CurrentPage.clients, dashProvider.pageState),
                    sideBarTile("Companies", const Icon(Ionicons.build_outline),
                        () {
                      dashProvider.changePage(CurrentPage.company);
                    }, CurrentPage.company, dashProvider.pageState),
                    sideBarTile(
                        EnumUtils.convertTypeToKey(
                            dashProvider.currentDashBoard),
                        const Icon(Ionicons.reader_outline), () {
                      // dashProvider.resetPolicyList();

                      dashProvider.changePage(CurrentPage.policy);
                    }, CurrentPage.policy, dashProvider.pageState),
                    sideBarTile("Commission", const Icon(Ionicons.cash_outline),
                        () {
                      // dashProvider.resetCommissionList();

                      dashProvider.changePage(CurrentPage.commision);
                    }, CurrentPage.commision, dashProvider.pageState),
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
                  child: getPage(
                      dashProvider.pageState, dashProvider.currentDashBoard),
                ))
          ],
        ),
      );
    });
  }

  getPage(CurrentPage page, ProductType type) {
    switch (page) {
      case CurrentPage.dashboard:
        return DashboardPage(
          type: type,
        );

      case CurrentPage.clients:
        return UsersPage();
      case CurrentPage.company:
        return CompaniesPage(
          type: type,
        );
      case CurrentPage.policy:
        return PoliciesPage(
          type: type,
        );
      case CurrentPage.commision:
        return CommissionsPage(
          type: type,
        );
    }
  }
}
