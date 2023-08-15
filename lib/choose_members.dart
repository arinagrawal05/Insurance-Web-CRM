import 'package:flutter/material.dart';
import 'package:health_model/shared/streams.dart';
import 'package:health_model/shared/widgets.dart';

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
        appBar: genericAppbar(
            title: widget.headName + "'s Members", centerTitle: true),

        // appBar: AppBar(
        //   title: Text(),
        //   centerTitle: true,
        //   elevation: 0.2,
        // ),
        body: SingleChildScrollView(
          child: streamMembers(widget.headUserid, isChoosing: true),
        ));
  }
}
