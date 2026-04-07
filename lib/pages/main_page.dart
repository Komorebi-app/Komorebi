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

  void _updateCurrentPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final List<Widget> pages = [
      const HomePage(),
      const Collection(),
      const SearchPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: AppTitle(),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation =
                Tween<Offset>(
                  begin: const Offset(0.0, 0.2),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(currentPage),
            child: pages[currentPage],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        changePage: _updateCurrentPage,
        currentIndex: currentPage,
      ),
    );
  }
}
