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
    return ElevatedButton(
      onPressed: () {
        context.read<AuthBloc>().add(AuthLogoutEvent());
        if (context.mounted) {
          context.push<void>('/auth');
        }
      },
      child: const Text('Déconnexion'),
    );
  }
}
