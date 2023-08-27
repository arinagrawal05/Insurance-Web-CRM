import 'package:health_model/add_user.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/shared/statements.dart';

import 'hive/hive_model/policy_models/life_model.dart';

// ignore: must_be_immutable
class UserDetailPage extends StatefulWidget {
  UserHiveModel model;
  UserDetailPage({required this.model});
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late TooltipBehavior tooltip = TooltipBehavior();
  // AsyncSnapshot<QuerySnapshot<Object?>>? snap;
  // late Stream<DocumentSnapshot<Object?>> documentStream;
  // late List<DocumentSnapshot<Object?>> initialSnapshot = [];
  // bool isTherePolicy = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    UserHiveModel model = widget.model;
    // final provider = Provider.of<PolicyProvider>(context, listen: false);
    final dashProvider = Get.find<DashProvider>();

    return Scaffold(
      appBar: genericAppbar(actions: [
        customButton("Edit", () async {
          userProvider.changeMemberCount(model.membersCount);
          navigate(
              AddUserPage(
                model: model,
                userid: model.userid,
              ),
              context);
          // addMemberSheet(context, widget.userid, docId);
        }, context, isExpanded: false),
        customDeleteButton(Ionicons.trash_outline, Colors.red.shade500,
            () async {
          genericConfirmSheet(context, Statements.removeClient, "Client", () {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(model.userid)
                .delete()
                .then((value) {
              UserHiveHelper.fetchUsersFromFirebase();

              Navigator.pop(context);

              Navigator.pop(context);
            });
          });
        }, context),
      ]),
      body:
          //  streamPoliciesByUser(model.userid, dashProvider)

          SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.all(20),
          padding: const EdgeInsets.all(30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 40),
                              height: 300,
                              // decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //   image: NetworkImage(
                              //     "https://media.istockphoto.com/id/1287754287/vector/liquid-style-colorful-pastel-abstract-background-with-elements-vector.jpg?s=612x612&w=0&k=20&c=uIHo_HvNo9VgTIlnHXgoPNVSLfkl67ARKqiW1bWqcug=",
                              //    ),
                              // )),
                              child: cachedImage(
                                "https://media.istockphoto.com/id/1287754287/vector/liquid-style-colorful-pastel-abstract-background-with-elements-vector.jpg?s=612x612&w=0&k=20&c=uIHo_HvNo9VgTIlnHXgoPNVSLfkl67ARKqiW1bWqcug=",
                              ),
                            )),
                        Container(
                          width: 900,
                          padding: const EdgeInsets.all(20),
                          decoration: dashBoxDex(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.network(
                                      "https://static.vecteezy.com/system/resources/previews/024/492/706/original/man-head-user-profile-character-vector.jpg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  heading(model.name, 25),
                                  heading(model.email, 20),
                                ],
                              ),
                              const Spacer(),
                              customDeleteButton(
                                  Ionicons.mail, Colors.yellowAccent.shade100,
                                  () {
                                launchURL(
                                    "mailto:${model.email}?subject=This is Regarding your policy&body=Hello${AppUtils.getFirstWord(model.name)}");
                              }, context),
                              customDeleteButton(Ionicons.logo_whatsapp,
                                  Colors.greenAccent.shade100, () {
                                launchURL(
                                    "https://wa.me/${model.phone}?text=Hi ${AppUtils.getFirstWord(model.name)},");
                              }, context),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: userProvider
                          .getPoliciesByUser(widget.model.userid)
                          .length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (userProvider
                                    .getPoliciesByUser(
                                        widget.model.userid)[index]
                                    .data!
                                    .type ==
                                EnumUtils.convertTypeToKey(
                                    dashProvider.currentDashBoard) ||
                            dashProvider.currentDashBoard == ProductType.cms) {
                          if (userProvider
                                  .getPoliciesByUser(widget.model.userid)[index]
                                  .data!
                                  .type ==
                              EnumUtils.convertTypeToKey(ProductType.health)) {
                            return policyTile(
                                context,
                                userProvider
                                    .getPoliciesByUser(
                                        widget.model.userid)[index]
                                    .data as PolicyHiveModel);
                          } else if (userProvider
                                  .getPoliciesByUser(widget.model.userid)[index]
                                  .data!
                                  .type ==
                              EnumUtils.convertTypeToKey(ProductType.life)) {
                            return lifeTile(
                                context,
                                userProvider
                                    .getPoliciesByUser(
                                        widget.model.userid)[index]
                                    .data as LifeHiveModel);
                          } else {
                            return fdTile(
                                context,
                                userProvider
                                    .getPoliciesByUser(
                                        widget.model.userid)[index]
                                    .data as FdHiveModel);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: dashBoxDex(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: heading("Members", 20),
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              streamMembers(
                                model.userid,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: dashBoxDex(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: heading("Details", 20),
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              userDetailShow("phone", model.phone,
                                  Ionicons.phone_portrait_outline),
                              userDetailShow(
                                  "email", model.email, Ionicons.mail),
                              userDetailShow(
                                  "Birthday",
                                  dateTimetoText(model.dob),
                                  Ionicons.medical_outline),
                              userDetailShow(
                                  "Gender",
                                  model.isMale ? "Male" : "Female",
                                  model.isMale
                                      ? Ionicons.man_outline
                                      : Ionicons.woman_outline),
                              userDetailShow("Address", model.address,
                                  Ionicons.home_outline),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
