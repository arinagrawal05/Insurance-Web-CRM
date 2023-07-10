import 'package:flutter/material.dart';
import 'package:health_model/shared/local_streams.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';

class ChooseUser extends StatelessWidget {
  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashProvider>(context, listen: false);
    print("qq" + "Building");
    return Scaffold(
      // backgroundColor: scaffoldColor,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chooseHeader("Choose Client", 1),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  // child: DebounceBuilder(
                  // delay: const Duration(milliseconds: 250),
                  // builder: (context, debounce) {
                  // return
                  child: customTextfield(
                      dashProvider.userController, "Search", context,
                      onChange: (value) {
                    dashProvider.searchUser(value);
                  }, isExpanded: true)
                  // }
                  // ),
                  ),
              userStream(dashProvider, true)
              // streamUsers(true),
            ],
          ),
        ),
      ),
    );
  }
}
