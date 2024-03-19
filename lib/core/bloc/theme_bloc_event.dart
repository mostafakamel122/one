part of 'theme_bloc_bloc.dart';

class ThemeBlocEvent {}

class ThemeChanged extends ThemeBlocEvent {
  final bool? isDark;

  ThemeChanged(this.isDark);
}

class ThemeChangedsuc extends ThemeBlocEvent {}
