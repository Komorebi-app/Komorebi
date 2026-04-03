import 'package:flutter/material.dart';
import './loginPage.dart';
import './homePage.dart';
import './collection.dart';
import '../widgets/appTitle.dart';
import '../widgets/bottomBar.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        Collection()
      ][currentPage],
      bottomNavigationBar: BottomBar(changePage: _updateCurrentPage, currentIndex: currentPage)
      )
    );
  }
}