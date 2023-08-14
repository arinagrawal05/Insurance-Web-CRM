import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_model/regex.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/general_stats_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

void addPlanSheet(
  BuildContext context,
  String companyId,
  String planId,
  //  int count
) {
  final name = TextEditingController();
  final provider = Get.find<GeneralStatsProvider>(
    tag: AppUtils.getStatsControllerTag(),
  );

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          // height: 500,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading("Add Plan", 25),
              formTextField(
                name,
                "Plan Name",
                "Enter Plan Name",
                FieldRegex.nameRegExp,
              ),
              const SizedBox(
                height: 40,
              ),
              customButton("Add Plan", () {
                // if (_addBrandKey.currentState?.validate() == true) {
                updateStats("plans_count", provider.plans_count + 1);
                updateCompanyPlans(companyId, "plans_count");
                FirebaseFirestore.instance
                    .collection("Companies")
                    .doc(companyId)
                    .collection("Plans")
                    .doc(planId)
                    .set({
                  "plan_name": name.text,
                  "plan_id": planId,
                  "company_id": companyId,
                  "timestamp": Timestamp.now(),
                }).then((value) {
                  print("Successfully Plan Added");

                  Navigator.pop(context);
                  print(planId);
                });

                // }
              }, context)
            ],
          )));
}
