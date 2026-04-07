import 'package:flutter/material.dart';
import '../widgets/in_progress_read_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 320, height: 280, child: InProgressReadCard()),
      ],
    );
  }
}
