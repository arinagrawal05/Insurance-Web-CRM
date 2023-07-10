import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

void adminDialog(
  BuildContext context,
  String companyId,
  String planId,
  //  int count
) {
  final statsProvider =
      Provider.of<HealthStatsProvider>(context, listen: false);
  TextEditingController advisorListField =
      TextEditingController(text: statsProvider.advisorList.join(","));

  TextEditingController pinField =
      TextEditingController(text: statsProvider.adminPin);
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              // height: 200,\
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading("Add Advisors", 20),
                    customTextfield(advisorListField, "Add advisors", context,
                        isExpanded: true),
                    customTextfield(pinField, "Admins Pin", context,
                        isExpanded: true),
                    const Spacer(),
                    customButton("Save Panel Settings", () {
                      // List list = advisorListField.text.split(",");
                      FirebaseFirestore.instance
                          .collection("Statistics")
                          .doc("KdMlwAoBwwkdREqX3hIe")
                          .update({
                        "advisor_list": advisorListField.text.split(","),
                        "admin_pin": pinField.text,
                      }).then((value) {
                        Navigator.pop(context);
                      });
                    }, context)
                  ],
                ),
              ),
            ),
          ));
}
