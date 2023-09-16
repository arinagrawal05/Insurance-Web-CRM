import '/shared/exports.dart';

Widget webDashboardBody(
    ProductType type,
    BuildContext context,
    GeneralStatsProvider statsProvider,
    FocusNode focusNode,
    FlipCardController cardFlipController,
    TooltipBehavior tooltip,
    ScrollController scrollController) {
  return Scaffold(
    appBar:
        customAppbar("${EnumUtils.convertTypeToKey(type)} Dashboard", context),
    body: RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
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
                                    "${statsProvider.getPolicyCount} ${EnumUtils.convertTypeToKey(type)}",
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
                                              EnumUtils.convertTypeToKey(type),
                                              context,
                                              tooltip),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: companyChart(
                                        tooltip, context, cardFlipController)),
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
                                EnumUtils.convertTypeToKey(type),
                                context,
                                tooltip),
                          ),
                          Expanded(flex: 5, child: birthdayWidget(context))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              renewalList(type),
              // Text(statsProvider
              //     .mySelectedEvents[DateTime(2023, 9, 10, 0, 0, 0, 291)]![0]
              //         ["model"]
              //     .name),
              // HealthTile(
              //     model: statsProvider.mySelectedEvents[
              //             DateTime(2023, 9, 10, 0, 0, 0, 291)]![0]["model"]
              //         as PolicyHiveModel,
              //     context: context),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 600,
                  width: double.infinity,
                  child: EventCalendarScreen(
                    mySelectedEvents: statsProvider.mySelectedEvents
                        as Map<DateTime, List<GenericInvestmentHiveData>>,
                  ))
            ]),
      ),
    ),
  );
}

Widget renewalList(ProductType type) {
  return Container(
    child: type == ProductType.life
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PolicyHiveHelper.getGracedLifes().isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: heading("Graced Life Renewal", 20),
                    ),
              streamRenewals(true, PolicyHiveHelper.getGracedLifes()),
              PolicyHiveHelper.getUpcomingLifes().isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: heading("Upcoming Life Renewal", 20),
                    ),
              streamRenewals(false, PolicyHiveHelper.getUpcomingLifes())
            ],
          )
        : type == ProductType.health
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PolicyHiveHelper.getGracedPolicies().isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: heading("Graced Renewal", 20),
                        ),
                  streamRenewals(true, PolicyHiveHelper.getGracedPolicies()),
                  PolicyHiveHelper.getUpcomingPolicies().isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: heading("Upcoming Renewal", 20),
                        ),
                  streamRenewals(false, PolicyHiveHelper.getUpcomingPolicies())
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PolicyHiveHelper.getMaturatedFDs().isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: heading("Due for Renewal", 20),
                        ),
                  streamRenewals(true, PolicyHiveHelper.getMaturatedFDs()),
                  PolicyHiveHelper.getUpcomingFds().isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: heading("Upcoming Renewals", 20),
                        ),
                  streamRenewals(false, PolicyHiveHelper.getUpcomingFds())
                ],
              ),
  );
}

Widget mobileDashboardBody(
  ProductType type,
  BuildContext context,
  GeneralStatsProvider statsProvider,
  FlipCardController cardFlipController,
  TooltipBehavior tooltip,
) {
  return Scaffold(
    drawer: toShowInMobile(child: customDrawer(), show: true),
    appBar: customAppbar("${EnumUtils.convertTypeToKey(type)}", context),
    body: SingleChildScrollView(
      // controller: scrollController,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         // dashProvider.changePage(
            //         //     CurrentPage.clients);
            //         print("Called");
            //         statsProvider.calculatePolicyStatsFromHive();

            //         // cardFlipController.flipcard();
            //       },
            //       child: statsBox("${UserHiveHelper.userBox.length} Clients",
            //           Ionicons.person, context),
            //     ),
            //     statsBox("${statsProvider.companies_count} Phone",
            //         Ionicons.build_outline, context),
            //   ],
            // ),
            // Row(
            //   children: [
            //     statsBox("${statsProvider.plans_count} Plans",
            //         Ionicons.reader_outline, context),
            //     statsBox(
            //         "${statsProvider.getPolicyCount} ${EnumUtils.convertTypeToKey(type)}",
            //         Ionicons.receipt_outline,
            //         context),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: greetBox(context),
            ),
            Container(
                padding: EdgeInsets.all(10),
                width: SizeConfig.screenWidth! - 20,
                height: SizeConfig.screenHeight! / 1.7,
                child: companyChart(tooltip, context, cardFlipController)),
            Container(
              padding: EdgeInsets.all(10),
              width: SizeConfig.screenWidth! - 20,
              height: SizeConfig.screenHeight! / 1.7,
              child: policyCircularChart(
                  EnumUtils.convertTypeToKey(type), context, tooltip),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: SizeConfig.screenWidth! - 20,
              height: SizeConfig.screenHeight! / 1.7,
              child: policyCountCircularChart(
                  "${EnumUtils.convertTypeToKey(type)}", context, tooltip),
            ),

            renewalList(type)
          ]),
    ),
  );
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
        // const SizedBox(
        //   height: 10,
        // ),
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

Widget statsBox(String count, IconData icon, BuildContext context) {
  return AspectRatio(
    aspectRatio: 1,
    child: Container(
      width: 100,
      margin: const EdgeInsets.only(right: 5, bottom: 5, top: 10),
      padding: const EdgeInsets.all(20),
      decoration: dashBoxDex(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                icon,
                size: 22,
              ),
            ),
          ),
          heading1(count, 20)
        ],
      ),
    ),
  );
}

Widget birthdayWidget(BuildContext context) {
  return Container(
      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      // width: 400,
      // height: 335,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: heading("Today's Birthday", 22),
            ),
            // streamUsers(false, isBirthday: true),
          ],
        ),
      ));
}
