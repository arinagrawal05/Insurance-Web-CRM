import 'package:flutter/material.dart';
import 'package:health_model/regex.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/policy_flow/enter_policy.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

class ChooseFresh extends StatelessWidget {
  ChooseFresh({
    super.key,
  });

  Widget build(BuildContext context) {
    final provider = Provider.of<PolicyProvider>(context, listen: true);
    // final statsProvider =
    //     Provider.of<HealthStatsProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.freshFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chooseHeader("Fresh or Port", 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.portCompanyNameController,
                        "Company Name",
                        "Enter Company Namr",
                        FieldRegex.nameRegExp,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: formTextField(
                          provider.portPolicyNoController,
                          "Policy No",
                          "Enter Policy No",
                          FieldRegex.defaultRegExp,
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: formTextField(
                          provider.portSumAssuredController,
                          "Sum Assured",
                          "Enter Sum Assured",
                          FieldRegex.integerRegExp,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.postIssuedDate,
                        "Ported Issued Date:DD/MM/YYYY",
                        "Enter Issued Date",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
                ),
                customButton("Fresh", () {
                  provider.clearPort();
                  navigate(
                      EnterPolicyDetails(
                          inceptionDate: provider.postIssuedDate.text),
                      context);
                }, context),
                customButton("Ported", () {
                  if (provider.freshFormKey.currentState?.validate() == true) {
                    provider.feedPort(
                        provider.portCompanyNameController.text,
                        provider.portPolicyNoController.text,
                        provider.portSumAssuredController.text,
                        "",
                        textToDateTime(provider.postIssuedDate.text));
                    navigate(
                        EnterPolicyDetails(
                            inceptionDate: provider.postIssuedDate.text),
                        context);
                  }
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
