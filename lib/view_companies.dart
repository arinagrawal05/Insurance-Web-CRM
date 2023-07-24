import 'package:health_model/add_company.dart';
import 'package:health_model/shared/exports.dart';

class CompaniesPage extends StatefulWidget {
  final ProductType type;

  const CompaniesPage({super.key, required this.type});
  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  // List<QueryDocumentSnapshot<Object?>> docs;
  @override
  Widget build(BuildContext context) {
    // TextEditingController controller = TextEditingController();
    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar: customAppbar("Companies list", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customButton("Add Company", () async {
                    var uuid = const Uuid();
                    String docId = uuid.v4();
                    navigate(AddCompanyPage(companyid: docId), context);
                  }, context, isExpanded: false),
                ],
              ),
            ),
            streamCompanies(false, EnumUtils.convertTypeToKey(widget.type))
          ],
        ),
      ),
    );
  }
}
