import 'package:flutter/material.dart';
import '../widgets/switch_button.dart';
import '../widgets/disconnect_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/avatarLogo.png', width: 120),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Name:', style: TextStyle(color: colors.tertiary)),
                Text('User email:', style: TextStyle(color: colors.tertiary)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Text('Mode', style: TextStyle(color: colors.tertiary)),
                SwitchButton(),
              ],
            ),
            DisconnectButton(),
          ],
        ),
      ],
    );
  }
}
