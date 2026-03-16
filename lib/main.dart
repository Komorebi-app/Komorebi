import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'pages/collection.dart';
import 'widgets/appTitle.dart';
import 'widgets/bottomBar.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  int currentPage = 0;
  void _updateCurrentPage(index){
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(209, 250, 229, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.0),
          child: AppTitle(),
          ),
      body: [
        HomePage(),
        Collection(
        )
      ][currentPage],
      bottomNavigationBar: BottomBar(changePage: _updateCurrentPage, currentIndex: currentPage)
      )
    );
  }
}

 