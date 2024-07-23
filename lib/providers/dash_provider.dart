import 'package:health_model/dash.dart';
import 'package:health_model/hive/hive_model/doc_hive_model.dart';
import 'package:health_model/shared/quote.dart';
import 'package:health_model/shared/chart_utils.dart';
import 'package:health_model/pages/document_module/view_documents.dart';
import 'package:health_model/view_user.dart';

import '/shared/exports.dart';

enum CurrentPage { dashboard, clients, company, policy, commision }

// class ItemLabelings {
//   int value1 = 0;
//   int value2 = 0;

//   int value3 = 0;

//   int value4 = 0;

//   final String? label1;
//   final String? label2;
//   final String? label3;
//   final String? label4;

//   ItemLabelings({this.label1, this.label2, this.label3, this.label4});
// }

class DashProvider extends GetxController {
  Future<Map<String, String>>? quoteData;
  List<ChartData> memberChartData = [];
  List<ChartData> docChartData = [];

  Box<UserHiveModel>? userBox;
  Box<DocHiveModel>? docBox;
  ItemLabeling? documentLabels = ItemLabeling(
      label1: 'All', label2: 'Adhaar', label3: 'Pan', label4: 'Insurance');
  ItemLabeling? memberLabels = ItemLabeling(
      label1: '1 member',
      label2: '2 member',
      label3: '3 member',
      label4: '4 member');

  @override
  onInit() {
    super.onInit();
    userBox = UserHiveHelper.userBox;
    docBox = UserHiveHelper.docBox;

    getStats();
    // calculateMembersFromHive();
    // calculatedocumentsFromHive();
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

  void calculateMembersFromHive() {
    if (userBox == null) {
      print('user box is null so returning');
      return;
    }

    userBox!.values.where((policy) {
      UserHiveModel data = policy;
      switch (data.membersCount) {
        case 1:
          memberLabels!.value1 += 1;
        case 2:
          memberLabels!.value2 += 1;
        case 3:
          memberLabels!.value3 += 1;
        case 4:
          memberLabels!.value4 += 1;

          break;
        default:
      }
      memberChartData.clear();
      if (memberLabels!.label1 != '_') {
        memberChartData.add(
            ChartData(memberLabels!.label1.toString(), memberLabels!.value1));
      }

      if (memberLabels!.label2 != '_') {
        memberChartData.add(
            ChartData(memberLabels!.label2.toString(), memberLabels!.value2));
      }
      if (memberLabels!.label3 != '_') {
        memberChartData.add(
            ChartData(memberLabels!.label3.toString(), memberLabels!.value3));
      }
      if (memberLabels!.label4 != '_') {
        memberChartData.add(
            ChartData(memberLabels!.label4.toString(), memberLabels!.value4));
      }
      update();
      return false;
    }).toList();
  }

  void calculatedocumentsFromHive() {
    if (docBox == null) {
      print('user box is null so returning');
      return;
    }

    docBox!.values.where((policy) {
      DocHiveModel data = policy;
      switch (data.docType) {
        case "All":
          documentLabels!.value1 += 1;
        case "other":
          documentLabels!.value2 += 1;
        case "Insurance":
          documentLabels!.value3 += 1;
        case "Pan":
          documentLabels!.value4 += 1;

          break;
        default:
      }
      docChartData.clear();
      if (documentLabels!.label1 != '_') {
        docChartData.add(ChartData(
            documentLabels!.label1.toString(), documentLabels!.value1));
      }

      if (documentLabels!.label2 != '_') {
        docChartData.add(ChartData(
            documentLabels!.label2.toString(), documentLabels!.value2));
      }
      if (documentLabels!.label3 != '_') {
        docChartData.add(ChartData(
            documentLabels!.label3.toString(), documentLabels!.value3));
      }
      if (documentLabels!.label4 != '_') {
        docChartData.add(ChartData(
            documentLabels!.label4.toString(), documentLabels!.value4));
      }
      update();
      return false;
    }).toList();
  }
}
