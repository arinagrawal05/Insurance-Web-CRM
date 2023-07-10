import 'package:flutter/material.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/keyboard_listener.dart';
import 'package:health_model/shared/local_streams.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/user_provider.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'add_user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final ScrollController controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final dashProvider = Provider.of<DashProvider>(context, listen: false);

    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar: customAppbar("Clients list", context),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (rawKeyEvent) {
          handleKeyEvent(rawKeyEvent, controller);
          // throw Exception('No return value');
        },
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customTextfield(
                        dashProvider.userController, "Search", context,
                        onChange: (value) {
                      print("qq" + value);
                      dashProvider.searchUser(value);
                    }),
                    customButton("Add User", () async {
                      userProvider.changeMemberCount(0);
                      var uuid = const Uuid();
                      String docId = uuid.v4();
                      navigate(
                          AddUserPage(model: null, userid: docId), context);
                    }, context, isExpanded: false),
                  ],
                ),
              ),
              // streamUsers(false),
              userStream(dashProvider, false)
            ],
          ),
        ),
      ),
    );
  }
}
