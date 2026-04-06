import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../pages/login_page.dart';


class DisconnectButton extends StatefulWidget {
  const DisconnectButton({super.key});

  @override
  State<DisconnectButton> createState() => _DisconnectButtonState();
}

class _DisconnectButtonState extends State<DisconnectButton> {
  @override
  Widget build(BuildContext context) {
    void logout(BuildContext context) async {
    final storage = const FlutterSecureStorage();
    await storage.delete(key: 'jwt_token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
  );
}
    return ElevatedButton(
            onPressed: () => logout(context),
            child: const Text('Déconnexion'),
          );
  }
}