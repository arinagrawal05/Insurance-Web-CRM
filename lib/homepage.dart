import 'package:health_model/hive/hive_helpers/policy_hive_helper.dart';
import '../../shared/exports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TooltipBehavior tooltip = TooltipBehavior();

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    // final provider = Get.find<HealthStatsProvider>();
    // final filterProvider = Provider.of<FilterProvider>(context, listen: true);
    // final policyProvider = Provider.of<PolicyProvider>(context, listen: true);
    // final userProvider = Provider.of<UserProvider>(context, listen: true);
    // final fdProvider = Provider.of<FDProvider>(context, listen: true);

    // final dashProvider = Get.find<DashProvider>();

    return Scaffold(
      body: GetBuilder<FilterProvider>(
          init: FilterProvider(),
          builder: (filterProvider) {
            return GetBuilder<DashProvider>(
                init: DashProvider(),
                builder: (dashProvider) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        homepageAppbar(context),
                        Container(
                          decoration: dashBoxDex(Get.context!),
                          width: double.infinity,
                          padding: const EdgeInsets.all(40),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 40),
                          height: 550,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [bar(), bar(), bar()],
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black45,
                                                style: BorderStyle.solid),
                                            boxShadow: [
                                              // BoxShadow(
                                              //     spreadRadius: 0.1,
                                              //     offset: Offset(0.1, 0.1),
                                              //     blurRadius: 0.3,
                                              //     color: Colors.black45),
                                            ]),
                                        margin: const EdgeInsets.all(15),
                                        height: 83,
                                        width: 220,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            "assets/images/logo.png",
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                  Column(
                                    children: [bar(), bar(), bar()],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  dashWidget(
                                      "Health",
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeR2HyZL1lk9Fw8DeKYNGddtxh7g2C9p1M0EjNJVn6wxtDFJjAyiuHrjdCl87Z9LBQnw&usqp=CAU",
                                      Colors.redAccent.shade100,
                                      Ionicons.heart, () {
                                    dashProvider.navigateToProduct(
                                        ProductType.health, context);

                                    checkGraced();

                                    // navigate(Dash(), context);
                                  }),
                                  dashWidget(
                                      "Life",
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZ9zuc0ypSpZi0vW7S-dWQ4E34_jM3nvBCQ&usqp=CAU",
                                      Colors.cyanAccent.shade100,
                                      Ionicons.nuclear, () {
                                    // print("objectttt");

                                    // updateTemp();
                                  }),
                                  dashWidget(
                                    "General",
                                    "https://carwow-uk.imgix.net/prismic/3521ee46-0e06-4629-b4f7-05106a940c1f_dacia-sandero-01.jpg?auto=format&cs=tinysrgb&fit=clip&ixlib=rb-1.1.0&q=60&w=750",
                                    Colors.blueAccent.shade100,
                                    Ionicons.car,
                                    () {
                                      // deleteTemp();
                                      //   AppUtils.showSnackMessage(
                                      //       "FD Redeemed Successfuly",
                                      //       "This amount is given to client");
                                    },
                                  ),
                                  dashWidget(
                                      "FD",
                                      "https://static.theprint.in/wp-content/uploads/2021/07/moneyv-1.jpg",
                                      Colors.greenAccent.shade100,
                                      Ionicons.wallet, () {
                                    dashProvider.navigateToProduct(
                                        ProductType.fd, context);
                                    checkGraced();
                                  })

                                  // Lotia(),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    // dashProvider.getAllUsers();
                                    // filterProvider.getCompanies(AppConsts.fd);

                                    // fdProvider.getList();
                                    // dashProvider.changeDashName(AppConsts.fd);
                                    navigate(SamplePage(), context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    // width: double.infinity,
                                    decoration: dashBoxDex(context).copyWith(
                                        color: Colors.indigoAccent.shade100),
                                    child: Center(
                                        child: heading("View User CMS", 30)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        stepWidget()
                      ],
                    ),
                  );
                });
          }),
    );
  }

  Widget bar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration:
          dashBoxDex(context).copyWith(color: Colors.indigoAccent.shade100),
      height: 20,
      width: 200,
    );
  }

  Widget stepWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          stepUnitWidget(
              "Onboard User", "Add user as you go", Ionicons.person_add),
          stepUnitWidget(
              "Make Action", "Add user as you go", Ionicons.document_text),
          stepUnitWidget(
              "Claim Commission", "Add user as you go", Ionicons.diamond),
        ],
      ),
    );
  }

  stepUnitWidget(String title, String subtext, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          minRadius: 40,
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading(title, 20),
              const SizedBox(
                height: 5,
              ),
              productTileText(subtext, 10)
            ],
          ),
        )
      ],
    );
  }

  Widget dashWidget(String title, String imageUrl, Color backgroundColor,
      IconData icon, void Function()? ontap) {
    double size = 150;
    return InkWell(
        onTap: ontap,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                // padding: EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: size,
                width: size,

                decoration: dashBoxDex(context).copyWith(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        offset: Offset(0.2, 0.2),
                        blurRadius: 1.0,
                        color: Colors.blueGrey),
                  ],
                  border: Border.all(
                      width: 1.5,
                      color: Colors.black45,
                      style: BorderStyle.solid),
                  image: DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ),
                      fit: BoxFit.cover),

                  // border: Border.all(width: 1, color: Colors.black)
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundColor.withOpacity(0.35)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text("data"),
                      // Image(
                      //   height: size,
                      //   width: size,
                      //   image: NetworkImage(imageUrl),
                      //   fit: BoxFit.cover,
                      // )
                      CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.35),
                          child: Icon(
                            icon,
                            color: Colors.black.withOpacity(0.5),
                            size: 30,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // heading(title, 25),
          ],
        ));
  }
}
