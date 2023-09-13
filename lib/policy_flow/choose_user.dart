import '../../shared/exports.dart';

class ChooseUser extends StatefulWidget {
  const ChooseUser({super.key});

  // List<QueryDocumentSnapshot<Object?>> docs;
  //  UsersPage({required this.docs});

  @override
  State<ChooseUser> createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
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
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
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
                          }, wid: 1200),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                            return UserTile(
                                isChoosing: true,
                                model: controller.users[index]);
                          }),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
