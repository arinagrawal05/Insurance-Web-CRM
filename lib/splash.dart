import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_model/homepage.dart';
import 'package:health_model/login.dart';
import 'package:health_model/providers/theme_provider.dart';
import 'package:health_model/shared/exports.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  navigateToDestiny() {
    Timer(
        Duration(seconds: 4),
        () => islogged == true
            ? navigate(HomePage(), context)
            : navigate(LoginPage(), context));
  }

  getprefab() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        islogged = prefs.getBool("isLogged")!;
        theme = prefs.getString("ThemeSettings")!;
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
