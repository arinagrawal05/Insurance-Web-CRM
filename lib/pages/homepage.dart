import '../../../shared/exports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late TooltipBehavior tooltip = TooltipBehavior();

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    // final provider = Get.put(GeneralStatsProvider(type: ProductType.health));

    // final provider = Get.find<GeneralStatsProvider>();

    // final filterProvider = Provider.of<FilterProvider>(context, listen: true);
    // final policyProvider = Provider.of<PolicyProvider>(context, listen: true);
    // final userProvider = Provider.of<UserProvider>(context, listen: true);
    // final fdProvider = Provider.of<FDProvider>(context, listen: true);

    return Scaffold(
      body: GetBuilder<DashProvider>(
          init: DashProvider(),
          builder: (dashProvider) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // heading(provider.mySelectedEvents.toString(), 33),
                  // locked(),
                  homepageAppbar(context),
                  // AnimCard(
                  //   Color(0xffFF6594),
                  //   '50',
                  //   'twenty',
                  //   'Hello',
                  // ),
                  dashWidget(dashProvider, context),
                  const SizedBox(
                    height: 20,
                  ),
                  stepWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  perkWidget(dashProvider.validityDate),
                  const SizedBox(
                    height: 50,
                  ),
                  footerWidget(dashProvider, context)
                ],
              ),
            );
          }),
    );
  }

  Widget lockedWidget(
    DashProvider dashProvider,
  ) {
    return Container(
      width: double.infinity,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("assets/lotties/locked_lottie.json")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heading(
                      "Your Subscription is over ${DateTime.now().difference(dashProvider.validityDate!).inDays} Days ago",
                      35),
                  heading1("Contact Admin ${AppConsts.careEmail1}", 25)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget dashWidget(DashProvider dashProvider, BuildContext context) {
    return dashProvider.validityDate!.isBefore(DateTime.now())
        ? lockedWidget(dashProvider)
        : Container(
            decoration: dashBoxDex(Get.context!),
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
            // height: 550,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dashWidgetHeader(),
                getmobile
                    ? Column(
                        children: [
                          Row(
                            children: [
                              productBoxWidget(
                                  "Health",
                                  // getmobile.toString(),
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeR2HyZL1lk9Fw8DeKYNGddtxh7g2C9p1M0EjNJVn6wxtDFJjAyiuHrjdCl87Z9LBQnw&usqp=CAU",
                                  Colors.redAccent.shade100,
                                  Ionicons.heart, () {
                                dashProvider.navigateToProduct(
                                    ProductType.health, context);

                                checkGraced();
                              }),
                              productBoxWidget(
                                  "Life",
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZ9zuc0ypSpZi0vW7S-dWQ4E34_jM3nvBCQ&usqp=CAU",
                                  Colors.cyanAccent.shade100,
                                  Ionicons.nuclear, () {
                                // print("objectttt");
                                dashProvider.navigateToProduct(
                                    ProductType.life, context);

                                // AppUtils.showSnackMessage(
                                // "This Feature is not deployed yet", "");
                              }),
                            ],
                          ),
                          Row(
                            children: [
                              productBoxWidget(
                                "General",
                                "https://carwow-uk.imgix.net/prismic/3521ee46-0e06-4629-b4f7-05106a940c1f_dacia-sandero-01.jpg?auto=format&cs=tinysrgb&fit=clip&ixlib=rb-1.1.0&q=60&w=750",
                                Colors.blueAccent.shade100,
                                Ionicons.car,
                                () {
                                  // showRenewLifeDialog(AppConsts.lifeModel);
                                  // updateTemp();
                                  // dashProvider.navigateToProduct(
                                  //     ProductType.motor, context);

                                  // navigate(EntervehiclesDetails(), context);
                                  // navigate(LifeDetailPage(model: AppConts.lifeModel), context);
                                  AppUtils.showSnackMessage(
                                      "This Feature is not deployed yet", "");
                                  // deleteTemp();
                                  //   AppUtils.showSnackMessage(
                                  //       "FD Redeemed Successfuly",
                                  //       "This amount is given to client");
                                },
                              ),
                              productBoxWidget(
                                  "FD",
                                  "https://static.theprint.in/wp-content/uploads/2021/07/moneyv-1.jpg",
                                  Colors.greenAccent.shade100,
                                  Ionicons.wallet, () {
                                dashProvider.navigateToProduct(
                                    ProductType.fd, context);
                                checkGraced();
                              })
                            ],
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          productBoxWidget(
                              "Health",
                              // getmobile.toString(),
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeR2HyZL1lk9Fw8DeKYNGddtxh7g2C9p1M0EjNJVn6wxtDFJjAyiuHrjdCl87Z9LBQnw&usqp=CAU",
                              Colors.redAccent.shade100,
                              Ionicons.heart, () {
                            dashProvider.navigateToProduct(
                                ProductType.health, context);

                            checkGraced();
                          }),
                          productBoxWidget(
                              "Life",
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZ9zuc0ypSpZi0vW7S-dWQ4E34_jM3nvBCQ&usqp=CAU",
                              Colors.cyanAccent.shade100,
                              Ionicons.nuclear, () {
                            // print("objectttt");
                            dashProvider.navigateToProduct(
                                ProductType.life, context);

                            // AppUtils.showSnackMessage(
                            // "This Feature is not deployed yet", "");
                          }),
                          productBoxWidget(
                            "General",
                            "https://carwow-uk.imgix.net/prismic/3521ee46-0e06-4629-b4f7-05106a940c1f_dacia-sandero-01.jpg?auto=format&cs=tinysrgb&fit=clip&ixlib=rb-1.1.0&q=60&w=750",
                            Colors.blueAccent.shade100,
                            Ionicons.car,
                            () {
                              // showRenewLifeDialog(AppConsts.lifeModel);
                              // updateTemp();
                              // dashProvider.navigateToProduct(
                              //     ProductType.motor, context);

                              // navigate(EventCalendarScreen(), context);
                              // navigate(LifeDetailPage(model: AppConts.lifeModel), context);
                              // AppUtils.showSnackMessage(
                              //     "This Feature is not deployed yet", "");
                              // deleteTemp();
                              //   AppUtils.showSnackMessage(
                              //       "FD Redeemed Successfuly",
                              //       "This amount is given to client");
                            },
                          ),
                          productBoxWidget(
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
                SizedBox(
                  height: 50,
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      dashProvider.navigateToProduct(ProductType.cms, context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      // width: double.infinity,
                      decoration: dashBoxDex(context)
                          .copyWith(color: Colors.indigoAccent.shade100),
                      child: Center(child: heading("View User CMS", 30)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      dashProvider.navigateToProduct(
                          ProductType.documents, context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      // width: double.infinity,
                      decoration: dashBoxDex(context)
                          .copyWith(color: Colors.indigoAccent.shade100),
                      child: Center(child: heading("View User Docs", 30)),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
