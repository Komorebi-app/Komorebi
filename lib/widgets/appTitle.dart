import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget{
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      color: Color.fromRGBO(209, 250, 229, 1),
        child:SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right:20),
                child:Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/KomorebiLogo.png",
                  width: 90,
                  fit : BoxFit.cover,
                  )
                  ),
                ) ,          
              Align(
                alignment: Alignment.center,
                child: Text('Komorebi',
                 style: TextStyle(
                  color: Color.fromRGBO(29, 87, 48, 1),
                  fontSize: 30
                 ),
                 )
                ),
                Align(
                alignment: Alignment.center,
                child: Text('Votre havre de lecture',
                 style: TextStyle(
                  color: Color.fromRGBO(29, 87, 48, 1),
                  fontSize: 15
                 ),
                 )
                ),
            ],
          )
      )
    );
  }
}