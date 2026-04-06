import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:komorebi/theme/app_theme.dart';
import 'widgets/auth_wrapper.dart';
import 'theme/app_theme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  

  @override
  Widget build(BuildContext context) {
    

    return AdaptiveTheme(
      light : AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Komorebi',
        theme: theme,
        darkTheme: darkTheme,
        home: AuthWrapper(),
      ),
    );
  }
}

 