import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_model/fd_dash.dart';

import 'package:health_model/health_dash.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/lottie.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/fd_provider.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/const.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TooltipBehavior tooltip = TooltipBehavior();

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final provider = Provider.of<HealthStatsProvider>(context, listen: true);
    final filterProvider = Provider.of<FilterProvider>(context, listen: true);
    // final policyProvider = Provider.of<PolicyProvider>(context, listen: true);
    // final userProvider = Provider.of<UserProvider>(context, listen: true);
    final fdProvider = Provider.of<FDProvider>(context, listen: true);

    final dashProvider = Provider.of<DashProvider>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            homepageAppbar(context),

            Container(
              decoration: dashBoxDex(context),
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Let's Get Started",
                          style: GoogleFonts.notoSerif(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      dashWidget(
                          "Health",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeR2HyZL1lk9Fw8DeKYNGddtxh7g2C9p1M0EjNJVn6wxtDFJjAyiuHrjdCl87Z9LBQnw&usqp=CAU",
                          Colors.redAccent.shade100,
                          Ionicons.heart, () {
                        dashProvider.changeDashName(AppConsts.health);
                        provider.getStats();
                        provider.getCompaniesChartData();
                        filterProvider.getCompanies(AppConsts.health);
                        dashProvider.getAllUsers();
                        dashProvider.getAllPolicies();
                        dashProvider.getAllCommissions();

                        checkGraced();

                        // dashProvider.changeHealthDash(0);
                        navigate(HealthDash(), context);
                      }),
                      dashWidget(
                          "Life",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZ9zuc0ypSpZi0vW7S-dWQ4E34_jM3nvBCQ&usqp=CAU",
                          Colors.cyanAccent.shade100,
                          Ionicons.nuclear, () {
                        // userProvider
                        //     .setUserid("06885b49-8870-40df-a27a-46326b409a10");
                        // navigate(
                        //     UserDetailPage(
                        //       model: AppConsts.userModel,
                        //     ),
                        //     context);
                      }),
                      dashWidget(
                        "General",
                        "https://carwow-uk.imgix.net/prismic/3521ee46-0e06-4629-b4f7-05106a940c1f_dacia-sandero-01.jpg?auto=format&cs=tinysrgb&fit=clip&ixlib=rb-1.1.0&q=60&w=750",
                        Colors.blueAccent.shade100,
                        Ionicons.car,
                        () {
                          updateTemp();

                          // updateTemp();
                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            // elevation: 2,

                            behavior: SnackBarBehavior.floating,
                            // action: SnackBarAction(label: label, onPressed: onPressed),
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              inMaterialBanner: true,

                              title: 'it is under Construction!',
                              message:
                                  'This is an message that will be inform you that it is under Construction!',

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.warning,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        },
                      ),
                      dashWidget(
                          "FD",
                          "https://static.theprint.in/wp-content/uploads/2021/07/moneyv-1.jpg",
                          Colors.greenAccent.shade100,
                          Ionicons.wallet, () {
                        dashProvider.getAllUsers();
                        filterProvider.getCompanies(AppConsts.fd);

                        fdProvider.getList();
                        dashProvider.changeDashName(AppConsts.fd);
                        navigate(FDDash(), context);
                      }),
                      Lotia(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            stepWidget()
            // GestureDetector(
            //   onTap: () {
            //     navigate(UsersPage(), context);
            //   },
            //   child: Container(
            //     height: 500,
            //     child: statsBox(
            //         provider.users_count.toString() + "View Clients",
            //         Ionicons.person,
            //         context),
            //   ),
            // ),
          ],
        ),
      ),
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
                      color: backgroundColor.withOpacity(0.6)),
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
                            color: Colors.black,
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
