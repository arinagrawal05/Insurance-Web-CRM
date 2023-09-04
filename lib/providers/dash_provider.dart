import 'package:health_model/shared/exports.dart';

enum CurrentPage { dashboard, clients, company, policy, commision }

class DashProvider extends GetxController {
  @override
  onInit() {
    super.onInit();
    getStats();
  }

  CurrentPage pageState = CurrentPage.dashboard;
  // CurrentPage fDState = CurrentPage.dashboard;
  ProductType currentDashBoard = ProductType.health;
  // int dashFDIndex = 0;
  String dashName = "Health";

  void navigateToProduct(ProductType type, BuildContext context) {
    // final provider = Get.find<HealthStatsProvider>();

    // final filterProvider = Get.find<FilterProvider>();
    currentDashBoard = type;
    if (type != ProductType.cms) {
      navigate(Dash(), context);
    } else {
      navigate(UsersPage(), context);
    }
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

  int healthPercent = 15;
  DateTime? validityDate = DateTime.now().add(Duration(days: 730));
  List<dynamic> advisorList = [];
  String adminPin = "1234";

  void getStats() {
    FirebaseFirestore.instance
        .collection("Statistics")
        .doc("KdMlwAoBwwkdREqX3hIe")
        .get()
        .then((value) {
      adminPin = value["admin_pin"];
      advisorList = value["advisor_list"];
      healthPercent = value["health_commission_percent"];
      // validityDate = value["validity_date"].toDate();
      print(value["validity_date"].toDate().toString());
      update();
    });
  }
}
