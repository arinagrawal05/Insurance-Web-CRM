import 'package:health_model/models/policy_model.dart';

import 'hive/hive_model/policy_models/generic_investment_data.dart';
import 'hive/hive_model/policy_models/policy_model.dart';

import '../../shared/exports.dart';

class PoliciesPage extends StatefulWidget {
  final ProductType type;

  const PoliciesPage({super.key, required this.type});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final filterProvider = Provider.of<FilterProvider>(context, listen: true);
    final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
    final dashProvider = Provider.of<DashProvider>(context, listen: false);
    final searchController = Get.put(PolicySearchController(type: widget.type),
        tag: widget.type.name);
    return Scaffold(
        // backgroundColor: scaffoldColor,
        appBar:
            customAppbar("Clients ${getWord(dashProvider.dashName)}", context),
        body: RawKeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKey: (rawKeyEvent) {
            handleKeyEvent(rawKeyEvent, scrollController);
            // throw Exception('No return value');
          },
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customTextfield(
                        searchController.searchController, "Search", context,
                        onChange: (value) {
                      searchController.filterpolicies();
                    }),
                    genericPicker(
                      searchController.companyList,
                      searchController.companyFilter,
                      "Company",
                      (value) {
                        searchController.changeCompany(value);
                      },
                      context,
                    ),
                    genericPicker(
                      searchController.getCurrentStatusList,
                      searchController.getCurrentStatusList[0],
                      "Status",
                      (value) {
                        // controller.changeStatus(healthStatus: HealthStatus.allStatus);
                      },
                      context,
                    ),
                    customButton("Add ${dashProvider.dashName}", () async {
                      policyProvider.clearPort();
                      // UserHiveHelper.fetchUsersFromFirebase();

                      navigate(
                        ChooseUser(),
                        context,
                      );
                    }, context, isExpanded: false),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<PolicySearchController>(
                    init: searchController,
                    builder: (controller) {
                      return ListView.builder(
                          controller: scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: controller.policies.length,
                          itemBuilder: (context, index) {
                            GenericInvestmentHiveData? currentModel =
                                controller.policies[index].data;

                            if (currentModel == null) {
                              return Container();
                            }

                            if (currentModel is PolicyHiveModel) {
                              PolicyHiveModel policyModel = currentModel;

                              return policyTile(
                                context,
                                policyModel,
                              );
                            } else {
                              if (currentModel is FdHiveModel) {
                                FdHiveModel fdModel = currentModel;

                                return fdTile(
                                  context,
                                  fdModel,
                                );
                              } else {
                                return Container();
                              }
                            }
                          });
                    }),
              )
              // streamPolicies(
              //     false,
              //     filterProvider.companyFilter,
              //     filterProvider.statusFilter,
              //     filterProvider.fromDate,
              //     filterProvider.toDate

              //  )
            ],
          ),
        ));
  }
}
