import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';

import '../../shared/exports.dart';

// ignore: must_be_immutable
class HealthDashboardPage extends StatelessWidget {
  final ProductType type;
  final ScrollController scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();
  final FlipCardController cardFlipController = FlipCardController();

  late TooltipBehavior tooltip = TooltipBehavior();

  HealthDashboardPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    // final statsProvider = Get.find<HealthStatsProvider>();

    // final dashProvider = Get.find<DashProvider>();

    return GetBuilder<GeneralStatsProvider>(
        // init: GeneralStatsProvider(
        //   type: type,
        // ),/
        // init: AppUtils.getStatsController(),
        tag: AppUtils.getStatsControllerTag(),
        builder: (statsProvider) {
          return renderScaffold(
              EnumUtils.convertTypeToKey(type), context, statsProvider);
          // GestureDetector(
          //     onTap: () {
          //       statsProvider.calculatePolicyStatsFromHive();
          //     },
          //     child: Text("data"));

          // renderScaffold(
          //     EnumUtils.convertTypeToKey(type), context, statsProvider);
        });
  }

  Scaffold renderScaffold(
      String name, BuildContext context, GeneralStatsProvider statsProvider) {
    return Scaffold(
      appBar: customAppbar("$name Dashboard", context),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (rawKeyEvent) {
          handleKeyEvent(rawKeyEvent, scrollController);
          // throw Exception('No return value');
        },
        child: SingleChildScrollView(
          controller: scrollController,
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
                                      // dashProvider.changePage(
                                      //     CurrentPage.clients);
                                      print("Called");
                                      statsProvider
                                          .calculatePolicyStatsFromHive();

                                      // cardFlipController.flipcard();
                                    },
                                    child: statsBox(
                                        "${UserHiveHelper.userBox.length} Clients",
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
                                      "${statsProvider.getPolicyCount} $name",
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
                                              flex: 3,
                                              child: greetBox(context)),
                                          Expanded(
                                            flex: 9,
                                            child: policyCountCircularChart(
                                                "$name", context, tooltip),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: companyChart(tooltip, context,
                                          cardFlipController)),
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
                              child: policyCircularChart(
                                  "$name", context, tooltip),
                            ),
                            Expanded(flex: 5, child: birthdayWidget(context))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                type == ProductType.health
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: heading("Graced Renewal", 20),
                          ),
                          streamRenewals(
                              true, PolicyHiveHelper.getGracedPolicies()),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: heading("Upcoming Renewal", 20),
                          ),
                          streamRenewals(
                              false, PolicyHiveHelper.getUpcomingPolicies())
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: heading("Due for Renewal", 20),
                          ),
                          streamRenewals(
                              true, PolicyHiveHelper.getMaturatedFDs()),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: heading("Upcoming Renewals", 20),
                          ),
                          streamRenewals(
                              false, PolicyHiveHelper.getUpcomingFds())
                        ],
                      )
              ]),
        ),
      ),
    );
  }
}

Widget greetBox(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    decoration: dashBoxDex(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading("Good Morning", 20),
        simpleText("“Always remember that you are absolutely unique.”", 15),
        const SizedBox(
          height: 10,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //         child:
        //             simpleText("~Mahatma Gandhi", 13, align: TextAlign.right)),
        //   ],
        // )
      ],
    ),
  );
}
