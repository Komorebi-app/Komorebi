import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.primary,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/KomorebiLogo.png",
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Komorebi',
                style: Theme.of(context).textTheme.displayLarge!.apply(
                  color: Theme.of(context).colorScheme.tertiary
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                context.tr('appbar'),
                style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: Theme.of(context).colorScheme.tertiary
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
