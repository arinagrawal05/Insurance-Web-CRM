import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_model/homepage.dart';
import 'package:health_model/shared/regex.dart';
import 'package:health_model/shared/functions.dart';
import 'package:health_model/shared/widgets.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  String password = "";
  String username = "";

  check() {
    FirebaseFirestore.instance
        .collection("Statistics")
        .doc("KdMlwAoBwwkdREqX3hIe")
        .get()
        .then((value) {
      setState(() {
        password = value["password"];
        username = value["username"];
        print("Got all value");
      });
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Column(children: [Text("Some dta")],)
              formTextField(
                emailController,
                "Email",
                "Enter Email",
                FieldRegex.nameRegExp,
              ),
              formTextField(passwordController, "Password", "Enter Password",
                  FieldRegex.phoneRegExp,
                  kType: TextInputType.visiblePassword),
              customButton("Login", () async {
                if (_loginKey.currentState?.validate() == true) {
                  print("object");
                  print(username);
                  print(password);
                  // AppUtils.showSnackMessage("title", "subtitle");
                  if (emailController.text == username &&
                      passwordController.text == password) {
                    navigate(HomePage(), context);
                    setLoginPref(true);
                  } else {
                    AppUtils.showSnackMessage("Invalid Credentials",
                        "Your email or password might be wrong");
                  }
                }
              }, context),
            ],
          ),
        ),
      ),
    );
  }
}
