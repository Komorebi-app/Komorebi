import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Image.asset('assets/KomorebiLogo.png', scale: 2),
            Text(
              'Komorebi',
              style: Theme.of(context).textTheme.displayLarge!.apply(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
    );
  }
}
