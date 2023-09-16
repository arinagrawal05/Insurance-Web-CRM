import '../../shared/exports.dart';

void addPlanSheet(
  BuildContext context,
  String companyId,
  String planId,
  //  int count
) {
  final name = TextEditingController();
  // final provider = Get.find<GeneralStatsProvider>(
  //   tag: AppUtils.getStatsControllerTag(),
  // );

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          // height: 500,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading("Add Plan", 25),
              formTextField(
                name,
                "Plan Name",
                "Enter Plan Name",
                FieldRegex.nameRegExp,
              ),
              const SizedBox(
                height: 40,
              ),
              customButton("Add Plan", () {
                // if (_addBrandKey.currentState?.validate() == true) {
                FirebaseFirestore.instance
                    .collection("Companies")
                    .doc(companyId)
                    .collection("Plans")
                    .doc(planId)
                    .set({
                  "plan_name": name.text,
                  "plan_id": planId,
                  "company_id": companyId,
                  "timestamp": Timestamp.now(),
                }).then((value) {
                  print("Successfully Plan Added");

                  Navigator.pop(context);
                  print(planId);
                });

                // }
              }, context)
            ],
          )));
}
