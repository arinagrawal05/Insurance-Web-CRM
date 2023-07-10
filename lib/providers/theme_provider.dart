import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  Color bgColor = const Color(0xFFe2e2fe);
  Color mainColor = const Color.fromRGBO(44, 43, 49, 1);
  Color accentColor = const Color(0xFF0065FF);

  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeMode getCurrentThemes() {
    return themeMode;
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      headlineSmall: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      titleMedium: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),

    visualDensity: VisualDensity.comfortable,
    brightness: Brightness.dark,
    listTileTheme: ListTileThemeData(
        textColor: Colors.white,
        titleTextStyle: GoogleFonts.nunito(),
        iconColor: Colors.white,
        tileColor: Colors.transparent,
        dense: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
    appBarTheme: AppBarTheme(
      // backgroundColor: AppStyle.mainColor,
      titleTextStyle: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      // actionsIconTheme: ,
      elevation: 0,

      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      color: const Color.fromRGBO(44, 43, 49, 1),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(foregroundColor: Colors.white),
    canvasColor: const Color.fromRGBO(39, 39, 39, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(44, 43, 49, 1),
// Theme.of(context).canvasColor
    // cardTheme: CardTheme(
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   elevation: 2,
    //   color: Color.fromRGBO(39, 39, 39, 1),
    //   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    // ),

    bottomSheetTheme: const BottomSheetThemeData(
        elevation: 2,
        // showDragHandle: true,
        backgroundColor: Color.fromRGBO(38, 38, 38, 1)),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color.fromRGBO(38, 38, 38, 1),
      contentTextStyle: GoogleFonts.nunito(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
    colorScheme: const ColorScheme.dark()
        .copyWith(secondary: const Color.fromRGBO(55, 55, 55, 1))
        .copyWith(background: const Color.fromRGBO(18, 18, 18, 1)),
  );

  static final lightTheme = ThemeData(
    dialogTheme:
        DialogTheme(titleTextStyle: GoogleFonts.aBeeZee(color: Colors.black)),
    dialogBackgroundColor: Colors.grey.shade300,
    textTheme: TextTheme(
      headlineSmall: GoogleFonts.nunito(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      titleMedium: GoogleFonts.nunito(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    canvasColor: const Color.fromRGBO(217, 217, 217, 1),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.grey.shade200,
        modalBackgroundColor: Colors.grey.shade200),
    brightness: Brightness.light,
    // bottomSheetTheme: BottomSheetThemeData(),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade50,
      contentTextStyle: GoogleFonts.nunito(color: Colors.black),
    ),
    primaryTextTheme: TextTheme(bodySmall: GoogleFonts.poppins()),
    // primarySwatch: Colors.grey.shade200,
    // buttonColor: Colors.yellow,

    listTileTheme: ListTileThemeData(
        textColor: Colors.black,
        titleTextStyle: GoogleFonts.nunito(),
        iconColor: Colors.black,
        tileColor: Colors.transparent,
        dense: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
    appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        color: Color.fromRGBO(238, 238, 238, 1)),
    iconTheme: const IconThemeData(color: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.black)),

    scaffoldBackgroundColor: const Color.fromRGBO(238, 238, 238, 1),
    primaryColor: Colors.white,
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    colorScheme: const ColorScheme.light()
        .copyWith(secondary: const Color.fromRGBO(200, 200, 200, 1))
        .copyWith(background: Colors.white),
    // iconTheme: IconThemeData(
    //   color: Colors.black,
    // ),
  );
}
