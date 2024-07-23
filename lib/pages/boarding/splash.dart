import 'dart:async';

import 'package:health_model/pages/document_module/add_documents.dart';
import 'package:health_model/test.dart';

import '/shared/exports.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with WidgetsBindingObserver {
  bool islogged = false;
  String userimg = "constuserimg";

  String? theme;
  // String result = '';
  // var Colorsvalue = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setLoginPref(true);

    getprefab();
    navigateToDestiny();
  }

// SizeConfig().init
  navigateToDestiny() {
    Timer(
        Duration(seconds: 2),
        () =>
            // islogged ==
            true
                ? navigate(HomePage(), context)
                : navigate(LoginPage(), context));
  }

  getprefab() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        islogged = prefs.getBool("isLogged") ?? false;
        theme = prefs.getString("ThemeSettings") ?? "dark";
      });
    }
    if (theme == null || theme == "light") {
      // ignore: use_build_context_synchronously
      final provider = Provider.of<ThemeProvider>(context, listen: false);
      provider.toggleTheme(false);
    } else {
      final provider = Provider.of<ThemeProvider>(context, listen: false);
      provider.toggleTheme(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.15,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    decoration: const BoxDecoration(
                        // border: Border.all(
                        //     width: 1.5,
                        //     color: Colors.black45,
                        //     style: BorderStyle.solid),

                        ),
                    margin: const EdgeInsets.all(15),
                    height: 83,
                    width: 220,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.cover,
                      ),
                    )),
              )
            ]),
      ),
    );
  }
}
