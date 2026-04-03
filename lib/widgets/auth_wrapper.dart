import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:komorebi/pages/loginPage.dart';
import '../pages/main_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? token = await storage.read(key: 'jwt_token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return const MainPage();
        } else {
          return const LoginPage();
        }
      }
    );
  }
} 