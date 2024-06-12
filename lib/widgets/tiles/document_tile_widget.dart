import 'package:health_model/hive/hive_model/doc_hive_model.dart';

import '/hive/hive_model/commission_models/commission_hive_model.dart';

import '../../shared/exports.dart';
// import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class DocumentTile extends StatelessWidget {
  DocHiveModel model;
  DocumentTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    // final statsProvider = Get.find<HealthStatsProvider>();
    return InkWell(
      onLongPress: () {
        AppUtils.showSnackMessage(model.docId + " is presented", "");
      },
      // onDoubleTap: () {
      //   // AppUtils.showSnackMessage(model.commissionId + " is deleted", "");
      //   FirebaseFirestore.instance
      //       .collection("Commission")
      //       .doc(model.commissionId)
      //       .delete()
      //       .then((value) {
      //     AppUtils.showSnackMessage(model.commissionId + " is deleted", "");
      //   });
      // },
      child: Container(
        // height: 120,
        // width: 250,    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),

        decoration: dashBoxDex(context),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    // color: Colors.amber,
                    // width: 250,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading(model.docName, 16),
                            productTileText(model.docType, 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      heading("Belongs", 16),
                      productTileText(model.name.toString(), 14),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      heading("Format", 16),
                      productTileText(model.docFormat.toString(), 14),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      heading("Date Created", 16),
                      productTileText(dateTimetoText(model.docCreated), 14),
                    ],
                  ),
                ),
                customButton("Download", () async {
                  launchURL(model.docUrl);
                }, context, isExpanded: false)
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Widget commissionTile(BuildContext context, CommissionModel model) {


  // Timestamp time = model["d;
// }
