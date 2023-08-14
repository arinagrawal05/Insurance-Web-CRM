import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_model/shared/exports.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;

  const StepperWidget({super.key, required this.currentStep});

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
          steps: const [
            EasyStep(
              icon: Icon(Ionicons.document_outline),
              title: 'Applied',

              // lineText: 'Add Address Info',
              // enabled: true,
            ),
            EasyStep(
              icon: const Icon(Ionicons.document_text_outline),
              title: 'in Hand',

              // lineText: 'Confirm Order Items',
              enabled: false,
            ),
            EasyStep(
              icon: const Icon(Ionicons.pricetags_sharp),
              title: 'Given',
              enabled: false,
            ),
            EasyStep(
              icon: const Icon(Ionicons.checkmark),
              title: 'Redeemed',
              enabled: false,
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
}
