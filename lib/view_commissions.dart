import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_model/done_commision.dart';
import 'package:health_model/getx/commission_search_controller.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/keyboard_listener.dart';
import 'package:health_model/shared/local_streams.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/widgets/tiles/commission_tile_widget.dart';
import 'package:provider/provider.dart';

class CommissionsPage extends StatefulWidget {
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  State<CommissionsPage> createState() => _CommissionsPageState();
}

class _CommissionsPageState extends State<CommissionsPage> {
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  bool isUnlocked = true;

  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: true);
    final statsProvider =
        Provider.of<HealthStatsProvider>(context, listen: true);
    final dashProvider = Provider.of<DashProvider>(context, listen: false);

    // TextEditingController controller = TextEditingController();
    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar: customAppbar("Pending Commission", context),
      body: RawKeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKey: (rawKeyEvent) {
            handleKeyEvent(rawKeyEvent, scrollController);
            // throw Exception('No return value');
          },
          child: isUnlocked
              ? GetBuilder<CommissionSearchController>(
                  init: CommissionSearchController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customTextfield(controller.searchController,
                                  "Search", context, onChange: (value) {
                                controller.filterCommissions(value);
                              }),
                              genericPicker(
                                provider.companyList,
                                provider.companyFilter,
                                "Company",
                                (value) {
                                  provider.changeCompany(value);
                                },
                                context,
                              ), // customTextField(controller, "Search", context),
                              customButton("View Received Commision", () async {
                                // setState(() {});
                                navigate(DoneCommissionsPage(), context);
                              }, context, isExpanded: false),
                            ],
                          ),
                        ),
                        // streamUsers(false),
                        // userStream(dashProvider, false)

                        Expanded(
                          child: ListView.builder(
                              controller: scrollController,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.commissions.length,
                              itemBuilder: (context, index) {
                                return CommissionTile(
                                    model: controller.commissions[index]);
                              }),
                        )
                      ],
                    );
                  })
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(20),
                          // elevation: 5,
                          decoration: dashBoxDex(context),
                          child: Column(
                            children: [
                              heading("Enter Admin Pin", 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: formTextField(
                                    pinController, "Enter Pin", "Wrong Pin",
                                    kType: TextInputType.number),
                              ),
                              customButton("Unlock", () {
                                if (pinController.text ==
                                    statsProvider.adminPin) {
                                  provider
                                      .sumCommission(
                                          true, dashProvider.dashName)
                                      .then((value) {
                                    setState(() {});
                                  });
                                  // _focusNode.nextFocus();
                                  setState(() {
                                    isUnlocked = true;
                                  });
                                } else {
                                  print("pin Wrong");
                                }
                              }, context, isExpanded: false),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

      bottomNavigationBar: isUnlocked
          ? totalWidget(context, () {
              provider.sumCommission(true, dashProvider.dashName).then((value) {
                setState(() {});
              });
            }, provider)
          : null,
    );
  }
}
