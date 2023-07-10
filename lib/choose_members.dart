import 'package:flutter/material.dart';
import 'package:health_model/shared/streams.dart';

// ignore: must_be_immutable
class ChooseMember extends StatefulWidget {
  String headName, headUserid;
  ChooseMember({required this.headName, required this.headUserid});

  @override
  State<ChooseMember> createState() => _ChooseMemberState();
}

class _ChooseMemberState extends State<ChooseMember> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
        // backgroundColor: scaffoldColor,
        appBar: AppBar(
          title: Text(widget.headName + "'s Members"),
          centerTitle: true,
          elevation: 0.2,
          // actions: [
          //   Container(
          //     margin: const EdgeInsets.all(4.0),
          //     child: customButton("Add Members", () {
          //       var uuid = Uuid();
          //       String docId = uuid.v4();
          //       addMemberSheet(
          //         context,
          //         widget.headUserid,
          //         docId,
          //         provider,
          //       );
          //     }, context, isExpanded: false),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: streamMembers(widget.headUserid, isChoosing: true),
        ));
  }
}
