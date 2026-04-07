import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/scheduler.dart';

class ThemeCubit extends HydratedCubit<ThemeMode>{

  ThemeCubit(): super(ThemeMode.system);

  Brightness get systemBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  bool isLigth() {
    return systemBrightness == Brightness.light;
  }

  void toggleMode() {
    switch (state) {
      case ThemeMode.system :
        if (isLigth()) {
          emit(ThemeMode.dark);
          break;
        } else {
          emit(ThemeMode.light);
          break;
        }
      case ThemeMode.light :
        emit(ThemeMode.dark);
        break;
      case ThemeMode.dark :
        emit(ThemeMode.light);
        break;
    }
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) => ThemeMode.values[json['value']];

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => { 'value': state.index};

}