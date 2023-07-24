import 'package:health_model/hive/hive_model/policy_models/fd_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:health_model/hive/hive_model/user_hive_model.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/models/user_model.dart';

String healthRenewalDraftMsg(PolicyHiveModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.policyNo}\nSum Assured: ${model.sumAssured} Rs \nYour Policy of plan ${model.planName} in ${model.companyName} is ${model.policyStatus}\n Your next Renewal Date is ${dateTimetoText(model.renewalDate)}\n B K Agrawal\n9425473737\nThank you ";

  return draftedMessage;
}

String fDRenewalDraftMsg(FdHiveModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.fdNo}\nSum Assured: ${model.investedAmt} Rs \nYour FD in ${model.companyName} is ${model.fdStatus}\n Your next Renewal Date is ${dateTimetoText(model.maturityDate)}\n B K Agrawal\n9425473737\nThank you ";

  return draftedMessage;
}

String BDayWishDraftMsg(UserHiveModel model) {
  String draftedMessage =
      "Hello ${model.name},  जन्मदिन की हार्दिक शुभकामनाएं!";

  return draftedMessage;
}
