import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool memberIsMAle = true;
  String userid = "";
  String genderSelected = "Male";
  List<String> genderList = ["Male", "Female"];
  int memberCount = 0;
  String relationSelected = "Son";

  List<String> relationList = [
    "Son",
    "Daughter",
    "Father",
    "Mother",
    "Spouse",
    "Head"
  ];

  void selectRelation(String relation) {
    relationSelected = relation;
    notifyListeners();
  }

  void setUserid(String uid) {
    userid = uid;
    notifyListeners();
  }

  void selectGender(String gender) {
    genderSelected = gender;
    notifyListeners();
  }

  void changeMemberIsMale(bool newCount) {
    memberIsMAle = newCount;
    notifyListeners();
  }

  void changeMemberCount(int newCount) {
    memberCount = newCount;
    notifyListeners();
  }

  void increaseMemberCount() {
    memberCount += 1;
    notifyListeners();
  }

  void decreaseMemberCount() {
    memberCount += 1;
    notifyListeners();
  }
}
