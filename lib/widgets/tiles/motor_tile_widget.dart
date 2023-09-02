import 'package:health_model/hive/hive_model/policy_models/life_model.dart';
import 'package:health_model/pages/motor_module/motor_detail.dart';
import 'package:health_model/providers/life_provider.dart';

import '../../hive/hive_model/policy_models/motor_model.dart';
import '../../pages/life_module/life_detail.dart';
import '../../shared/exports.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class MotorTile extends StatelessWidget {
  BuildContext context;
  MotorHiveModel model;
  MotorTile({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        AppUtils.showSnackMessage(model.motorNo, "This is Motor Id");
      },
      onTap: () {
        navigate(
          MotorDetailPage(model: model),
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
                  width: 270,
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
                          productTileText(model.motorNo, 14),
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
                    heading("Registration no.", 16),
                    productTileText(model.vRegistrationNo.toString(), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Premium", 16),
                    productTileText("${model.premiumAmt} Rs", 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Expiry Date", 16),
                    productTileText(dateTimetoText(model.renewalDate), 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Status", 16),
                    productTileText(model.motorStatus.toString(), 14),
                  ],
                ),
                customButton("View Motor", () async {
                  navigate(
                    MotorDetailPage(model: model),
                    context,
                  );
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
