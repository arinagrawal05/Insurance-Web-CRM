import '/providers/motor_provider.dart';
import 'pages/boarding/splash.dart';

import '../../shared/exports.dart';

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
    options: AppConsts.firebaseConfigs,
    // const firebaseConfig = {

// };
  );
  HiveHelper.init();
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
            // ChangeNotifierProvider(
            //   create: (context) => HealthStatsProvider(),
            // ),
            ChangeNotifierProvider(
              create: (context) => UserProvider(),
            ),
            // ChangeNotifierProvider(
            //   create: (context) => FilterProvider(),
            // ),

            // ChangeNotifierProvider(
            //   create: (context) => FDStatsProvider(),
            // ),
            ChangeNotifierProvider(
              create: (context) => FDProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => LifeProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => MotorProvider(),
            ),
          ],
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return GetMaterialApp(
              // initialBinding: AppBinding(),
              title: 'Wealth Pro',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: Splashscreen(),
              debugShowCheckedModeBanner: false,
            );
          });
}
