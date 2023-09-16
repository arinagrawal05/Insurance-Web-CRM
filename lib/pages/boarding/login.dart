import '/shared/exports.dart';

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
        .doc(AppConsts.statsCode)
        .get()
        .then((value) {
      setState(() {
        password = value["password"] ?? "";
        username = value["username"] ?? "";
        print("Got all value");
      });
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var h = PlatformDetails().isMobile.toString();
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: Colors.blueAccent,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: MediaQuery.of(context).size.width > 800
                  ? heading("Wealth Pro", 25)
                  : heading("No", 25),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
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
                    FieldRegex.defaultRegExp,
                  ),
                  formTextField(passwordController, "Password",
                      "Enter Password", FieldRegex.defaultRegExp,
                      kType: TextInputType.visiblePassword),
                  customButton(
                    "Login",
                    () async {
                      if (_loginKey.currentState?.validate() == true) {
                        if (emailController.text == username &&
                            passwordController.text == password) {
                          navigate(HomePage(), context);
                          setLoginPref(true);
                        } else {
                          AppUtils.showSnackMessage("Invalid Credentials",
                              "Your email or password might be wrong");
                        }
                      }
                    },
                    context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
