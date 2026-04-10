import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final ValueChanged<int> changePage;
  final int currentIndex;

  const BottomBar({
    super.key,
    required this.changePage,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => changePage(index),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: context.tr('home')),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: context.tr('collection'),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: context.tr('search')),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: context.tr('profile')),
      ],
    );
  }
}
