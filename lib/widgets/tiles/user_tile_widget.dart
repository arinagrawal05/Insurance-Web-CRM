import '/providers/motor_provider.dart';
import '../../shared/exports.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class UserTile extends StatelessWidget {
  UserHiveModel model;
  bool isChoosing;
  UserTile({super.key, required this.model, required this.isChoosing});

  @override
  Widget build(BuildContext context) {
    final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
    final fdProvider = Provider.of<FDProvider>(context, listen: false);
    final lifeProvider = Provider.of<LifeProvider>(context, listen: false);
    final generalProvider = Provider.of<MotorProvider>(context, listen: false);

    final dashProvider = Get.find<DashProvider>();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return InkWell(
      onLongPress: () {
        AppUtils.showSnackMessage(model.userid, "This is userid");
      },
      onTap: isChoosing
          ? () {
              if (dashProvider.currentDashBoard == ProductType.health) {
                policyProvider.setClient(
                    model.userid,
                    model.name,
                    model.email,
                    model.dob,
                    model.address,
                    model.phone,
                    model.isMale,
                    model.membersCount);
                navigate(ChooseCompany(), context);
              } else if (dashProvider.currentDashBoard == ProductType.life) {
                lifeProvider.setHeadClient(model.userid, model.name,
                    model.email, model.address, model.phone);
                navigate(
                    ChooseMember(
                        headName: model.name, headUserid: model.userid),
                    context);
              } else if (dashProvider.currentDashBoard == ProductType.motor) {
                generalProvider.setHeadClient(model.userid, model.name,
                    model.email, model.address, model.phone);
                navigate(
                    ChooseMember(
                        headName: model.name, headUserid: model.userid),
                    context);
              } else {
                fdProvider.setHeadClient(model.userid, model.name, model.email,
                    model.address, model.phone);
                navigate(
                    ChooseMember(
                        headName: model.name, headUserid: model.userid),
                    context);
              }

              print("Choosing");
            }
          : () {
              userProvider.changeMemberCount(model.membersCount);
              userProvider.setUserid(model.userid);
              navigate(
                  UserDetailPage(
                    model: model,
                  ),
                  context);
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
                  width: 290,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: model.isMale
                            ? Colors.blueAccent
                            : Colors.pinkAccent,
                        child: Center(
                          child: Icon(
                              model.isMale ? Ionicons.male : Ionicons.female),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heading(model.name, 16),
                          productTileText(model.email, 14),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    heading("Phone", 16),
                    productTileText(model.phone, 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Age", 16),
                    productTileText(
                        timeago.format(model.dob,
                            allowFromNow: true, locale: 'en_short'),
                        14),
                  ],
                ),
                Column(
                  children: [
                    heading("Gender", 16),
                    productTileText(model.isMale ? "Male" : "Female", 14),
                  ],
                ),
                Column(
                  children: [
                    heading("Members", 16),
                    productTileText(model.membersCount.toString(), 14),
                  ],
                ),
                if (!isChoosing)
                  customButton("View User", () async {
                    userProvider.changeMemberCount(model.membersCount);

                    userProvider.setUserid(model.userid);
                    navigate(
                        UserDetailPage(
                          model: model,
                        ),
                        context);
                    // addMemberSheet(context, widget.userid, docId);
                  }, context, isExpanded: false),
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
