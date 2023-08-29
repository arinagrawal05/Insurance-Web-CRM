import 'package:health_model/shared/exports.dart';

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
    // final dashProvider = Provider.of<DashProvider>(context, listen: true);

    return Scaffold(

        // backgroundColor: scaffoldColor,
        appBar: genericAppbar(
            title: "${widget.headName}'s Members", centerTitle: true),

        // appBar: AppBar(
        //   title: Text(),
        //   centerTitle: true,
        //   elevation: 0.2,
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: streamMembers(widget.headUserid, isChoosing: true),
          ),
        ));
  }
}
