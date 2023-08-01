import 'package:health_model/hive/hive_model/commission_models/commission_hive_model.dart';
import 'package:health_model/shared/exports.dart';
import 'package:hive/hive.dart';

class CommissionSearchController extends GetxController {
  List<CommissionHiveModel> commissions = <CommissionHiveModel>[];
  Box<CommissionHiveModel>? commissionBox;
  TextEditingController searchController = TextEditingController();
  final ProductType type;
  final bool isPending;

  int currentSum = 0;

  CommissionSearchController({
    required this.type,
    required this.isPending,
  });
  String companyFilter = 'All Companies';
// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user CommissionSearchController init called');
    if (type == ProductType.health) {
      commissionBox = CommissionHiveHelper.healthCommissionBox;
    } else {
      commissionBox = CommissionHiveHelper.fDCommissionBox;
    }

    commissions.addAll(commissionBox!.values.toList());
    getCompanies();
    super.onInit();
  }

  void filterCommissions() {
    String query = searchController.text;

    print(query);
    commissions.clear();
    currentSum = 0;
    commissions = commissionBox!.values.where((commission) {
      if (commission.name.toLowerCase().contains(query.toLowerCase())) {
        if (companyFilter == 'All Companies' ||
            companyFilter == commission.companyName) {
          if (isPending) {
            if (!commission.isPending) {
              return false;
            }
          } else {
            if (commission.isPending) {
              return false;
            }
          }

          currentSum += commission.commissionAmt;
          return true;
        }
      }

      return false;
    }).toList();
    update();
  }

  void changeCompany(String newCompany) {
    companyFilter = newCompany;
    filterCommissions();
  }

  List<String> companyList = [
    "All Companies",
  ];

  void getCompanies() {
    companyList = [
      "All Companies",
    ];
    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: EnumUtils.convertTypeToKey(type))
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          companyList.add(AppUtils.getFirstWord(value.docs[i]["name"]));
          print("Added ${AppUtils.getFirstWord(value.docs[i]["name"])}");
        }
      }
    });
    update();
  }
}
