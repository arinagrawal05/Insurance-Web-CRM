import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:health_model/shared/toggle.dart';

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
                downloadClientsExcel();
              }, context, isExpanded: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Backup Policies", 20),
              customButton("Download Excel", () {
                downloadPolicyExcel();
              }, context, isExpanded: false)
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     heading("Admin Settings", 20),
          //     customButton("Open Settings", () {
          //       adminDialog(context, "companyId", "planId");
          //     }, context, isExpanded: false)
          //   ],
          // ),
        ]),
      ),
    );
  }
}
