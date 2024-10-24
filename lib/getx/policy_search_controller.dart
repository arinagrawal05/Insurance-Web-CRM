import '../shared/exports.dart';

import '../hive/hive_model/policy_models/generic_investment_data.dart';

class PolicySearchController extends GetxController {
  List<PolicyDataHiveModel> policies = <PolicyDataHiveModel>[];
  Box<PolicyDataHiveModel>? policyBox;
  TextEditingController searchController = TextEditingController();
  final ProductType type;

  PolicySearchController({required this.type});
  String companyFilter = 'All Companies';
  DateTime toDate = foreverMore;
  DateTime fromDate = foreverAgo;
  String filterName = "by Date";

  int tooltime = 0;

  HealthStatus healthStatusFilter = HealthStatus.active;
  LifeStatus lifeStatusFilter = LifeStatus.allStatus;
  FDStatus fDStatusFilter = FDStatus.allStatus;
  MotorStatus motorStatusFilter = MotorStatus.allStatus;

// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user PolicySearchController init called $type');
    if (type == ProductType.health) {
      policyBox = PolicyHiveHelper.policyBox;
    } else if (type == ProductType.life) {
      policyBox = PolicyHiveHelper.lifeBox;
    } else if (type == ProductType.motor) {
      policyBox = PolicyHiveHelper.motorBox;
    } else {
      policyBox = PolicyHiveHelper.fDBox;
    }
    policies.addAll(policyBox!.values.toList());
    filterpolicies();
    getCompanies();
    super.onInit();
  }

  reset() {
    print('Calling PolicySearchController reset function for $type');
    if (type == ProductType.health) {
      policyBox = PolicyHiveHelper.policyBox;
    } else if (type == ProductType.life) {
      policyBox = PolicyHiveHelper.lifeBox;
    } else if (type == ProductType.motor) {
      policyBox = PolicyHiveHelper.motorBox;
    } else {
      policyBox = PolicyHiveHelper.fDBox;
    }
    policies.addAll(policyBox!.values.toList());
    filterpolicies();
    update();
  }

  void filterpolicies() {
    print('filterpolicies called with $type');
    String query = searchController.text;
    // FilterProvider filterController = Get.find<FilterProvider>();
    // filterController.toDate;
    print(query);
    policies.clear();
    policies = policyBox!.values.where((policy) {
      if (policy.data == null) {
        return false;
      }
      //  print(' case 1 ${policy.data!.name} ${policy.data!.type} $type');

      if (!((type == ProductType.health && policy.data is PolicyHiveModel) ||
          (type == ProductType.fd && policy.data is FdHiveModel) ||
          (type == ProductType.life && policy.data is LifeHiveModel) ||
          (type == ProductType.motor && policy.data is MotorHiveModel))) {
        // print(
        //     ' case 1a ${(type == ProductType.health && policy.data is PolicyHiveModel)} $type');
        // print(
        //     ' case 1b ${(type == ProductType.fd && policy.data is FdHiveModel)} $type');
        return false;
      }
      // print(' case 2 ${policy.data!.name} ${policy.data!.type} $type');

      // print(' case 2 ${policy.data!.name}');

      // if (!(type == ProductType.fd && policy.data is FdHiveModel)) {
      //   return false;
      // }
      // print(' case 3 ${policy.data!.name}');

      // print(' case 4 ${policy.data!.name}');
      // print(' case 4a ${companyFilter}');
      // print(' case 4b ${policy.data!.companyName}');

      if (!(policy.data!.name.toLowerCase().contains(query.toLowerCase()))) {
        return false;
      }
      if (!(companyFilter == 'All Companies' ||
          companyFilter == AppUtils.getFirstWord(policy.data!.companyName))) {
        return false;
      }
      if (!(fromDate.isBefore(policy.data!.renewalDate) &&
          toDate.isAfter(policy.data!.renewalDate))) {
        return false;
      }
      // print(' case 5 ${policy.data!.name}');

      if (!checkStatusFilter(policy.data!)) {
        return false;
      }

      // print(' case 6 ${policy.data!.name}');

      return true;
    }).toList();
    update();
  }

  void closeToolTip() {
    tooltime = 1;

    update();
  }

  void filterByManual(DateTime fDate, DateTime tDate) {
    fromDate = fDate;
    toDate = tDate;
    filterName = "By Manual";

    // update();
    filterpolicies();
  }

  bool checkStatusFilter(GenericInvestmentHiveData data) {
    if (type == ProductType.health) {
      PolicyHiveModel health = data as PolicyHiveModel;
      if (health.policyStatus == healthStatusFilter.name ||
          healthStatusFilter == HealthStatus.allStatus) {
        return true;
      }
    }

    if (type == ProductType.fd) {
      FdHiveModel fd = data as FdHiveModel;
      if (fd.fdStatus == fDStatusFilter.name ||
          fDStatusFilter == FDStatus.allStatus) {
        return true;
      }
    }
    if (type == ProductType.life) {
      LifeHiveModel life = data as LifeHiveModel;
      if (life.lifeStatus == lifeStatusFilter.name ||
          lifeStatusFilter == LifeStatus.allStatus) {
        return true;
      }
    }
    if (type == ProductType.motor) {
      MotorHiveModel motor = data as MotorHiveModel;
      if (motor.motorStatus == motorStatusFilter.name ||
          motorStatusFilter == MotorStatus.allStatus) {
        return true;
      }
    }
    return false;
  }

  void changeCompany(String newCompany) {
    companyFilter = newCompany;
    filterpolicies();
  }

  void changeStatus(String status) {
    if (type == ProductType.health) {
      healthStatusFilter = EnumUtils.convertNameToHealthStatus(status);
    } else if (type == ProductType.life) {
      lifeStatusFilter = EnumUtils.convertNameToLifeStatus(status);
    } else if (type == ProductType.motor) {
      motorStatusFilter = EnumUtils.convertNameToMotorStatus(status);
    } else if (type == ProductType.fd) {
      fDStatusFilter = EnumUtils.convertNameToFdStatus(status);
    }

    filterpolicies();
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

  List<String> get getCurrentStatusList => AppConsts.getStatusList(type);
}
