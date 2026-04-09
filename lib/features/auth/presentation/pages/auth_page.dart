import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess && state.user != null) {
            context.replace('/');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess && state.user == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    const Spacer(flex: 2),
                    Image.asset('assets/KomorebiLogo.png', scale: 2),
                    Text(
                      'Komorebi',
                      style: Theme.of(context).textTheme.displayLarge!.apply(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: .stretch,
                        verticalDirection: .up,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              context.push<void>('/auth/register');
                            },
                            label: Text('S\'inscrire'),
                          ),
                          FilledButton.icon(
                            onPressed: () {
                              context.push<void>('/auth/login');
                            },
                            label: Text('Connexion'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
