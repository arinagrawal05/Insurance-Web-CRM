import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_model/getx/user_search_controller.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/keyboard_listener.dart';
import 'package:health_model/shared/local_streams.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/user_provider.dart';
import 'package:health_model/shared/tiles.dart';
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
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context, listen: true);
    // final dashProvider = Provider.of<DashProvider>(context, listen: false);

    return Scaffold(
      appBar: customAppbar("Clients list", context),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (rawKeyEvent) {
          handleKeyEvent(rawKeyEvent, scrollController);
          // throw Exception('No return value');
        },
        child: GetBuilder<UserSearchController>(
            init: UserSearchController(),
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customTextfield(
                            controller.searchController, "Search", context,
                            onChange: (value) {
                          controller.filterUsers(value);
                        }),
                        customButton("Add User", () async {
                          // userProvider.changeMemberCount(0);
                          var uuid = const Uuid();
                          String docId = uuid.v4();
                          navigate(
                              AddUserPage(model: null, userid: docId), context);
                        }, context, isExpanded: false),
                      ],
                    ),
                  ),
                  // streamUsers(false),
                  // userStream(dashProvider, false)

                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.users.length,
                        itemBuilder: (context, index) {
                          return userTile(
                              false, context, controller.users[index]);
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }
}
