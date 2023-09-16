import 'package:flutter/cupertino.dart';

import '/shared/exports.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CupertinoSwitch(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
        setThemePref(themeProvider.themeMode);
      },
    );
  }
}
