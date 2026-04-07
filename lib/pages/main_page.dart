import 'package:flutter/material.dart';
import 'home_page.dart';
import 'collection_page.dart';
import './search_page.dart';
import './profile_page.dart';
import '../widgets/app_title.dart';
import '../widgets/bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  void _updateCurrentPage(index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: AppTitle(),
      ),
      body: [
        HomePage(),
        Collection(),
        SearchPage(),
        ProfilePage(),
      ][currentPage],
      bottomNavigationBar: BottomBar(
        changePage: _updateCurrentPage,
        currentIndex: currentPage,
      ),
    );
  }
}
