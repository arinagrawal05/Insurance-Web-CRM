// import '/pages/fd_module/fd_detail.dart';

import '../../pages/fd_module/fd_detail.dart';
import '../../shared/exports.dart';

// ignore: must_be_immutable
class FDTile extends StatelessWidget {
  BuildContext context;
  FdHiveModel model;
  FDTile({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        AppUtils.showSnackMessage(model.fdId, "This is Fd Id");
      },
      onTap: () {
        navigate(
          FdDetailPage(model: model),
          context,
        );
        // addMemberSheet(context, widget.userid, docId);
      },
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
                SizedBox(
                  // color: Colors.amber,
                  width: 300,
                  child: Row(
                    children: [
                      companyLogo(model.companyLogo),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heading(model.name, 16),
                          productTileText(model.fdNo, 14),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    heading("Company", 16),
                    productTileText(
                        AppUtils.getFirstWord(model.companyName.toString()),
                        14),
                  ],
                ),
                Column(
                  children: [
                    heading("Invested Date", 16),
                    productTileText(dateTimetoText(model.initialDate), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Sum Invested", 16),
                    productTileText(
                        "${AppUtils.formatAmount(model.investedAmt)} Rs", 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Maturity Date", 16),
                    productTileText(dateTimetoText(model.renewalDate), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Term", 16),
                    productTileText(model.fDterm.toString(), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Status", 16),
                    productTileText(model.fdStatus.toString(), 14),
                  ],
                ),
                customButton("View FD", () async {
                  navigate(
                    FdDetailPage(model: model),
                    context,
                  );
                  // addMemberSheet(context, widget.userid, docId);
                }, context, isExpanded: false)
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Widget userTile(BuildContext context, ) {


//   // Timestamp time = model["d;
//   return 
// }
