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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width:320,
                  height:280,
                  child: InProgressReadCard()
                ),
                ElevatedButton(
                  onPressed: (){logout(context);}, 
                  child: Text('Déconnexion')
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

}