import '/shared/exports.dart';

// ignore: must_be_immutable
class AddUserPage extends StatefulWidget {
  UserHiveModel? model;
  String userid;
  AddUserPage({super.key, required this.userid, required this.model});
  @override
  // ignore: library_private_types_in_public_api
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final dob = TextEditingController();

  final _addUserKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      name.text = widget.model!.name;
      phone.text = widget.model!.phone;
      email.text = widget.model!.email;
      address.text = widget.model!.address;
      dob.text = dateTimetoText(widget.model!.dob);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Client"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _addUserKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                formTextField(
                  name,
                  "Client Name",
                  "Enter Client Name",
                  FieldRegex.nameRegExp,
                ),

                formTextField(
                  phone,
                  "Mobile",
                  "Enter Phone Number",
                  FieldRegex.phoneRegExp,
                ),

                formTextField(
                  email,
                  "Email ID",
                  "Enter Client Email",
                  FieldRegex.emailRegExp,
                ),

                formTextField(
                  dob,
                  "DOB: DD/MM/YYYY",
                  "Enter Client Date Of Birth",
                  FieldRegex.dateRegExp,
                ),

                formTextField(
                  address,
                  "Address",
                  "Enter Client Adress",
                  FieldRegex.defaultRegExp,
                  isCompulsory: false,
                ),
                genericPicker(
                    radius: 10,
                    prefixIcon: Ionicons.happy_outline,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    provider.genderList,
                    provider.genderSelected,
                    "Choose Gender", (value) {
                  provider.selectGender(value);
                }, context),
                // fdropdown("Select Gender", defaultTerm, genderdropDownData,
                //     (value) {
                //   print("selected Value $value");
                //   setState(() {
                //     defaultTerm = value!;
                //   });
                // }),
                // formTextField(gender, "gender", "Enter Client gender"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading("${provider.memberCount} Members", 20),
                    customButton(
                      "Add Member",
                      () async {
                        var uuid = const Uuid();
                        String docId = uuid.v4();
                        addMemberSheet(context, widget.userid, docId, provider,
                            model: null);
                      },
                      context,
                      isExpanded: false,
                    ),
                  ],
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(widget.userid)
                      .collection("Members")
                      // .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return customCircularLoader(term: "Fetching Members");
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            // return Text("erfdfv");
                            return memberTile(
                              false,
                              context,
                              MemberModel.fromFirestore(
                                  snapshot.data!.docs[index]),
                            );
                          });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Spacer(),
                // if (widget.model == null)
                customButton("Add to Database", () async {
                  int memberCount;
                  if (_addUserKey.currentState?.validate() == true) {
                    // AppUtils.showSnackMessage("Qualified", "subtitle");
                    if (widget.model == null) {
                      memberCount = provider.memberCount + 1;
                    } else {
                      memberCount = provider.memberCount;
                    }
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(widget.userid)
                        .set({
                      "userid": widget.userid,
                      "name": name.text,
                      "dob": textToDateTime(dob.text),
                      "email": email.text,
                      "phone": phone.text,
                      "address": address.text,
                      "isMale":
                          provider.genderSelected == "Male" ? true : false,
                      "timestamp": Timestamp.now(),
                      "members_count": memberCount,
                    }).then((value) {
                      // if (widget.model != null) {
                      //   UserHiveHelper.fetchUsersFromFirebase();
                      // }
                    });

                    if (widget.model == null) {
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.userid)
                          .collection("Members")
                          .doc(widget.userid)
                          .set({
                        "head_userid": widget.userid,
                        "userid": widget.userid,
                        "relation": "Head",
                        "name": name.text,
                        "dob": textToDateTime(dob.text),
                        "isMale":
                            provider.genderSelected == "Male" ? true : false,
                      });
                    }
                    if (widget.model != null) {
                      FirebaseFirestore.instance
                          .collection("Policies")
                          .where("uid", isEqualTo: widget.userid)
                          .get()
                          .then((value) {
                        if (value.docs.isNotEmpty) {
                          for (var i = 0; i < value.docs.length; i++) {
                            FirebaseFirestore.instance
                                .collection("Policies")
                                .doc(value.docs[i]["policy_id"])
                                .update({
                              "name": name.text,
                              "dob": textToDateTime(dob.text),
                              "email": email.text,
                              "phone": phone.text,
                              "isMale": provider.genderSelected == "Male"
                                  ? true
                                  : false,
                              "members_count": memberCount
                            });
                          }
                          print("Successfully User Added");
                        }
                      });
                    }
                    UserHiveHelper.fetchUsersFromFirebase();

                    Navigator.pop(context);
                  }
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
