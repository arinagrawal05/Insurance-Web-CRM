import 'package:health_model/shared/regex.dart';
import 'package:health_model/shared/exports.dart';
import 'package:health_model/sheets/plan_sheet.dart';

// ignore: must_be_immutable
class AddCompanyPage extends StatefulWidget {
  String companyid;
  CompanyModel? model;
  AddCompanyPage({super.key, required this.companyid, required this.model});

  @override
  State<AddCompanyPage> createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {
  final name = TextEditingController();
  final imageUrl = TextEditingController();

  // final phone = TextEditingController();

  final _companyFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      name.text = widget.model!.name;
      imageUrl.text = widget.model!.companyImg;
    }
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    final dashProvider = Get.find<DashProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "Add Company" : "Update Company"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _companyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                formTextField(
                  imageUrl,
                  "Company Image Url",
                  "Enter Image Url",
                  FieldRegex.defaultRegExp,
                ),

                formTextField(
                  name,
                  "Company Name",
                  "Enter Company Name",
                  FieldRegex.nameRegExp,
                ),

                dashProvider.currentDashBoard != ProductType.fd
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          heading("Plan", 20),
                          customButton("Add Plan", () async {
                            var uuid = const Uuid();
                            String docId = uuid.v4();
                            addPlanSheet(context, widget.companyid, docId);
                          }, context, isExpanded: false),
                        ],
                      )
                    : Container(),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Companies")
                        .doc(widget.companyid)
                        .collection("Plans")
                        // .orderBy("timestamp", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return customCircularLoader("Plans");
                      } else {
                        return ListView.builder(
                            // shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // return Text("erfdfv");
                              return planTile(
                                false,
                                context,
                                PlanModel.fromFirestore(
                                    snapshot.data!.docs[index]),
                              );
                            });
                      }
                    },
                  ),
                ),

                // const Spacer(),
                customButton(
                    widget.model == null
                        ? "Add Company to Database"
                        : "Update This Company", () async {
                  if (_companyFormKey.currentState?.validate() == true) {
                    if (widget.model != null) {
                      FirebaseFirestore.instance
                          .collection("Companies")
                          .doc(widget.companyid)
                          .update({
                        "name": name.text,
                        "logo": imageUrl.text,
                        // "phone": dob.text,
                      });
                    } else {
                      FirebaseFirestore.instance
                          .collection("Companies")
                          .doc(widget.companyid)
                          .set({
                        "company_id": widget.companyid,
                        "name": name.text,
                        "plans_count": 0,
                        "policy_count": 0,
                        "timestamp": Timestamp.now(),
                        "company_type": EnumUtils.convertTypeToKey(
                            dashProvider.currentDashBoard),
                        "total_bussiness": 0,
                        "logo": imageUrl.text,
                        // "phone": dob.text,
                      });
                    }

                    Navigator.pop(context);
                  }
                }, context),

                // addMemberSheet(context, widget.userid, docId);
              ],
            ),
          ),
        ),
      ),
    );
  }
}
