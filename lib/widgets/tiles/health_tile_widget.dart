import '../../shared/exports.dart';

// ignore: must_be_immutable
class HealthTile extends StatelessWidget {
  BuildContext context;
  PolicyHiveModel model;
  HealthTile({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        AppUtils.showSnackMessage(model.policyID, "This is PolicyID");
      },
      onTap: () {
        navigate(
          PolicyDetailPage(model: model),
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
                          productTileText(model.policyNo, 14),
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
                    heading("Sum Assured", 16),
                    productTileText(model.sumAssured.toString(), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Renewal Date", 16),
                    productTileText(dateTimetoText(model.renewalDate), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Premium", 16),
                    productTileText(
                        "${AppUtils.formatAmount(addHealthWithGST(model.premuimAmt))} Rs",
                        14),
                  ],
                ),
                Column(
                  children: [
                    heading("Status", 16),
                    productTileText(model.policyStatus.toString(), 14),
                  ],
                ),
                customButton("View Policy", () async {
                  navigate(
                    PolicyDetailPage(model: model),
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
