import '/sheets/plan_sheet.dart';

import '../../shared/exports.dart';

// ignore: must_be_immutable
class PlansPage extends StatelessWidget {
  String companyName, companyUserid;
  PlansPage({required this.companyName, required this.companyUserid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text("$companyName's Plans"),
        centerTitle: true,
        elevation: 0.2,
        actions: [
          Container(
            margin: const EdgeInsets.all(4.0),
            child: customButton("Add Plan", () {
              var uuid = const Uuid();
              String docId = uuid.v4();
              addPlanSheet(
                context,
                companyUserid,
                docId,
              );
            }, context, isExpanded: false),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: streamPlans(false, companyUserid),
      ),
    );
  }
}
