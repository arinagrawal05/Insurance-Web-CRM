import 'package:health_model/shared/exports.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Dark Mode", 20),
              const ChangeThemeButtonWidget(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Backup User", 20),
              customButton("Download Excel", () {
                ExcelFunctions.downloadClientsExcel();
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Backup Policies", 20),
              customButton("Download Excel", () {
                ExcelFunctions.downloadHealthExcel();
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Backup FDs", 20),
              customButton("Download Excel", () {
                ExcelFunctions.downloadFDExcel();
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Backup Lifes", 20),
              customButton("Download Excel", () {
                ExcelFunctions.downloadLifeExcel();
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Backup Generals", 20),
              customButton("Download Excel", () {
                ExcelFunctions.downloadMotorExcel();
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Log Out", 20),
              customButton("Exit", () {
                setLoginPref(false);

                navigate(LoginPage(), context);
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Admin Settings", 20),
              customButton("Open Settings", () {
                adminDialog(context, "companyId", "planId");
              }, context, isExpanded: false)
            ],
          ),
        ]),
      ),
    );
  }
}
