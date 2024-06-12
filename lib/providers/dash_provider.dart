import 'package:health_model/dash.dart';
import 'package:health_model/quote.dart';
import 'package:health_model/view_documents.dart';
import 'package:health_model/view_user.dart';

import '/shared/exports.dart';

enum CurrentPage { dashboard, clients, company, policy, commision }

class DashProvider extends GetxController {
  Future<Map<String, String>>? quoteData;

  @override
  onInit() {
    super.onInit();
    getStats();
    quoteData = fetchQuote();
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
    if (type == ProductType.cms) {
      navigate(UsersPage(), context);
    } else if (type == ProductType.documents) {
      navigate(DocumentsPage(), context);
    } else {
      navigate(Dash(), context);
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
  DateTime? validityDate = DateTime.now().add(const Duration(days: 730));
  List<dynamic> advisorList = [];
  String adminPin = "1234";
  String username = "";
  String password = "";

  void getStats() {
    FirebaseFirestore.instance
        .collection("Statistics")
        .doc(AppConsts.statsCode)
        .get()
        .then((value) {
      username = value["username"] ?? "1234";
      password = value["password"] ?? "1234";
      adminPin = value["admin_pin"] ?? "1234";
      advisorList = value["advisor_list"] ?? ["Advisor here"];
      healthPercent = value["health_commission_percent"] ?? 15;
      validityDate = value["validity_date"].toDate();

      print(value["validity_date"].toDate().toString());
      update();
    });
  }
}
