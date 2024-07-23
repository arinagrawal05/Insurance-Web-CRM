import '/shared/exports.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;
  final FdHiveModel model;
  const StepperWidget(
      {super.key, required this.currentStep, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Expanded(flex: 1, child: _previousStep()),
        EasyStepper(
          padding: EdgeInsets.symmetric(horizontal: 155),

          alignment: Alignment.center,
          direction: Axis.horizontal,
          activeStep: currentStep,
          maxReachedStep: currentStep,
          lineLength: 175,
          lineSpace: 1,
          lineType: LineType.normal,
          unreachedLineColor: Colors.grey,

          activeLineColor: primaryColor,
          activeStepBorderColor: primaryColor,
          showTitle: true,

          onStepReached: null,
          showStepBorder: true,

          activeStepIconColor: primaryColor,
          activeStepTextColor: primaryColor,

          // activeLineColor: Colors.grey.withOpacity(0.5),
          // activeStepBackgroundColor: Colors.white,
          // unreachedStepBackgroundColor: Colors.grey.withOpacity(0.5),
          // unreachedStepBorderColor: Colors.grey.withOpacity(0.5),
          // unreachedStepIconColor: Colors.grey,
          // unreachedStepTextColor: Colors.grey.withOpacity(0.5),
          // unreachedLineColor: Colors.grey.withOpacity(0.5),
          // finishedStepBackgroundColor: Colors.deepOrange,
          // finishedStepBorderColor: Colors.grey.withOpacity(0.5),
          // finishedStepIconColor: Colors.grey,
          // finishedStepTextColor: Colors.deepOrange,
          // finishedLineColor: Colors.deepOrange,
          borderThickness: 10,
          internalPadding: 5,
          showLoadingAnimation: false,
          activeStepBorderType: BorderType.dotted,
          fitWidth: true,
          disableScroll: false,
          lineThickness: 0.5,
          steps: [
            EasyStep(
              icon: Icon(Ionicons.document_outline),
              // title: 'Applied',
              customTitle:
                  customTitle("Applied", model.initialDate, currentStep, 0),

              // lineText: 'Add Address Info',
              // enabled: true,
            ),
            EasyStep(
              icon: const Icon(Ionicons.document_text_outline),
              // title: 'in Hand',

              // lineText: 'Confirm Order Items',
              enabled: false,
              customTitle: customTitle(
                  "in Hand", model.certificateTakenDate, currentStep, 1),
            ),
            EasyStep(
              icon: Icon(Ionicons.pricetags_sharp),
              // title: 'Given',
              enabled: false,
              customTitle: customTitle(
                  "Hand over", model.certificateGivenDate, currentStep, 2),
            ),
            EasyStep(
              icon: const Icon(Ionicons.checkmark),
              // title: 'Redeemed',
              enabled: false,
              customTitle:
                  customTitle("Redeemed", model.renewalDate, currentStep, 3),
            ),
          ],
          // onStepReached: (index) => setState(() {
          //   activeStep2 = index;
          // }),
        ),
        // Expanded(flex: 1, child: _nextStep()),
      ],
    );
  }

  Widget customTitle(
      String label, DateTime date, int currentStep, int thisStep) {
    if (checkShow(currentStep, thisStep)) {
      return Column(
        children: [heading(label, 22), heading1(dateTimetoText(date), 18)],
      );
    }
    return Container();
  }
}

bool checkShow(int currentStep, int thisStep) {
  if (currentStep >= thisStep) {
    return true;
  }

  return false;
}
