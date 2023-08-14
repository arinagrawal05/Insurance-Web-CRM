import 'package:health_model/regex.dart';

import '../../shared/exports.dart';

class ChooseExisting extends StatelessWidget {
  ChooseExisting({
    super.key,
  });

  Widget build(BuildContext context) {
    final provider = Provider.of<FDProvider>(context, listen: true);
    // final statsProvider =
    //     Provider.of<HealthStatsProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.freshFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chooseHeader("Fresh or Renewal", 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.portCompanyNameController,
                        "Company Name",
                        "Enter Company Name          ",
                        FieldRegex.nameRegExp,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.portFdNo,
                        "FD No",
                        "Enter FD No          ",
                        FieldRegex.integerRegExp,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.portMaturityAmt,
                        "maturity Amount",
                        "Enter maturity Amount          ",
                        FieldRegex.integerRegExp,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.portMaturityDate,
                        "Maturity Date:DD/MM/YYYY",
                        "Enter Maturity Date",
                        FieldRegex.dateRegExp,
                      ),
                    ),
                  ],
                ),
                customButton("Fresh", () {
                  provider.toggleFresh(true);
                  navigate(EnterFdDetails(), context);
                }, context),
                customButton("Renewal", () {
                  if (provider.freshFormKey.currentState?.validate() == true) {
                    provider.toggleFresh(false);
                    navigate(EnterFdDetails(), context);
                  }
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
