import 'package:flutter/material.dart';
import 'package:health_model/add_company.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CompaniesPage extends StatefulWidget {
  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  // List<QueryDocumentSnapshot<Object?>> docs;
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashProvider>(context, listen: false);

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
            streamCompanies(false, dashProvider.dashName)
          ],
        ),
      ),
    );
  }
}
