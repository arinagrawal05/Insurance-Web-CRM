import '../../shared/exports.dart';

class DoneCommissionsPage extends StatefulWidget {
  final ProductType type;

  const DoneCommissionsPage({super.key, required this.type});
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});
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
    // final provider = Provider.of<FilterProvider>(context, listen: true);
    // final statsProvider = Provider.of<StatsProvider>(context, listen: true);
    // final dashProvider = Provider.of<DashProvider>(context, listen: true);

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
              init: CommissionSearchController(type: widget.type),
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
                          ),
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
      // bottomNavigationBar: totalWidget(context, () {
      //   provider.sumCommission(false, dashProvider.dashName).then((value) {
      //     setState(() {});
      //   });
      // }, provider),
    );
  }
}
