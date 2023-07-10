import 'package:flutter/material.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

class ChooseCompany extends StatelessWidget {
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashProvider>(context, listen: true);

    // TextEditingController controller = TextEditingController();
    return Scaffold(
      // backgroundColor: scaffoldColor,

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chooseHeader("Choose Company", 2),

            // Container(
            //   width: double.infinity,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       customTextField(controller, "Search", context),
            //     ],
            //   ),
            // ),
            streamCompanies(true, dashProvider.dashName)
          ],
        ),
      ),
    );
  }
}
