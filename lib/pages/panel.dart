import '/shared/exports.dart';

class PanelPage extends StatefulWidget {
  final DashProvider statsProvider;

  const PanelPage({super.key, required this.statsProvider});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  TextEditingController advisorListField = TextEditingController();

  TextEditingController pinField = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // advisorListField.text = widget.statsProvider.advisorList.join(",");
    pinField.text = widget.statsProvider.adminPin;
    username.text = widget.statsProvider.username;
    password.text = widget.statsProvider.password;
  }

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);

    List advisorList = widget.statsProvider.advisorList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("panel"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              customTextfield(advisorListField, "Add advisors", context,
                  isExpanded: false, wid: 1300),
              customButton("Add Advisor", () {
                if (advisorListField.text.isNotEmpty) {
                  setState(() {
                    advisorList.add(advisorListField.text);
                  });
                  advisorListField.clear();
                }
              }, context, isExpanded: false),
            ],
          ),
          renderAdvisor(advisorList, context, null),
          SizedBox(
            height: 20,
          ),
          heading("Admin Pin", 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: customTextfield(pinField, "Admins Pin", context,
                isExpanded: true),
          ),
          Divider(),
          heading("Credentials", 20),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: customTextfield(username, "Username", context,
                  isExpanded: true)),
          customTextfield(password, "Password", context, isExpanded: true),
          const Spacer(),
          customButton("Save Panel Settings", () {
            // List list = advisorListField.text.split(",");
            FirebaseFirestore.instance
                .collection("Statistics")
                .doc(AppConsts.statsCode)
                .update({
              "advisor_list": advisorList,
              "admin_pin": pinField.text,
              "username": username.text,
              "password": password.text,
            }).then((value) {
              Navigator.pop(context);
            });
          }, context)
        ]),
      ),
    );
  }
}
