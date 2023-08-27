import 'package:flutter/material.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/widgets.dart';

// ignore: must_be_immutable
class ChoosePlan extends StatelessWidget {
  String companyName, companyId;
  ChoosePlan({required this.companyName, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppbar(),

      // backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chooseHeader("Choose Plan", 3),
            streamPlans(true, companyId)
          ],
        ),
      ),
    );
  }
}
