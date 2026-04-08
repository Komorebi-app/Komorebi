import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscured = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    passwordController.dispose();
  }

  void handleLogin() {
    setState(() {
      loading = true;
    });

    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginEvent(
          username: nameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        switch (state) {
          case AuthLoggingSuccess _:
            if (state.isLogged) {
              context.replace('/');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Erreur lors de la connexion")),
              );
            }
            break;
          case AuthFailure _:
            // ignore: avoid_print
            print(state.message);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Connexion',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(vertical: 32),
                      child: const Divider(indent: 32, endIndent: 32),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nom de compte",
                        hintText: "Entrer votre nom de compte",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Champ non valide";
                        }
                        return null;
                      },
                      controller: nameController,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      obscureText: _isObscured,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        hintText: "Votre mot de passe",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Champ non valide";
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),
                    SizedBox(height: 30),
                    FilledButton(
                      onPressed: () => handleLogin(),
                      child: loading ? CircularProgressIndicator.adaptive() : Text("Se connecter"),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pas encore de compte ?"),
                        TextButton(
                          onPressed: () {
                            context.replace('/auth/register');
                          },
                          child: Text("Créer un compte"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
