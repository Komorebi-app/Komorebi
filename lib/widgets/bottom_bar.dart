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
      selectedItemColor: Color.fromRGBO(29, 87, 48, 1),
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: "Collection",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Rechercher"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
    );
  }
}
