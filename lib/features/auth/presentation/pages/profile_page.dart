import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komorebi/features/theme/theme_cubit.dart';
import 'package:komorebi/widgets/layout.dart';
import '../../../../widgets/disconnect_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess && state.user == null) {
          context.replace('/auth');
        }
        if (state is AuthLoggoutSuccess) {
          context.go('/auth');
        }
      },
      builder: (context, state) {
        switch (state) {
          case AuthSuccess _:
            final UserModel user = state.user!;
            return Layout(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 32,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset('assets/avatarLogo.png', scale: 10),
                  ),
                  Column(
                    children: [
                      Text(
                        "${user.lastname} ${user.firstname}",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        context.tr('theme'),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SegmentedButton<ThemeMode>(
                        segments: [
                          ButtonSegment(
                            value: ThemeMode.system,
                            icon: Icon(Icons.settings_brightness_outlined),
                            label: Text(context.tr('system')),
                          ),
                          ButtonSegment(
                            value: ThemeMode.light,
                            icon: Icon(Icons.light_mode_outlined),
                            label: Text(context.tr('light')),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            icon: Icon(Icons.dark_mode_outlined),
                            label: Text(context.tr('dark')),
                          ),
                        ],
                        selected: {context.watch<ThemeCubit>().state},
                        onSelectionChanged: (Set<ThemeMode> newSelection) {
                          context.read<ThemeCubit>().selectTheme(
                            newSelection.first,
                          );
                        },
                        style: SegmentedButton.styleFrom(
                          selectedBackgroundColor: colors.primaryContainer,
                          selectedForegroundColor: colors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        context.tr('lang'),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SegmentedButton<String>(
                        segments: [
                          ButtonSegment(
                            value: 'en',
                            label: Text(context.tr('en')),
                          ),
                          ButtonSegment(
                            value: 'fr',
                            label: Text(context.tr('fr')),
                          ),
                        ],
                        selected: {context.locale.languageCode},
                        onSelectionChanged: (Set<String> newSelection) {
                          context.setLocale(Locale(newSelection.first));
                        },
                        style: SegmentedButton.styleFrom(
                          selectedBackgroundColor: colors.primaryContainer,
                          selectedForegroundColor: colors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const DisconnectButton(),
                ],
              ),
            );

          default:
            return Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
