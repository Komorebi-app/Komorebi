import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:komorebi/features/theme/theme_cubit.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late Storage storage;

  setUp(() {
    storage = MockStorage();
    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.delete(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});

    HydratedBloc.storage = storage;
  });

  group('ThemeCubit', () {
    test('L\'état initial doit être ThemeMode.system', () {
      expect(ThemeCubit().state, ThemeMode.system);
    });

    blocTest<ThemeCubit, ThemeMode>(
      'doit émettre [ThemeMode.dark] quand selectTheme(ThemeMode.dark) est appelé',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.selectTheme(ThemeMode.dark),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'doit émettre [ThemeMode.dark] quand on toggle depuis ThemeMode.light',
      build: () => ThemeCubit(),
      seed: () => ThemeMode.light, // On part de light
      act: (cubit) => cubit.toggleMode(),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'doit émettre [ThemeMode.light] quand on toggle depuis ThemeMode.dark',
      build: () => ThemeCubit(),
      seed: () => ThemeMode.dark, // On part de dark
      act: (cubit) => cubit.toggleMode(),
      expect: () => [ThemeMode.light],
    );

    test('fromJson / toJson doivent fonctionner correctement', () {
      final cubit = ThemeCubit();
      const mode = ThemeMode.dark;

      final json = cubit.toJson(mode);
      expect(json, {'theme_mode': mode.index});

      final result = cubit.fromJson(json!);
      expect(result, mode);
    });
  });
}
