import 'package:health_model/hive/hive_model/doc_hive_model.dart';

import '/shared/exports.dart';

class DocumentSearchController extends GetxController {
  List<DocHiveModel> documents = <DocHiveModel>[];
  Box<DocHiveModel>? docBox;
  TextEditingController searchController = TextEditingController();
  String typeFilter = 'All';
  String formatFilter = 'All';

// TextEDo

  @override
  void onInit() {
    // Fetch user data from the Hive box
    print('Hive user UserSearchController init called');
    docBox = UserHiveHelper.docBox;
    documents.addAll(docBox!.values.toList());
    super.onInit();
  }

  void changeType(String newType) {
    typeFilter = newType;
    filterDocuments();
  }

  void changeFormat(String newFormat) {
    formatFilter = newFormat;
    filterDocuments();
  }

  reset() {
    documents.clear();
    docBox = UserHiveHelper.docBox;
    documents.addAll(docBox!.values.toList());
    update();
  }

  void filterDocuments() {
    String query = searchController.text;

    print(query);
    documents.clear();
    documents = docBox!.values.where((user) {
      if (!(user.docName.toLowerCase().contains(query.toLowerCase()))) {
        return false;
      }
      //  if (!(policy.data!.name.toLowerCase().contains(query.toLowerCase()))) {
      //   return false;
      // }
      if (!(user.name.toLowerCase().contains(query.toLowerCase()))) {
        return false;
      }
      if (!(typeFilter == 'All' || typeFilter == user.docType)) {
        return false;
      }

      if (!(formatFilter == 'All' || formatFilter == user.docFormat)) {
        return false;
      }
      return true;
    }).toList();
    update();
  }
}
