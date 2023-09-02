import 'package:health_model/hive/hive_model/policy_models/motor_model.dart';
import 'package:health_model/shared/exports.dart';

String healthRenewalDraftMsg(PolicyHiveModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.policyNo}\nSum Assured: ${model.sumAssured} Rs \nYour Policy of plan ${model.planName} in ${model.companyName} is ${model.policyStatus}\n Your next Renewal Date is ${dateTimetoText(model.renewalDate)}\n B K Agrawal\n9425473737\nThank you ";

  return draftedMessage;
}

String fDRenewalDraftMsg(FdHiveModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.fdNo}\nSum Assured: ${model.investedAmt} Rs \nYour FD in ${model.companyName} is ${model.fdStatus}\n Your next Renewal Date is ${dateTimetoText(model.maturityDate)}\n ${AppConsts.adminName}\n${AppConsts.adminPhone}\nThank you ";

  return draftedMessage;
}

String lifeRenewalDraftMsg(LifeHiveModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.lifeNo}\nSum Assured: ${model.premuimAmt} Rs \nYour FD in ${model.companyName} is ${model.lifeStatus}\n Your next Renewal Date is ${dateTimetoText(model.maturityDate)}\n ${AppConsts.adminName}\n${AppConsts.adminPhone}\nThank you ";

  return draftedMessage;
}

String motorRenewalDraftMsg(MotorHiveModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.motorNo}\nSum Assured: ${model.sumAssured} Rs \nYour FD in ${model.companyName} is ${model.motorStatus}\n Your next Renewal Date is ${dateTimetoText(model.renewalDate)}\n ${AppConsts.adminName}\n${AppConsts.adminPhone}\nThank you ";

  return draftedMessage;
}

String BDayWishDraftMsg(UserHiveModel model) {
  String draftedMessage =
      "Hello ${model.name},  जन्मदिन की हार्दिक शुभकामनाएं!";

  return draftedMessage;
}
