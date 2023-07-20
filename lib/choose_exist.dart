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
                chooseHeader("Fresh or Existing", 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(provider.portCompanyNameController,
                          "Company Name", "Enter Company Name"),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: formTextField(
                            provider.portFdNo, "Fd No", "Enter Fd No")),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: formTextField(provider.portMaturityAmt,
                            "maturity Amount", "Enter maturity Amount")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: formTextField(
                        provider.portMaturityDate,
                        "Maturity Date:DD/MM/YYYY",
                        "Enter Maturity Date",
                      ),
                    ),
                  ],
                ),
                customButton("Fresh", () {
                  navigate(EnterFdDetails(), context);
                }, context),
                customButton("Existed", () {
                  if (provider.freshFormKey.currentState?.validate() == true) {
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
