import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../pages/main_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscured = true;
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  var nameAccount;
  var passwordAccount;
  String message = '';

  Future<void> loginUser(String name, String password) async {
    final dio = Dio();

    try{
      final response = await dio.post(
        'http://10.0.2.2:8000/api/token/',
        data :{
          'username' : name,
          'password' : password
        }
      ); 
      

      if (response.statusCode == 200) {
        message = 'Connexion réussie'; 
        await storage.write(key: 'jwt_token', value: response.data['access']);
        if (context.mounted){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const MainPage()));
        }
        
      }
    } on DioException catch (e) {
      message = 'Erreur';


    }
  }






  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Form(
          key: _formKey,
          child: Column(
              children:  [
                Text('Connexion',
                  style: TextStyle(
                    fontSize: 30,
                  )
                ),
                TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom de compte",
                  hintText : "Entrer votre nom de compte"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
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
                  hintText : "Votre mot de passe",
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isObscured = ! _isObscured;
                      });
                    }, 
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off
                    ))
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Champ non valide";
                    }
                  return null;
                },
                controller: passwordController,
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()){
                    nameAccount = nameController.text;
                    passwordAccount = passwordController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message))
                    );
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  loginUser(nameAccount, passwordAccount);
                }, 
                child: Text(
                  "Connexion"
                )),
                SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pas encore de compte ?"),
                    TextButton(
                      onPressed: (){}, 
                      child: Text("Créer un compte"))
                  ]
                )
              ]),
        ),
      ),
    );
  }
}