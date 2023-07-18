import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/policy_model.dart';
import 'package:health_model/models/user_model.dart';

String renewalDraftMsg(PolicyModel model) {
  String draftedMessage =
      "Hello ${model.name}, \nYour Policy No:${model.policyNo}\nSum Assured: ${model.sumAssured} Rs \nYour Policy of plan ${model.planName} in ${model.companyName} is ${model.policyStatus}\n Your next Renewal Date is ${dateTimetoText(model.renewalDate.toDate())}\n B K Agrawal\n9425473737\nThank you ";

  return draftedMessage;
}

String BDayWishDraftMsg(UserModel model) {
  String draftedMessage =
      "Hello ${model.name},  जन्मदिन की हार्दिक शुभकामनाएं!";

  return draftedMessage;
}
