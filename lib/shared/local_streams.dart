import 'package:health_model/shared/tiles.dart';
import 'package:health_model/widgets/tiles/commission_tile_widget.dart';
import 'exports.dart';
import '../models/policy_model.dart';

// Widget commissionStream(DashProvider dashProvider, bool? isPending, String name,
//     String companyFilter, DateTime fromDate, DateTime toDate) {
//   return Consumer<DashProvider>(builder: (
//     context,
//     provider,
//     child,
//   ) {
//     return ListView.builder(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: dashProvider.commissionSearchList.length,
//         itemBuilder: (context, index) {
//           if (dashProvider.commissionSearchList[index].commissionType == name) {
//             if (dashProvider.commissionSearchList[index].isPending ==
//                 isPending) {
//               if (dashProvider.commissionSearchList[index].companyName ==
//                       companyFilter ||
//                   companyFilter == "all companies") {
//                 return CommissionTile(
//                   model: dashProvider.commissionSearchList[index],
//                 );
//               }
//               // else {
//               //   return commissionTile(
//               //     context,
//               //     CommissionModel.fromFirestore(snapshot.data!.docs[index]),
//               //   );
//               // }
//             }
//           }
//           return Container();
//         });
//   });
// }

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
          GenericInvestmentData currentModel =
              dashProvider.policySearchList[index].data;

          if (currentModel is PolicyModel) {
            PolicyModel policyModel = currentModel as PolicyModel;

            if (selectedPolicy(
                policyModel, companyFilter, statusFilter, fromDate, toDate)) {
              return policyTile(
                context,
                policyModel,
              );
            }
          } else {
            FdModel fdModel = currentModel as FdModel;
            if (selectedFd(
                fdModel, companyFilter, statusFilter, fromDate, toDate)) {
              return fdTile(
                context,
                fdModel,
              );
            }
          }
          return Container(
            child: Text(currentModel.type),
          );
        });
  });
}

Widget userStream(DashProvider dashProvider, bool isChoosing) {
  return Consumer<DashProvider>(builder: (
    context,
    provider,
    child,
  ) {
    return Container();
    // ListView.builder(
    //     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     itemCount: dashProvider.userSearchList.length,
    //     itemBuilder: (context, index) {
    //       // return Text(dashProvider.userSearchList[index].name +
    //       //     " is " +
    //       //     dashProvider.userSearchList[index].userid +
    //       //     dashProvider.userSearchList[index].email);

    //       return userTile(
    //           isChoosing, context, dashProvider.userSearchList[index]);
    //     });
  });
}
