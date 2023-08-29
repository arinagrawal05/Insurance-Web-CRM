import 'package:health_model/shared/exports.dart';

class PaymodeSystem extends StatelessWidget {
  String termSelected;
  void Function(dynamic)? onSelectionDone;
  TextEditingController chequeNo;
  TextEditingController bankName;
  TextEditingController bankDate;

  PaymodeSystem({
    super.key,
    required this.bankDate,
    required this.chequeNo,
    required this.bankName,
    required this.onSelectionDone,
    required this.termSelected,
    // required this.bankDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        genericPicker(
            radius: 10,
            prefixIcon: Ionicons.card_outline,
            height: 70,
            width: MediaQuery.of(context).size.width,
            AppConsts.payModeList,
            termSelected,
            "Choose Payment Mode",
            onSelectionDone,
            context),
        termSelected == "Cheque"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: formTextField(
                      chequeNo,
                      "Cheque No",
                      "Enter Cheque",
                      FieldRegex.integerRegExp,
                      isCompulsory: false,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: formTextField(
                      bankName,
                      "Bank Name",
                      "Enter Bank Name",
                      FieldRegex.nameRegExp,
                      isCompulsory: false,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: formTextField(
                        bankDate,
                        "Date:DD/MM/YYYY",
                        "Enter Date",
                        FieldRegex.dateRegExp,
                        isCompulsory: false,
                      )),
                ],
              )
            : SizedBox(),
      ],
    );
  }
}
