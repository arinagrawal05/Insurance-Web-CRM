import 'package:flutter/material.dart';
import 'package:health_model/shared/keyboard_listener.dart';
import 'package:health_model/shared/local_streams.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

class DoneCommissionsPage extends StatefulWidget {
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  State<DoneCommissionsPage> createState() => _DoneCommissionsPageState();
}

class _DoneCommissionsPageState extends State<DoneCommissionsPage> {
  final ScrollController controller = ScrollController();
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
          handleKeyEvent(rawKeyEvent, controller);
          // throw Exception('No return value');
        },
        child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      customTextfield(searchController, "Search", context,
                          onChange: (value) {
                        dashProvider.searchCommission(value);
                      }),
                      genericPicker(
                        provider.companyList,
                        provider.companyFilter,
                        "Company",
                        (value) {
                          provider.changeCompany(value);
                        },
                        context,
                      ),
                    ],
                  ),
                  commissionStream(
                      dashProvider,
                      false,
                      dashProvider.dashName,
                      provider.companyFilter,
                      provider.fromDate,
                      provider.toDate)
                  // streamCommissions(
                  //     false,
                  //     dashProvider.dashName,
                  //     provider.companyFilter,
                  //     provider.fromDate,
                  //     provider.toDate),
                ],
              ),
            )),
      ),
      bottomNavigationBar: totalWidget(context, () {
        provider.sumCommission(false, dashProvider.dashName).then((value) {
          setState(() {});
        });
      }, provider),
    );
  }
}
