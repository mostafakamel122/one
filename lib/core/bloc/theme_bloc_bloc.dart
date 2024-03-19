// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_bloc_event.dart';

class ThemeBlocBloc extends Bloc<ThemeBlocEvent, ThemeMode> {
  ThemeMode themeMode;
  ThemeBlocBloc(
    this.themeMode,
  ) : super(themeMode) {
    on<ThemeChanged>((event, emit) {
      emit(event.isDark! ? ThemeMode.light : ThemeMode.dark);
    });
  }
}
