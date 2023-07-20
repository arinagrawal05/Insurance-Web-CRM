import 'package:health_model/hive/hive_model/commission_models/commission_hive_model.dart';

import '../../shared/exports.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class CommissionTile extends StatelessWidget {
  CommissionHiveModel model;
  CommissionTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final statsProvider =
        Provider.of<HealthStatsProvider>(context, listen: false);
    return InkWell(
      onTap: null,
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
                  width: 250,
                  child: Row(
                    children: [
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
                    productTileText(model.companyName.toString(), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Premium", 16),
                    productTileText(model.premiumAmt.toString(), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Commission", 16),
                    productTileText(model.commissionAmt.toString(), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Prem. Depo Date", 16),
                    productTileText(dateTimetoText(model.commissionDate), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Received", 16),
                    productTileText(
                        model.issuedDate == model.commissionDate
                            ? "NA"
                            : dateTimetoText(model.commissionDate),
                        14),
                  ],
                ),
                model.isPending
                    ? customButton("Receive", () async {
                        confirmCommission(context, model, statsProvider);
                      }, context, isExpanded: false)
                    : customButton(
                        "Received",
                        null,
                        context,
                        isExpanded: false,
                        color: primaryColor.withOpacity(0.2),
                      )
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
