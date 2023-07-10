import 'package:flutter/cupertino.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/shared/tiles.dart';
import 'package:provider/provider.dart';

Widget commissionStream(DashProvider dashProvider, bool? isPending, String name,
    String companyFilter, DateTime fromDate, DateTime toDate) {
  return Consumer<DashProvider>(builder: (
    context,
    provider,
    child,
  ) {
    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashProvider.commissionSearchList.length,
        itemBuilder: (context, index) {
          if (dashProvider.commissionSearchList[index].commissionType == name) {
            if (dashProvider.commissionSearchList[index].isPending ==
                isPending) {
              if (dashProvider.commissionSearchList[index].companyName ==
                      companyFilter ||
                  companyFilter == "all companies") {
                return commissionTile(
                  context,
                  dashProvider.commissionSearchList[index],
                );
              }
              // else {
              //   return commissionTile(
              //     context,
              //     CommissionModel.fromFirestore(snapshot.data!.docs[index]),
              //   );
              // }
            }
          }
          return Container();
        });
  });
}

Widget policyStream(
    DashProvider dashProvider,
    bool isChoosing,
    String companyFilter,
    String statusFilter,
    DateTime fromDate,
    DateTime toDate) {
  return Consumer<DashProvider>(builder: (
    context,
    provider,
    child,
  ) {
    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashProvider.policySearchList.length,
        itemBuilder: (context, index) {
          if (getFirstWord(dashProvider.policySearchList[index].companyName) ==
                  companyFilter ||
              companyFilter == "all companies") {
            if (dashProvider.policySearchList[index].policyStatus ==
                    statusFilter ||
                statusFilter == "all status") {
              if (dashProvider.policySearchList[index].renewalDate
                      .toDate()
                      .isAfter(fromDate) &&
                  dashProvider.policySearchList[index].renewalDate
                      .toDate()
                      .isBefore(toDate)) {
                return policyTile(
                  context,
                  dashProvider.policySearchList[index],
                );
              }
            }
          }
          return Container();
        });
  });
}

Widget userStream(DashProvider dashProvider, bool isChoosing) {
  return Consumer<DashProvider>(builder: (
    context,
    provider,
    child,
  ) {
    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashProvider.userSearchList.length,
        itemBuilder: (context, index) {
          // return Text(dashProvider.userSearchList[index].name +
          //     " is " +
          //     dashProvider.userSearchList[index].userid +
          //     dashProvider.userSearchList[index].email);

          return userTile(
              isChoosing, context, dashProvider.userSearchList[index]);
        });
  });
}
