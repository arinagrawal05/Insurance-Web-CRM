import '../../shared/exports.dart';

void genericConfirmSheet(
  BuildContext context,
  String statement,
  String type,
  void Function()? ontap,
  //  int count
) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(18),
          // height: 400,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heading(statement, 25),
              const Spacer(),
              Column(
                children: [
                  customButton("Back", () {
                    Navigator.pop(context);
                  }, context, isExpanded: true, color: tabColor),
                  customButton(
                      type == "redeem"
                          ? "Redeem"
                          : type != "handover"
                              ? "Remove"
                              : "Handover to Customer",
                      ontap,
                      context,
                      isExpanded: true,
                      color: type != "handover"
                          ? Colors.red
                          : const Color(0xFF346eeb)),
                ],
              ),
            ],
          )));
}
