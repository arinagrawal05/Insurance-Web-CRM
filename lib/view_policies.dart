import 'package:flutter/material.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/keyboard_listener.dart';
import 'package:health_model/shared/local_streams.dart';
import 'package:health_model/policy_flow/choose_user.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/shared/widgets.dart';

import 'package:provider/provider.dart';

class PoliciesPage extends StatefulWidget {
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  final ScrollController controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: true);
    final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
    final dashProvider = Provider.of<DashProvider>(context, listen: false);

    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar:
          customAppbar("Clients ${getWord(dashProvider.dashName)}", context),
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
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customTextfield(
                        dashProvider.policyController, "Search", context,
                        onChange: (value) {
                      dashProvider.searchPolicy(value);
                    }),
                    genericPicker(
                      filterProvider.companyList,
                      filterProvider.companyFilter,
                      "Company",
                      (value) {
                        filterProvider.changeCompany(value);
                      },
                      context,
                    ),
                    genericPicker(
                      filterProvider.getStatusList(dashProvider.dashName),
                      filterProvider.statusFilter,
                      "Status",
                      (value) {
                        filterProvider.changeStatus(value);
                      },
                      context,
                    ),
                    customButton("Add ${dashProvider.dashName}", () async {
                      policyProvider.clearPort();
                      dashProvider.resetUserList();

                      navigate(
                        ChooseUser(),
                        context,
                      );
                    }, context, isExpanded: false),
                  ],
                ),
              ),
              policyStream(
                  dashProvider,
                  false,
                  filterProvider.companyFilter,
                  filterProvider.statusFilter,
                  filterProvider.fromDate,
                  filterProvider.toDate),
              // streamPolicies(
              //     false,
              //     filterProvider.companyFilter,
              //     filterProvider.statusFilter,
              //     filterProvider.fromDate,
              //     filterProvider.toDate

              //  )
            ],
          ),
        ),
      ),
    );
  }
}
