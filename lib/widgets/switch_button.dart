import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/theme/theme_cubit.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return Switch(
          value: state == .light,
          activeThumbColor: colors.primary,
          activeThumbImage: AssetImage('assets/icon/sunIcon.png'),
          inactiveThumbImage: AssetImage('assets/icon/moonIcon.png'),
          onChanged: (value){
            context.read<ThemeCubit>().toggleMode();
          }
        );
      },
    );
  }
}
