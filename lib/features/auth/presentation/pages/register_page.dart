import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscured = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  final usernameController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
  }

  void handleRegister() {
    setState(() {
      loading = true;
    });

    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthRegisterEvent(
          username: usernameController.text.trim(),
          firstname: firstnameController.text.trim(),
          lastname: lastnameController.text.trim(),
          email: emailController.text.trim(),
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
          case AuthRegisterSuccess _:
            if (state.isRegistred) {
              context.replace('/');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Erreur lors de l'inscription")),
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
        appBar: AppBar(leading: BackButton()),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Inscription',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(vertical: 32),
                      child: const Divider(indent: 32, endIndent: 32),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Identifiant",
                        hintText: "Entrer votre pseudo",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Champ non valide";
                        }
                        return null;
                      },
                      controller: usernameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nom",
                        hintText: "Entrer votre nom",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Champ non valide";
                        }
                        return null;
                      },
                      controller: lastnameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Prénom",
                        hintText: "Entrer votre prénom",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Champ non valide";
                        }
                        return null;
                      },
                      controller: firstnameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Entrer votre email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Champ non valide";
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
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
                    FilledButton(
                      onPressed: () => handleRegister(),
                      child: loading
                          ? CircularProgressIndicator.adaptive()
                          : Text("S'inscrire"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous avez déjà un compte ?"),
                        TextButton(
                          onPressed: () {
                            context.replace('/auth/login');
                          },
                          child: Text("Se connection"),
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
