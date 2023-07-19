import '../../shared/exports.dart';

class DoneCommissionsPage extends StatefulWidget {
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  State<DoneCommissionsPage> createState() => _DoneCommissionsPageState();
}

class _DoneCommissionsPageState extends State<DoneCommissionsPage> {
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  // List<String>? selectedDataString;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: true);
    // final statsProvider = Provider.of<StatsProvider>(context, listen: true);
    final dashProvider = Provider.of<DashProvider>(context, listen: true);

    // TextEditingController controller = TextEditingController();
    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar: customAppbar("recieved Commission", context),
      body: RawKeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKey: (rawKeyEvent) {
            handleKeyEvent(rawKeyEvent, scrollController);
            // throw Exception('No return value');
          },
          child: GetBuilder<CommissionSearchController>(
              init: CommissionSearchController(),
              builder: (controller) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customTextfield(
                              controller.searchController, "Search", context,
                              onChange: (value) {
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
              })),
      bottomNavigationBar: totalWidget(context, () {
        provider.sumCommission(false, dashProvider.dashName).then((value) {
          setState(() {});
        });
      }, provider),
    );
  }
}
