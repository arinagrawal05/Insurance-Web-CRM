import 'package:health_model/hive/hive_model/policy_models/fd_model.dart';
import 'package:health_model/shared/enum_utils.dart';
import 'package:health_model/shared/exports.dart';

import '../hive/hive_model/policy_models/life_model.dart';
import '../hive/hive_model/user_hive_model.dart';

class AppConsts {
  static String health = "Health";
  static String fd = "FD";
  static String life = "Life";

  static bool isProductionMode = true;
  static UserHiveModel userModel = UserHiveModel(
    name: "Arin Agrawal",
    address: "Choubey Colony",
    phone: "7898291900",
    email: "arinagrawal07128@gmailcom",
    userid: "06885b49-8870-40df-a27a-46326b409a10",
    isMale: true,
    dob: DateTime.now(),
    membersCount: 3,
  );
  static FdHiveModel fdModel = FdHiveModel(
      name: "Arin Agrawal",
      address: "Choubey Colony",
      phone: "7898291900",
      email: "arinagrawal07128@gmailcom",
      userid: "06885b49-8870-40df-a27a-46326b409a10",
      isMale: true,
      dob: DateTime.now(),
      bankDetails: "",
      certificateGivenDate: DateTime.now(),
      initialDate: DateTime.now(),
      certificateTakenDate: DateTime.now(),
      statusDate: DateTime.now(),
      maturityDate: DateTime.now(),
      portMaturityDate: DateTime.now(),
      companyID: "",
      companyLogo: "",
      companyName: "Company name",
      type: "FD",
      cummulativeTerm: "by month",
      fDterm: 24,
      fdId: "",
      fdNo: "2345543",
      fdNomineeName: "nominee",
      folioNo: "",
      headName: "",
      investedAmt: 34323,
      isCummulative: true,
      isFresh: false,
      maturityAmt: 23432,
      nomineeDob: DateTime.now(),
      nomineeRelation: "",
      payMode: "",
      portCompanyName: "",
      portMaturityAmt: "2343",
      portFdNo: "",
      fdStatus: "active");
  static LifeHiveModel lifeModel = LifeHiveModel(
    name: "Arin Agrawal",
    address: "Choubey Colony",
    phone: "7898291900",
    email: "arinagrawal07128@gmailcom",
    userid: "06885b49-8870-40df-a27a-46326b409a10",
    isMale: true,
    dob: DateTime.now(),
    bankDetails: "",
    commitmentDate: DateTime.now(),
    renewalDate: DateTime.now(),
    statusDate: DateTime.now(),
    maturityDate: DateTime.now(),
    companyID: "",
    companyLogo: "",
    companyName: "Company name",
    type: "FD",
    advisorName: "anil kumar",
    payingTerm: 24,
    lifeID: "",
    lifeNo: "2345543",
    nomineeName: "nominee",
    planID: "",
    planName: "",
    premuimAmt: 3000,
    sumAssured: 900000,
    lifeStatus: "",
    headName: "",
    nomineeDob: DateTime.now(),
    nomineeRelation: "",
    payMode: "",
  );
  static List<String> healthPolicyStatusList = [
    "all status",
    "active",
    "ported",
    "lapsed",
  ];
  static List<String> lifePolicyStatusList = [
    "all status",
    "applied",
    "state2",
    "state3",
  ];
  static List<String> fDStatusList = [
    "all status",
    "applied",
    "inHand",
    "handover",
    "redeemed",
  ];

  static List<String> getStatusList(ProductType type) {
    if (type == ProductType.health) {
      return healthPolicyStatusList;
    }
    if (type == ProductType.life) {
      return lifePolicyStatusList;
    } else {
      return fDStatusList;
    }
  }
}
