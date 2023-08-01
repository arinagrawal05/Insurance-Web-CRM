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
    options: const FirebaseOptions(
      apiKey: "AIzaSyA9-12boKtCNRHz1nHEqgawSto9o-RK6-M",
      appId: "1:222425562656:web:4b924f69b89becaac64645",
      messagingSenderId: "222425562656",
      projectId: "health-model-e0171",
    ),
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
            // ChangeNotifierProvider(
            //   create: (context) => PictureProvider(),
            // ),
          ],
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return GetMaterialApp(
              // initialBinding: AppBinding(),
              title: 'Health App',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: HomePage(),
              debugShowCheckedModeBanner: false,
            );
          });
}
