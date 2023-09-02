import 'package:health_model/pages/motor_module/enter_motor.dart';
import 'package:health_model/providers/life_provider.dart';

import '../../../../shared/exports.dart';
import '../../providers/motor_provider.dart';

// ignore: must_be_immutable
class EntervehiclesDetails extends StatefulWidget {
  // String inceptionDate;
  // EnterLifeDetails({required this.inceptionDate});
  @override
  // ignore: library_private_types_in_public_api
  _EntervehiclesDetailsState createState() => _EntervehiclesDetailsState();
}

class _EntervehiclesDetailsState extends State<EntervehiclesDetails> {
  // int withGST = 0;
  // TextEditingController payingTerm = TextEditingController();
  @override
  void initState() {
    super.initState();
    // inceptionDate.text = widget.inceptionDate;
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PolicyProvider>(context, listen: false);
    Get.put(DashProvider(), tag: 'statsFor${ProductType.motor.name}');
    final statsProvider = Get.find<DashProvider>(
      tag: 'statsFor${ProductType.motor.name}',
    );

    return Scaffold(
        body: Consumer<MotorProvider>(builder: (context, controller, child) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.vehicleFormKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            chooseHeader("Fill Vehicle Details", 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.31,
                  child: formTextField(
                    controller.vCompanyName,
                    "Vehicle Company Name",
                    "Enter Vehicle Company Name",
                    FieldRegex.defaultRegExp,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.31,
                  child: formTextField(
                    controller.vModel,
                    "Vehicle Company Model",
                    "Enter Vehicle Company Model",
                    FieldRegex.defaultRegExp,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.31,
                  child: formTextField(
                    controller.vEngine,
                    "Vehicle Engine",
                    "Enter Vehicle Engine",
                    FieldRegex.dateRegExp,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.3,
            //   child: formTextField(
            //     controller.vRegistrationNo,
            //     "Registration No",
            //     "Enter Registration No",
            //     FieldRegex.dateRegExp,
            //   ),
            // ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: formTextField(
                    controller.vRegistrationNo,
                    "Registration No",
                    "Enter Registration No",
                    FieldRegex.dateRegExp,
                  ),
                ),
                Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        VehicleToggle(
                            controller: controller, value: VehicleType.two),
                        heading("Two Wheeler", 20),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        VehicleToggle(
                            controller: controller, value: VehicleType.four),
                        heading("Four Wheeler", 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            formTextField(
              controller.vChesis,
              "Chesis No",
              "Enter Chesis No",
              FieldRegex.dateRegExp,
            ),
            formTextField(
              controller.vCC,
              "CC No",
              "Enter CC No",
              FieldRegex.dateRegExp,
            ),
            formTextField(
              controller.vMake,
              "Vehicle Make",
              "Enter Vehicle Make",
              FieldRegex.dateRegExp,
            ),
            formTextField(
              controller.vYOM,
              "Year of Make",
              "Enter Year of Make",
              FieldRegex.dateRegExp,
            ),

            //   ],
            // ),

            customButton("Next", () async {
              if (
                  // controller.vehicleFormKey.currentState?.validate() ==
                  true) {
                navigate(EnterMotorDetails(), context);
              }
            }, context),
          ]),
        ),
      ));
    }));
  }
}

class VehicleToggle extends StatelessWidget {
  MotorProvider controller;
  VehicleType value;
  VehicleToggle({super.key, required this.controller, required this.value});

  @override
  Widget build(BuildContext context) {
    return Radio<VehicleType>(
        activeColor: primaryColor,
        value: value,
        groupValue: controller.vehicleType,
        onChanged: (val) {
          controller.toggleVehicleType(val!);
        });
  }
}
