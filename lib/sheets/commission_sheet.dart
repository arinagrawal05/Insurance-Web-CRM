import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/commission_model.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';

void confirmCommission(
  BuildContext context,
  CommissionModel model,
  HealthStatsProvider provider,

  //  int count
) {
  TextEditingController commissionAmount =
      TextEditingController(text: model.commissionAmt.toString());
  TextEditingController dob = TextEditingController(text: todayTextFormat());
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          height: 200,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heading("Confirm Commission?", 25),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  customTextfield(commissionAmount, "Commission Amt", context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: customTextfield(dob, "DD/MM/YYYY", context),
                  ),
                  const Spacer(),
                  customButton("Accept", () {
                    claimCommission(
                        model.commissionId,
                        int.parse(commissionAmount.text),
                        textToDateTime(dob.text));
                    Navigator.pop(context);
                  }, context, isExpanded: false),
                ],
              ),
            ],
          )));
}
