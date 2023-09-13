import 'package:health_model/widgets/tiles/health_tile_widget.dart';
import 'package:health_model/widgets/tiles/motor_tile_widget.dart';

import 'hive/hive_model/policy_models/generic_investment_data.dart';

import '../../shared/exports.dart';
import 'widgets/tiles/fd_tile_widget.dart';
import 'widgets/tiles/life_tile_widget.dart';

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
    final dashProvider = Get.find<DashProvider>();
    final searchController = Get.put(PolicySearchController(type: widget.type),
        tag: widget.type.name);
    return Scaffold(
        // backgroundColor: scaffoldColor,
        appBar: customAppbar("Clients Data", context),
        body: RawKeyboardListener(
          includeSemantics: true,
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
                        searchController.changeStatus(value);
                      },
                      context,
                    ),
                    filterTooltip(searchController, context),
                    customButton("Add ${dashProvider.currentDashBoard.name}",
                        () async {
                      policyProvider.clearPort();
                      // UserHiveHelper.fetchUsersFromFirebase();
                      // PolicyHiveHelper.init();

                      navigate(
                        const ChooseUser(),
                        context,
                      );
                    }, context, isExpanded: false),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<PolicySearchController>(
                    init: searchController,
                    didChangeDependencies: (state) {
                      print('RRRR didChangeDependencies called');
                    },
                    didUpdateWidget: (oldWidget, state) {
                      print('RRRR didUpdateWidget called');
                    },
                    initState: (state) {
                      print('RRRR initState called');
                      // searchController.filterpolicies();
                    },
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

                              return HealthTile(
                                  context: context, model: policyModel);
                            } else {
                              if (currentModel is FdHiveModel) {
                                FdHiveModel fdModel = currentModel;

                                return FDTile(
                                  context: context,
                                  model: fdModel,
                                );
                              } else {
                                if (currentModel is LifeHiveModel) {
                                  LifeHiveModel lifeModel = currentModel;

                                  return LifeTile(
                                      context: context, model: lifeModel);
                                } else {
                                  if (currentModel is MotorHiveModel) {
                                    MotorHiveModel motorModel = currentModel;

                                    return MotorTile(
                                        context: context, model: motorModel);
                                  } else {
                                    return Container();
                                  }
                                }
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
