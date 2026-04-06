import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../theme/app_theme.dart';
class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {

  @override
  Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
  final themeMode = AdaptiveTheme.of(context).mode;
    return Switch(
      value: themeMode.isLight,
      activeThumbColor: colors.primary,
      activeThumbImage: AssetImage('assets/icon/sunIcon.png'),
      inactiveThumbImage: AssetImage('assets/icon/moonIcon.png'),
      onChanged: (bool value){
        if (value){
            AdaptiveTheme.of(context).setLight();
          } else {
            AdaptiveTheme.of(context).setDark();
          }
      },
    );
  }
}