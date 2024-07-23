import 'package:health_model/hive/hive_model/doc_hive_model.dart';

import '/shared/exports.dart';

class DocumentProvider extends ChangeNotifier {
  // bool memberIsMAle = true;
  // String userid = "";
  // String genderSelected = "Male";
  // List<String> genderList = ["Male", "Female"];
  // int memberCount = 0;
  // String relationSelected = "Son";
  String documentSelected = "All";
  // List<PolicyDataHiveModel> policyList = [];

  List<DocHiveModel> getDocumentsByUser(String uid) {
    return UserHiveHelper.getDocumentByUser(userId: uid);
  }

  // List<String> relationList = [
  //   "Son",
  //   "Daughter",
  //   "Father",
  //   "Mother",
  //   "Spouse",
  //   "Head"
  // ];

  List<String> formatList = [
    "All",
    "application/pdf",
    "image/jpeg",
  ];
  List<String> documentList = [
    "All",
    "Policy copy",
    "Claim related",
    "Cheque copy",
    "General",
    "Adhaar",
    "Pan",
  ];
  // void selectRelation(String relation) {
  //   relationSelected = relation;
  //   notifyListeners();
  // }

  void selectDocument(String document) {
    documentSelected = document;
    notifyListeners();
  }

  // void setUserid(String uid) {
  //   userid = uid;
  //   notifyListeners();
  // }

  // void selectGender(String gender) {
  //   genderSelected = gender;
  //   notifyListeners();
  // }

  // void changeMemberIsMale(bool newCount) {
  //   memberIsMAle = newCount;
  //   notifyListeners();
  // }

  // void changeMemberCount(int newCount) {
  //   memberCount = newCount;
  //   notifyListeners();
  // }

  // void increaseMemberCount() {
  //   memberCount += 1;
  //   notifyListeners();
  // }

  // void decreaseMemberCount() {
  //   memberCount += 1;
  //   notifyListeners();
  // }
}
