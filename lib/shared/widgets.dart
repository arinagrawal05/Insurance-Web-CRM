import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/providers/theme_provider.dart';
import 'package:health_model/settings.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/style.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Widget cachedImage(String companyImg) {
  return CachedNetworkImage(
    imageUrl: companyImg,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
        ),
      ),
    ),
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Widget customDeleteButton(
  IconData? icon,
  Color bgColor,
  void Function()? ontap,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: MaterialButton(
      height: 60,
      minWidth: 60,
      // minWidth: isExpanded ? MediaQuery.of(context).size.width : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: bgColor,
      onPressed: ontap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          icon,
          size: 16,
        ),
      ),
    ),
  );
}

Widget customButton(
  String text,
  void Function()? ontap,
  BuildContext context, {
  bool isExpanded = true,
  Color color = const Color(0xFF346eeb),
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: MaterialButton(
      // height: 40,
      minWidth: isExpanded ? MediaQuery.of(context).size.width : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      onPressed: ontap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: buttonText(text, 14),
      ),
    ),
  );
}

Widget customTextfield(
    TextEditingController controller, String labelText, BuildContext context,
    {bool isExpanded = false, onChange, double wid = 500, double hgt = 40}) {
  return Container(
    decoration: dashBoxDex(context),
    width: isExpanded ? double.infinity : wid,
    height: hgt,
    // padding: const EdgeInsets.all(6),
    child: TextField(
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      onChanged: onChange,
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: labelText,
        // isDense: true,
        contentPadding: const EdgeInsets.all(4),
      ),
    ),
  );
}

Widget formTextField(
    TextEditingController controller, String labelText, String errorText,
    {bool isCompulsory = true,
    Function(String)? onChange,
    bool isAbsorbed = false,
    TextInputType? kType = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.all(6),
    child: AbsorbPointer(
      absorbing: isAbsorbed,
      child: Container(
        child: TextFormField(
          // autofillHints: ["hello,bye ,goodnight"],
          // enableSuggestions: true,
          // enabled: false,
          onChanged: onChange,
          keyboardType: kType,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: labelText,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          validator: (value) {
            if (isCompulsory) {
              if (value!.isEmpty) {
                return errorText;
              }
              return null;
            }
          },
        ),
      ),
    ),
  );
}

AppBar genericAppbar({List<Widget>? actions}) {
  return AppBar(
    actions: actions,
  );
}

AppBar customAppbar(String title, BuildContext context) {
  final statsProvider = Provider.of<HealthStatsProvider>(context, listen: true);
  final provider = Provider.of<FilterProvider>(context, listen: true);

  return AppBar(
    title: Text(title),
    // centerTitle: true,
    elevation: 0.0,

    actions: [
      InkWell(
        onTap: () {
          statsProvider.getStats();
          statsProvider.getCompaniesChartData();
          checkGraced();
          // updateTemp();
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: dashBoxDex(context),
            child: const Icon(
              Ionicons.refresh_outline,
              size: 15,
            ),
          ),
        ),
      ),
      filterTooltip(provider, context),
      // InkWell(
      //   onTap: () {
      //     filterSheet(context, provider);
      //   },
      //   child: AspectRatio(
      //     aspectRatio: 1,
      //     child: Container(
      //       margin: EdgeInsets.all(8),
      //       padding: EdgeInsets.all(8),
      //       decoration: dashBoxDex(context),
      //       child: Icon(
      //         Ionicons.filter,
      //         size: 15,
      //       ),
      //     ),
      //   ),
      // ),
      InkWell(
        onTap: () {
          navigate(SettingsPage(), context);
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: dashBoxDex(context),
            child: const Icon(
              Ionicons.settings_outline,
              size: 15,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: dashBoxDex(context),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(Ionicons.person),
            ),
            heading("Bk Agrawal", 15)
          ],
        ),
      )
    ],
  );
}

Widget homepageAppbar(BuildContext context) {
  // final statsProvider = Provider.of<HealthStatsProvider>(context, listen: true);
  // final provider = Provider.of<FilterProvider>(context, listen: true);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        height: 70,
        // width: 100,
        margin: const EdgeInsets.all(5),
        child: cachedImage(
            "https://png.pngtree.com/png-vector/20220706/ourmid/pngtree-project-management-png-image_5687733.png"),
      ),
      InkWell(
        onTap: () {
          navigate(SettingsPage(), context);
        },
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: dashBoxDex(context),
          child: const Icon(
            Ionicons.settings_outline,
            size: 15,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        height: 50,
        decoration: dashBoxDex(context),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(Ionicons.person),
            ),
            heading("Bk Agrawal", 15)
          ],
        ),
      )
    ],
  );
}

Widget filterTooltip(FilterProvider provider, BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

  TextEditingController fromDate =
      TextEditingController(text: dateTimetoText(provider.fromDate));
  TextEditingController toDate =
      TextEditingController(text: dateTimetoText(provider.toDate));
  // int sas = 0;
  return Center(
    child: ElTooltip(
      timeout: provider.tooltime,
      // timeout: ,
      color: Theme.of(context).canvasColor,
      padding: 10,
      distance: 0,
      showModal: false,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: dashBoxDex(context),
        child: Row(
          children: [
            Text(
              "${provider.filterName} ",

              softWrap: true,
              // overflow: overF,

              style: GoogleFonts.nunito(
                decoration: TextDecoration.none,
                color: themeProvider.getCurrentThemes() == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              // textAlign: center ? TextAlign.center : TextAlign.left,
            ),
            const Icon(
              Ionicons.filter,
              size: 15,
            ),
          ],
        ),
      ),
      content: Container(
          height: 360,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productTileText("Predefined Filters", 20),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: customButton("By Month", () {
                              provider.filterByMonth();
                              provider.clearSum();
                              provider.closeToolTip();
                            }, context, isExpanded: false),
                          ),
                          Expanded(
                            flex: 1,
                            child: customButton("By Year", () {
                              provider.filterByYear();
                              provider.clearSum();
                            }, context, isExpanded: false),
                          ),
                        ],
                      ),
                      customButton("Till Now", () {
                        provider.filterByTillNow();
                        provider.clearSum();
                      }, context, isExpanded: true),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productTileText("Manual Filters", 20),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      simpleText("  From  ", 20),
                      const Spacer(),
                      customTextfield(fromDate, "DD/MM/YYYY", context,
                          wid: 210),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      simpleText("  To ", 20),
                      const Spacer(),
                      customTextfield(toDate, "DD/MM/YYYY", context, wid: 210),
                    ],
                  ),
                  // Spacer(),
                  const SizedBox(
                    height: 20,
                  ),

                  customButton("Filter", () {
                    provider.filterByManual(textToDateTime(fromDate.text),
                        textToDateTime(toDate.text));
                    provider.clearSum();

                    // Navigator.pop(context);
                  }, context, isExpanded: true),
                ],
              ),
            ],
          )),
    ),
  );
}

Widget tag(String s, TextEditingController controller, BuildContext context) {
  return InkWell(
      onTap: () {
        controller.text = s;
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(7),
          decoration: dashBoxDex(context),
          child: simpleText(s, 12)));
}

Widget chooseHeader(String stepName, int stepNumber) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      simpleText("Step $stepNumber", 12),
      heading(stepName, 40),
    ],
  );
}

Widget sideBarTile(String title, Icon icon, onTap, int val, int dashIndex) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: dashIndex == val
            ? Colors.blueAccent.shade100.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        // tileColor: scaffoldColor,
        // selected: index == val,
        // selectedTileColor: dialogColor,
        leading: icon,
        title: productTileText(title, 16),
      ),
    ),
  );
}

Widget noDataWidget({double sizee = 400}) {
  double size = sizee;
  return Center(
    child: Container(
      height: size,
      width: size,
      child: Lottie.asset("assets/lotties/nodata_lotties.json"),
    ),
  );
}

Widget statusFooter(String status, DateTime time, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    color: Theme.of(context).scaffoldBackgroundColor,
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(vertical: 3),
    child: simpleText("$status on ${dateTimetoText(time)}", 16),
  );
}

Widget genericPicker(
  List<String> itemsList,
  String initialValue,
  String title,
  void Function(dynamic)? onSelectionDone,
  BuildContext context, {
  double? width,
  double? height = 50,
  double radius = 5,
  IconData prefixIcon = Ionicons.filter,
}) {
  // final provider = Provider.of<FilterProvider>(context, listen: true);
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
    height: height,
    child: CustomSingleSelectField<String>(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 3),
          prefixIcon: Icon(
            prefixIcon,
            color: themeProvider.getCurrentThemes() == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius))),
      width: 200,
      items: itemsList,
      initialValue: initialValue,
      title: title,
      textColor: themeProvider.getCurrentThemes() == ThemeMode.dark
          ? Colors.white
          : Colors.black,
      onSelectionDone: onSelectionDone,
      itemAsString: (item) => item,
    ),
  );
}

Widget customCircularLoader(String term) {
  return Column(
    children: [
      CircularProgressIndicator(
        strokeWidth: 1,
        backgroundColor: Colors.grey,
        color: Colors.grey.withOpacity(0.5),
      ),
      const SizedBox(
        height: 10,
      ),
      simpleText("Loading $term", 15)
    ],
  );
}

Widget statsBox(String count, IconData icon, BuildContext context) {
  return AspectRatio(
    aspectRatio: 1,
    child: Container(
      margin: const EdgeInsets.only(right: 5, bottom: 5, top: 10),
      padding: const EdgeInsets.all(20),
      decoration: dashBoxDex(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                icon,
                size: 22,
              ),
            ),
          ),
          heading1(count, 20)
        ],
      ),
    ),
  );
}

Widget birthdayWidget(BuildContext context) {
  return Container(
      decoration: dashBoxDex(context),
      padding: const EdgeInsets.all(8),
      // width: 400,
      // height: 335,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: heading("Today's Birthday", 22),
            ),
            streamUsers(false, isBirthday: true),
          ],
        ),
      ));
}

isGraced(Timestamp renewalDate) {
  final now = DateTime.now();
  final oneMonthAgo = now.add(const Duration(days: 30));
  if (renewalDate.toDate().difference(now) < const Duration(days: 30)) {
    return true;
  }
  return false;
}

Widget fdropdown(String placeholder, String defaultValue,
    List<dynamic> dropDownData, void Function(String?)? onChanged) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: const EdgeInsets.all(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isDense: false,
            value: defaultValue,
            // isExpanded: true,
            menuMaxHeight: 350,
            items: [
              DropdownMenuItem(child: Text(placeholder), value: ""),
              ...dropDownData.map<DropdownMenuItem<String>>((data) {
                return DropdownMenuItem(
                    child: Text(
                      data['title'],
                      style: GoogleFonts.nunito(color: Colors.grey),
                    ),
                    value: data['value']);
              }).toList(),
            ],
            onChanged: onChanged),
      ),
    ),
  );
}

Widget userCardShow(String label, String value) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading1(label, 12),
        productTileText(value, 16, overF: TextOverflow.clip)
      ],
    ),
  );
}

Widget userDetailShow(String label, String value, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading1(label, 12),
            productTileText(value, 16, overF: TextOverflow.clip)
          ],
        ),
      ],
    ),
  );
}

Widget membersShowcase(int membersCount, String headID) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading1("$membersCount Members", 12),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Container(
                height: 150,
                width: 200,
                child: streamMembers(headID, isMini: true))
          ],
        )
      ],
    ),
  );
}

Widget transactionHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      heading("S. No", 18),
      heading("Policy No", 18),
      heading("From", 18),
      heading("To", 18),
      heading("Premium", 18),
      heading("Renew Date", 18),
    ],
  );
}

Widget totalWidget(
    BuildContext context, void Function()? ontap, FilterProvider provider) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: dashBoxDex(context),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customButton("Calculate Total", ontap, context, isExpanded: false),
        heading1("${provider.commissionSuma}Rs", 22),
      ],
    ),
  );
}
