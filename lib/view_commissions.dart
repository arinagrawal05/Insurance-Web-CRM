import 'package:health_model/shared/regex.dart';

import '../../shared/exports.dart';

class CommissionsPage extends StatefulWidget {
  final ProductType type;

  const CommissionsPage({super.key, required this.type});
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

  bool isUnlocked = false;

  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final provider = Get.find<FilterProvider>();
    // final provider = Get.find<HealthStatsProvider>();

    final dashProvider = Get.find<DashProvider>();

    // TextEditingController controller = TextEditingController();
    return GetBuilder<CommissionSearchController>(
        init: CommissionSearchController(type: widget.type, isPending: true),
        tag: '${widget.type}ForPendingCommission',
        builder: (controller) {
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
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customTextfield(controller.searchController,
                                    "Search", context, onChange: (value) {
                                  controller.filterCommissions();
                                }),
                                genericPicker(
                                  controller.companyList,
                                  controller.companyFilter,
                                  "Company",
                                  (value) {
                                    controller.changeCompany(value);
                                  },
                                  context,
                                ), // customTextField(controller, "Search", context),
                                customButton("View Received Commision",
                                    () async {
                                  // setState(() {});
                                  navigate(
                                      DoneCommissionsPage(type: widget.type),
                                      context);
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
                                  if (EnumUtils.convertTypeToKey(widget.type) ==
                                      controller
                                          .commissions[index].commissionType) {
                                    if (controller
                                            .commissions[index].isPending ==
                                        true) {
                                      return CommissionTile(
                                          model: controller.commissions[index]);
                                    }
                                  }
                                  return Container();
                                }),
                          )
                        ],
                      )
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
                                          pinController,
                                          "Enter Pin",
                                          "Wrong Pin",
                                          FieldRegex.integerRegExp,
                                          kType: TextInputType.number),
                                    ),
                                    customButton("Unlock", () {
                                      if (pinController.text ==
                                          dashProvider.adminPin) {
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

            bottomNavigationBar:
                isUnlocked ? totalWidget(controller.currentSum) : null,
          );
        });
  }
}
