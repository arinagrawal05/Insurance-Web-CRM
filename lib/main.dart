import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_model/homepage.dart';
import 'package:health_model/providers/dash_provider.dart';
import 'package:health_model/providers/fd_provider.dart';
import 'package:health_model/providers/fd_stats_provider.dart';
import 'package:health_model/providers/filter_provider.dart';
import 'package:health_model/providers/image_provider.dart';
import 'package:health_model/providers/policy_provider.dart';
import 'package:health_model/providers/health_stats_provider.dart';
import 'package:health_model/providers/theme_provider.dart';
import 'package:health_model/providers/user_provider.dart';
import 'package:health_model/shared/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  // ErrorWidget.builder = (FlutterErrorDetails details) => SomethingWrong(
  //       error: details,
  //     );
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      print("error mil gaya $details");
    } else {
      print("noli");
    }
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA9-12boKtCNRHz1nHEqgawSto9o-RK6-M",
      appId: "1:222425562656:web:4b924f69b89becaac64645",
      messagingSenderId: "222425562656",
      projectId: "health-model-e0171",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => PolicyProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => HealthStatsProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => UserProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => FilterProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => DashProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => FDStatsProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => FDProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => PictureProvider(),
            ),
          ],
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              title: 'Health App',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: HomePage(),
              debugShowCheckedModeBanner: false,
            );
          });
}
