import 'package:flutter/material.dart';
import 'package:komorebi/theme/app_theme.dart';
import 'widgets/auth_wrapper.dart';


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
    return MaterialApp(
      title: 'Komorebi',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AuthWrapper(),
    );
  }
}

 