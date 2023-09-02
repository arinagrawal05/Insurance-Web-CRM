import 'package:health_model/shared/exports.dart';

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
    } else if (type == ProductType.life) {
      commissionBox = CommissionHiveHelper.lifeCommissionBox;
    } else if (type == ProductType.motor) {
      commissionBox = CommissionHiveHelper.motorCommissionBox;
    } else {
      commissionBox = CommissionHiveHelper.fDCommissionBox;
    }

    commissions.addAll(commissionBox!.values.toList());
    getCompanies();
    super.onInit();
  }

  reset() {
    print('Calling CommissionSearchController reset function for $type');
    if (type == ProductType.health) {
      commissionBox = CommissionHiveHelper.healthCommissionBox;
    } else if (type == ProductType.life) {
      commissionBox = CommissionHiveHelper.lifeCommissionBox;
    } else if (type == ProductType.motor) {
      commissionBox = CommissionHiveHelper.motorCommissionBox;
    } else {
      commissionBox = CommissionHiveHelper.fDCommissionBox;
    }
    commissions.addAll(commissionBox!.values.toList());
    filterCommissions();
    update();
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
