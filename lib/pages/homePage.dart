import 'package:flutter/material.dart';
import '../widgets/inProgressReadCard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'loginPage.dart';



class HomePage extends StatelessWidget{
  const HomePage({super.key});

  void logout(BuildContext context) async {
  final storage = const FlutterSecureStorage();
  await storage.delete(key: 'jwt_token');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
    (route) => false,
  );
}

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView( 
    child: Padding(
      padding: const EdgeInsets.all(10.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.start,  
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const SizedBox(
                  width: 320,
                  height: 280,
                  child: InProgressReadCard(),
                ),
                const SizedBox(height: 10), 
                ElevatedButton(
                  onPressed: () => logout(context),
                  child: const Text('Déconnexion'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }

}