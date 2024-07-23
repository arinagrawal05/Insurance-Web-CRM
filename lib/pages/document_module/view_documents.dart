import 'dart:html';

import 'package:flutter/material.dart';
import 'package:health_model/getx/document_search_controller.dart';
import 'package:health_model/getx/user_search_controller.dart';
import 'package:health_model/hive/hive_model/doc_hive_model.dart';
import 'package:health_model/providers/doc_provider.dart';
import 'package:health_model/widgets/tiles/document_tile_widget.dart';

import '../../../../shared/exports.dart';

class DocumentsPage extends StatefulWidget {
  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final filterProvider = Provider.of<FilterProvider>(context, listen: true);
    final provider = Provider.of<DocumentProvider>(context, listen: false);
    // final dashProvider = Get.find<DashProvider>();
    final documentController = Get.put(
      DocumentSearchController(),
    );
    return Scaffold(
        // drawer: toShowInMobile(child: customDrawer(), show: true),

        // backgroundColor: scaffoldColor,
        appBar: customAppbar("Clients Data", context),
        body: RawKeyboardListener(
          includeSemantics: true,
          autofocus: true,
          focusNode: _focusNode,
          onKey: (rawKeyEvent) {
            handleKeyEvent(rawKeyEvent, scrollController);
            // throw Exception('No return value');
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customTextfield(documentController.searchController,
                          "Search", context, onChange: (value) {
                        documentController.filterDocuments();
                      }),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: genericPicker(
                          radius: 10,
                          prefixIcon: Ionicons.document,
                          height: 70,
                          width: double.infinity,
                          provider.documentList,
                          documentController.typeFilter,
                          "Type",
                          (value) {
                            documentController.changeType(value);
                            print(value);
                          },
                          context,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: genericPicker(
                          radius: 10,
                          prefixIcon: Ionicons.document,
                          height: 70,
                          width: double.infinity,
                          provider.formatList,
                          documentController.formatFilter,
                          "Format",
                          (value) {
                            documentController.changeFormat(value);
                            print(value);
                          },
                          context,
                        ),
                      ),

                      // ),
                      //  customButton("Add ${dashProvider.currentDashBoard.name}",
                      //     () async {
                      //   policyProvider.clearPort();
                      //   // UserHiveHelper.fetchUsersFromFirebase();
                      //   // PolicyHiveHelper.init();

                      //   navigate(
                      //     const ChooseUser(),
                      //     context,
                      //   );
                      // }, context, isExpanded: false),
                    ],
                  ),
                ),

                Expanded(
                  child: GetBuilder<DocumentSearchController>(
                      init: documentController,
                      didChangeDependencies: (state) {
                        print('RRRR didChangeDependencies called');
                      },
                      didUpdateWidget: (oldWidget, state) {
                        print('RRRR didUpdateWidget called');
                      },
                      initState: (state) {
                        print('RRRR initState called');
                        // searchController.filterpolicies();
                      },
                      builder: (controller) {
                        return ListView.builder(
                            controller: scrollController,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: controller.documents.length,
                            itemBuilder: (context, index) {
                              DocHiveModel currentModel =
                                  controller.documents[index];
                              // return renderTile(currentModel, context);
                              return DocumentTile(
                                model: currentModel,
                              );
                            });
                      }),
                )
                // streamPolicies(
                //     false,
                //     filterProvider.companyFilter,
                //     filterProvider.statusFilter,
                //     filterProvider.fromDate,
                //     filterProvider.toDate

                //  )
              ],
            ),
          ),
        ));
  }
}
