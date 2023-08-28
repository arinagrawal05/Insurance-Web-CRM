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
  final email = TextEditingController();
  final password = TextEditingController();

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
                email,
                "Email",
                "Enter Email",
                FieldRegex.nameRegExp,
              ),
              formTextField(password, "Password", "Enter Password",
                  FieldRegex.phoneRegExp,
                  kType: TextInputType.visiblePassword),
              customButton("Login", () async {
                if (_loginKey.currentState?.validate() == true) {
                  AppUtils.showSnackMessage("title", "subtitle");
                  navigate(HomePage(), context);
                  setLoginPref(true);
                }
              }, context),
            ],
          ),
        ),
      ),
    );
  }
}
