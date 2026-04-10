import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';

class DisconnectButton extends StatefulWidget {
  const DisconnectButton({super.key});

  @override
  State<DisconnectButton> createState() => _DisconnectButtonState();
}

class _DisconnectButtonState extends State<DisconnectButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
        side: BorderSide(color: Theme.of(context).colorScheme.error),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
      ),
      onPressed: () {
        context.read<AuthBloc>().add(AuthLogoutEvent());
        if (context.mounted) {
          context.push<void>('/auth');
        }
      },
      child: Text(context.tr('logout')),
    );
  }
}
