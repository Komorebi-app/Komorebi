import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 32),
      child: child,
    );
  }
}
