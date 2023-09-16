import '/shared/exports.dart';

class ItemLabeling {
  int value1 = 0;
  int value2 = 0;

  int value3 = 0;

  int value4 = 0;

  final String? label1;
  final String? label2;
  final String? label3;
  final String? label4;

  ItemLabeling({this.label1, this.label2, this.label3, this.label4});
}

class GeneralStatsProvider extends GetxController {
  final ProductType type;
  // int users_count = 0;
  // int policies_count = 0;
  ItemLabeling? labels;

  int plans_count = 0;
  int companies_count = 0;
  Box<PolicyDataHiveModel>? policyBox;
  Map<DateTime, List<GenericInvestmentHiveData>> mySelectedEvents = {};
  List<CompanyChartData> chartCompanyData = [];
  List<PolicyStatusChartData> policyStatusChartData = [];
  List<PolicyDistributionChartData> policyDistributionChartData = [];

  @override
  onInit() {
    super.onInit();
    print("object GeneralStatsProvider $type init called");
    getStatsData();
    getCompaniesChartData(EnumUtils.convertTypeToKey(type));
    boxDivision();
  }

  void boxDivision() {
    if (type == ProductType.health) {
      policyBox = PolicyHiveHelper.policyBox;
    } else if (type == ProductType.life) {
      policyBox = PolicyHiveHelper.lifeBox;
    } else if (type == ProductType.motor) {
      policyBox = PolicyHiveHelper.motorBox;
    } else {
      policyBox = PolicyHiveHelper.fDBox;
    }
  }

  GeneralStatsProvider({required this.type});
  void getStatsData() {
    if (type == ProductType.health) {
      labels = ItemLabeling(
          label1: 'Active', label2: 'Ported', label3: 'lapsed', label4: '_');
    } else if (type == ProductType.life) {
      labels = ItemLabeling(
          label1: 'enforced',
          label2: 'lapsed',
          label3: 'paid',
          label4: 'matured');
    } else if (type == ProductType.fd) {
      labels = ItemLabeling(
          label1: 'applied',
          label2: 'inHand',
          label3: 'handover',
          label4: 'redeemed');
    } else if (type == ProductType.motor) {
      labels = ItemLabeling(
          label1: 'active', label2: 'nonActive', label3: '_', label4: '_');
    }

    Future.delayed(
      const Duration(seconds: 2),
      () {
        calculatePolicyStatsFromHive();
      },
    );
  }

  void getCompaniesChartData(companyType) {
    chartCompanyData = [];
    Map<String, int> companyBusiness = {};
    Map<String, int> companyPolicies = {};
    // Map<DateTime, List> mySelectedEvents = {};

    FirebaseFirestore.instance
        .collection("Companies")
        .where("company_type", isEqualTo: companyType)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        companies_count = value.docs.length;

        for (var i = 0; i < value.docs.length; i++) {
          if (type != ProductType.fd) {
            FirebaseFirestore.instance
                .collection("Companies")
                .doc(value.docs[i]["company_id"])
                .collection("Plans")
                .get()
                .then((value) {
              plans_count += value.docs.length;
            });
          }

          companyBusiness[value.docs[i]["name"]] = 0;
          companyPolicies[value.docs[i]["name"]] = 0;
          // chartCompanyData.add(CompanyChartData(
          //     AppUtils.getFirstWord(value.docs[i]["name"]),
          //     value.docs[i]["total_bussiness"]));
          // print(chartData[i].x.toString());
          // policyDistributionChartData.add(PolicyDistributionChartData(
          //     value.docs[i]["name"], value.docs[i]["policy_count"]));
        }

        policyBox!.values.forEach((element) {
          int amount = 0;
          int policyCount = 0;
          // print(type + element.data)
          if (type == ProductType.health && element.data is PolicyHiveModel) {
            var s = element.data as PolicyHiveModel;
            amount = s.premuimAmt;

            policyCount += 1;
            if (mySelectedEvents[s.renewalDate] != null) {
              mySelectedEvents[s.renewalDate]?.add(
                element.data!,
              );
            } else {
              mySelectedEvents[s.renewalDate] = [
                element.data!,
                // "policyNo": s.policyNo,
              ];
            }

            // mySelectedEvents[s.renewalDate]?.add({
            //  "model": s.name,
            //   "policyNo": s.policyNo,
            // });
          } else if (type == ProductType.fd && element.data is FdHiveModel) {
            var s = element.data as FdHiveModel;
            amount = s.investedAmt;
            policyCount += 1;
            if (mySelectedEvents[s.renewalDate] != null) {
              mySelectedEvents[s.renewalDate]?.add(
                element.data!,
              );
            } else {
              mySelectedEvents[s.renewalDate] = [
                element.data!,
                // "policyNo": s.policyNo,
              ];
            }
          } else if (type == ProductType.life &&
              element.data is LifeHiveModel) {
            var s = element.data as LifeHiveModel;
            amount = s.premuimAmt;
            policyCount += 1;
            mySelectedEvents[s.renewalDate]?.add(element.data!);
          } else if (type == ProductType.motor &&
              element.data is MotorHiveModel) {
            var s = element.data as MotorHiveModel;
            amount = s.premiumAmt;
            policyCount += 1;
            if (mySelectedEvents[s.renewalDate] != null) {
              mySelectedEvents[s.renewalDate]?.add(
                element.data!,
              );
            } else {
              mySelectedEvents[s.renewalDate] = [
                element.data!,
                // "policyNo": s.policyNo,
              ];
            }
          }
          if (companyBusiness.containsKey(element.data!.companyName)) {
            companyBusiness[element.data!.companyName] =
                (companyBusiness[element.data!.companyName] ?? 0) + amount;

            companyPolicies[element.data!.companyName] =
                (companyPolicies[element.data!.companyName] ?? 0) + policyCount;
            // companyBusiness[element.data!.companyName] ;
          }
        });

        companyBusiness.forEach((key, value) {
          chartCompanyData
              .add(CompanyChartData(AppUtils.getFirstWord(key), value));
        });

        companyPolicies.forEach((key, value) {
          policyDistributionChartData
              .add(PolicyDistributionChartData(key, value));
        });
      }
      update();
    });
  }

  void calculatePolicyStatsFromHive() {
    // print("take 00");
    // print("Take 2 ${policyBox!.values.length}");

    if (policyBox == null) {
      print('Policy box is null so returning');
      return;
    }

    // print("Take 21 ${policyBox!.values.length}");

    policyBox!.values.where((policy) {
      // print("take 01");

      if (policy.data == null) {
        // print("take 02");

        return false;
      }
      // print("take 1");
      if (type == ProductType.health) {
        // print("take 2");

        if (policy.data is PolicyHiveModel) {
          PolicyHiveModel data = policy.data as PolicyHiveModel;
          // print("take 2a ${data.policyStatus}");
          switch (data.policyStatus) {
            case 'active':
              labels!.value1 += 1;
            case 'ported':
              labels!.value2 += 1;
            case 'lapsed':
              labels!.value3 += 1;

              break;
            default:
          }
        }
        // print("take 3");
      } else if (type == ProductType.life) {
        // print("take 4");

        if (policy.data is LifeHiveModel) {
          LifeHiveModel data = policy.data as LifeHiveModel;
          switch (data.lifeStatus) {
            case 'enforced':
              labels!.value1 += 1;
            case 'lapsed':
              labels!.value2 += 1;
            case 'paid':
              labels!.value3 += 1;
            case 'matured':
              labels!.value3 += 1;

              break;
            default:
          }
        }
      } else if (type == ProductType.fd) {
        // print("take 4");

        if (policy.data is FdHiveModel) {
          FdHiveModel data = policy.data as FdHiveModel;
          switch (data.fdStatus) {
            case 'applied':
              labels!.value1 += 1;
            case 'inHand':
              labels!.value2 += 1;

            case 'handover':
              labels!.value3 += 1;
            case 'redeemed':
              labels!.value4 += 1;
              break;
            default:
          }
        }
      } else if (type == ProductType.motor) {
        // print("take 4");

        if (policy.data is MotorHiveModel) {
          MotorHiveModel data = policy.data as MotorHiveModel;
          switch (data.motorStatus) {
            case 'active':
              labels!.value1 += 1;
            case 'nonActive':
              labels!.value2 += 1;

              break;
            default:
          }
        }
      }
      // print("Stats computed");
      // print('${labels!.label1} ${labels!.value1}');

      // print('${labels!.label2} ${labels!.value2}');
      // print('${labels!.label3} ${labels!.value3}');
      // print('${labels!.label4} ${labels!.value4}');
      policyStatusChartData.clear();
      if (labels!.label1 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label1.toString(), labels!.value1));
      }

      if (labels!.label2 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label2.toString(), labels!.value2));
      }
      if (labels!.label3 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label3.toString(), labels!.value3));
      }
      if (labels!.label4 != '_') {
        policyStatusChartData.add(
            PolicyStatusChartData(labels!.label4.toString(), labels!.value4));
      }
      update();
      return false;
    }).toList();
  }

  // ThemeMode getCurrentThemes() {
  //   return themeMode;
  // }
  int get getPolicyCount => policyBox!.length;
}
