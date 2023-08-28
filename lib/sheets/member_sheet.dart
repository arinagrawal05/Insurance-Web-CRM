import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/shared/regex.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/models/member_model.dart';
import 'package:health_model/providers/user_provider.dart';
import 'package:health_model/shared/style.dart';
import 'package:health_model/shared/widgets.dart';
import 'package:ionicons/ionicons.dart';

void addMemberSheet(
  BuildContext context,
  String headId,
  String memberId,
  UserProvider provider, {
  MemberModel? model,
}) {
  final name = TextEditingController(text: model == null ? "" : model.name);
  final dob = TextEditingController(
      text: model == null ? "" : dateTimetoText(model.dob.toDate()));
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          height: 700,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading("Add Member", 25),
              formTextField(
                name,
                "Member Name",
                "Enter Client member Name",
                FieldRegex.nameRegExp,
              ),
              formTextField(
                dob,
                "DD/MM/YYYY",
                "Enter Client member dob",
                FieldRegex.dateRegExp,
              ),
              genericPicker(
                  radius: 10,
                  prefixIcon: Ionicons.happy_outline,
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  provider.relationList,
                  provider.relationSelected,
                  "Relation", (value) {
                provider.selectRelation(value);
                print(getGender(provider.relationSelected).toString());
                // provider.genderSelected = value;
                print(value);
              }, context),
              const Spacer(),
              customButton("Add Member", () {
                // if (_addBrandKey.currentState?.validate() == true) {
                if (model == null) {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(headId)
                      .collection("Members")
                      .doc(memberId)
                      .set({
                    "head_userid": headId,
                    "userid": memberId,
                    "relation": provider.relationSelected,
                    "name": name.text,
                    "dob": textToDateTime(dob.text),
                    "isMale": getGender(provider.relationSelected),
                  }).then((value) {
                    provider.increaseMemberCount();
                    print("Successfully Member Added");

                    Navigator.pop(context);
                    print(memberId);
                  });
                } else {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(model.headUserid)
                      .collection("Members")
                      .doc(model.userid)
                      .update({
                    "relation": provider.relationSelected,
                    "name": name.text,
                    "dob": textToDateTime(dob.text),
                    "isMale": getGender(provider.relationSelected),
                  }).then((value) {
                    // provider.increaseMemberCount();
                    print("Successfully Member Updated");
                    Navigator.pop(context);
                    print(memberId);
                  });
                }

                // }
              }, context)
            ],
          )));
}
