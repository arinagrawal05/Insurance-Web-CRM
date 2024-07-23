import '../../../shared/exports.dart';

Widget footerWidget(DashProvider provider, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(40),
    color: Theme.of(Get.context!).dialogBackgroundColor,
    width: double.infinity,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            aboutSection(),
            quickLinksSection(provider, context),
            contactSection()
          ],
        ),
        SizedBox(
          height: 50,
        ),
        heading1(
            "Copyright ©2023 All Rights Reserved | This Portal is made by Wealth Pro",
            12)
      ],
    ),
  );
}

Widget aboutSection() {
  return Container(
    width: 220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: heading("About Wealth Pro", 18),
        ),
        heading1(
            "we've crafted a powerful and intuitive platform to streamline insurance management. Our user-friendly CRM covers everything from client onboarding to claims processing, all with top-notch security. Gain insights, customize workflows, and collaborate seamlessly. Experience a new era of efficient insurance management with Wealth Pro.",
            14,
            overF: TextOverflow.clip)
      ],
    ),
  );
}

Widget quickLinksSection(DashProvider provider, BuildContext context) {
  return Container(
    width: 220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: heading("Quick Links", 18),
        ),
        link("Health", () {
          provider.navigateToProduct(ProductType.health, context);
        }),
        link("FD", () {
          provider.navigateToProduct(ProductType.fd, context);
        }),
        link("General", () {
          provider.navigateToProduct(ProductType.motor, context);
        }),
        link("Life", () {
          provider.navigateToProduct(ProductType.life, context);
        }),
        link("CRM", () {
          provider.navigateToProduct(ProductType.cms, context);
        }),
        link("Digilocker", () {
          provider.navigateToProduct(ProductType.documents, context);
        }),
        link("Privacy Policy", () {
          navigate(PrivacyPolicyPage(), context);
        }),
        link("Contact", () {}),
      ],
    ),
  );
}

Widget link(String text, ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2), child: heading1(text, 14)),
  );
}

Widget contactSection() {
  return Container(
    // width: 220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: heading("Have a Query?", 18),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Ionicons.call,
              color: Colors.grey,
              size: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading1("+91 ${AppConsts.carePhone1}", 14),
                heading1("+91 ${AppConsts.carePhone2}", 14),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Ionicons.mail,
              color: Colors.grey,
              size: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading1(AppConsts.careEmail2, 14),
                heading1(AppConsts.careEmail1, 14),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 20,
            ),
            socialIcon(Ionicons.logo_whatsapp, Colors.green, () {
              launchURL(
                  "https://wa.me/${AppConsts.carePhone1}?text=Hi, I am ${AppConsts.adminName}, and i am having some issue with Wealth Pro");
            }),
            socialIcon(Ionicons.mail, Colors.grey, () {
              launchURL(
                  "mailto:${AppConsts.careEmail1}?subject=Hi, I am ${AppConsts.adminName}, and i am having some issue with Wealth Pro");
            }),
            socialIcon(Ionicons.logo_twitter, Colors.cyanAccent, () {}),
          ],
        )
      ],
    ),
  );
}

Widget socialIcon(IconData icon, Color color, void Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          color: color,
        ),
      ),
    ),
  );
}

Widget perkTile(String text) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(7.0),
        child: Icon(
          Ionicons.checkmark,
          size: 15,
          color: Colors.green,
        ),
      ),
      productTileText(text, 19)
    ],
  );
}

Widget perkWidget(DateTime? validityDate) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    decoration: dashBoxDex(Get.context!),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: heading("Wealth Pro Ensures you", 28),
        ),
        perkTile("Enhanced Chart Analysis"),
        perkTile("All Investments renewal on your fingertips"),
        perkTile("Offline support once site loaded"),
        perkTile("Auto Generated Commission Files"),
        perkTile("All Investments under one Portal"),
        perkTile("Consolidated Client profile"),
        perkTile("Sync Renewal Calender"),
        perkTile("Download Clients and policies Data"),
        perkTile("Supports Dark theme"),
        perkTile("Pin secured Admin Panel"),
        perkTile("Full 24/7 Support"),
        if (validityDate != DateTime.now()) premiumWidget(validityDate!)
      ],
    ),
  );
}

Widget premiumWidget(DateTime validityDate) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
    ),
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    // height: 300,
    width: double.infinity,
    decoration: dashBoxDex(Get.context!).copyWith(
      gradient: const LinearGradient(
        colors: [
          Color(0xffffbf00),
          Color(0xffffdc73),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [0.4, 0.7],
        tileMode: TileMode.repeated,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Subscription is Activated",
              style: GoogleFonts.robotoSlab(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
            DateTime.now().difference(validityDate).inDays > 10
                ? Text(
                    "Validity Till ${dateTimetoText(validityDate)}",
                    style: GoogleFonts.robotoSlab(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    "Your subscription will over in ${DateTime.now().difference(validityDate).inDays} days",
                    style: GoogleFonts.robotoSlab(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
        validityDate.isBefore(DateTime.now())
            ? customButton("Contact Admin", () {}, Get.context!,
                isExpanded: false)
            : Opacity(
                opacity: 0.5,
                child: Icon(
                  Ionicons.checkmark_circle_outline,
                  fill: 0.3,
                  color: Colors.white,
                  grade: 4,
                  // opticalSize: 5,
                  size: 60,
                ),
              )
      ],
    ),
  );
}

Widget bar() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    decoration:
        dashBoxDex(Get.context!).copyWith(color: Colors.indigoAccent.shade100),
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
            "Make Action", "File his/her account", Ionicons.document_text),
        stepUnitWidget(
            "Claim Commission", "Get consolidated Profit", Ionicons.diamond),
      ],
    ),
  );
}

Widget stepUnitWidget(String title, String subtext, IconData icon) {
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

Widget productBoxWidget(String title, String imageUrl, Color backgroundColor,
    IconData icon, void Function()? ontap) {
  double size = getmobile ? SizeConfig.screenWidth! / 3 : 150;
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

              decoration: dashBoxDex(Get.context!).copyWith(
                boxShadow: [
                  const BoxShadow(
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

Row dashWidgetHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      toShowInMobile(
        child: Column(
          children: [bar(), bar(), bar()],
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            decoration: const BoxDecoration(
                // border: Border.all(
                //     width: 1.5,
                //     color: Colors.black45,
                //     style: BorderStyle.solid),

                ),
            margin: const EdgeInsets.all(15),
            height: 83,
            width: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            )),
      ),
      toShowInMobile(
        child: Column(
          children: [bar(), bar(), bar()],
        ),
      ),
    ],
  );
}
