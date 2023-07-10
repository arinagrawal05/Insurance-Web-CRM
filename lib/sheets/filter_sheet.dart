import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';

void filterSheet(BuildContext context, FilterProvider provider) {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController(text: todayTextFormat());
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          alignment: Alignment.center,
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
              Center(child: heading("Add Filters", 30)),
              const SizedBox(
                height: 40,
              ),
              productTileText("Predefined Filters", 25),
              Row(
                children: [
                  customButton("By Week", () {
                    provider.filterByWeek();
                    Navigator.pop(context);
                    provider.clearSum();
                  }, context, isExpanded: false),
                  customButton("By Month", () {
                    provider.filterByMonth();
                    provider.clearSum();

                    Navigator.pop(context);
                  }, context, isExpanded: false),
                  customButton("By 3 Months", () {
                    provider.filterByThreeMonths();
                    provider.clearSum();

                    Navigator.pop(context);
                  }, context, isExpanded: false),
                  customButton("By 6 Months", () {
                    provider.filterBySixMonths();
                    provider.clearSum();

                    Navigator.pop(context);
                  }, context, isExpanded: false),
                  customButton("By Year", () {
                    provider.filterByYear();
                    provider.clearSum();

                    Navigator.pop(context);
                  }, context, isExpanded: false),
                  customButton("Till Now", () {
                    provider.filterByTillNow();
                    provider.clearSum();

                    Navigator.pop(context);
                  }, context, isExpanded: false),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              productTileText("Manual Filters", 25),
              Row(
                children: [
                  simpleText("  From  ", 20),
                  customTextfield(fromDate, "DD/MM/YYYY", context),
                  simpleText("  To ", 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: customTextfield(toDate, "DD/MM/YYYY", context),
                  ),
                  const Spacer(),
                  customButton("Filter", () {
                    provider.filterByManual(textToDateTime(fromDate.text),
                        textToDateTime(toDate.text));
                    provider.clearSum();

                    Navigator.pop(context);
                  }, context, isExpanded: false),
                ],
              ),
            ],
          )));
}
