import 'package:flutter/material.dart';
import 'package:health_model/shared/keyboard_listener.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/charts.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class HealthDashboardPage extends StatelessWidget {
  final ScrollController controller = ScrollController();

  final FocusNode _focusNode = FocusNode();

  late TooltipBehavior tooltip = TooltipBehavior();

  HealthDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final statsProvider =
        Provider.of<HealthStatsProvider>(context, listen: true);

    final dashProvider = Provider.of<DashProvider>(context, listen: true);

    return Scaffold(
      appBar: customAppbar("Health Dashboard", context),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (rawKeyEvent) {
          handleKeyEvent(rawKeyEvent, controller);
          // throw Exception('No return value');
        },
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 20,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    dashProvider.changeHealthDash(1);
                                  },
                                  child: statsBox(
                                      "${statsProvider.users_count} Clients",
                                      Ionicons.person,
                                      context),
                                ),
                                statsBox(
                                    "${statsProvider.companies_count} Companies",
                                    Ionicons.build_outline,
                                    context),
                                statsBox("${statsProvider.plans_count} Plans",
                                    Ionicons.reader_outline, context),
                                statsBox(
                                    "${statsProvider.policies_count} Policies",
                                    Ionicons.receipt_outline,
                                    context),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 3, child: greetBox(context)),
                                        Expanded(
                                          flex: 9,
                                          child: policyCountCircularChart(
                                              context, tooltip),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: companyChart(tooltip, context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 4,
                              child: policyCircularChart(context, tooltip)),
                          Expanded(flex: 5, child: birthdayWidget(context))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: heading("Graced Renewal", 20),
              ),
              streamRenewals(true, oneMonthAgo, now),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: heading("Upcoming Renewal", 20),
              ),
              streamRenewals(false, now, oneMonthMore),
            ],
          ),
        ),
      ),
    );
  }
}

Widget greetBox(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(15),
    decoration: dashBoxDex(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading("Good Morning", 20),
        simpleText("“Always remember that you are absolutely unique.”", 15),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child:
                    simpleText("~Mahatma Gandhi", 13, align: TextAlign.right)),
          ],
        )
      ],
    ),
  );
}
