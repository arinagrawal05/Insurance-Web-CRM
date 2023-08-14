import '../../shared/exports.dart';

void confirmRemoveSheet(
  BuildContext context,
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
              heading("Do You Really Want to Remove this $type", 25),
              Spacer(),
              Column(
                children: [
                  customButton("Back", () {
                    Navigator.pop(context);
                  }, context, isExpanded: true, color: tabColor),
                  customButton(
                      type != "handover" ? "Remove" : "Handover to Customer",
                      ontap,
                      context,
                      isExpanded: true),
                ],
              ),
            ],
          )));
}
