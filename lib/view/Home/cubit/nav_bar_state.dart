// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nav_bar_cubit.dart';

abstract class NavBarState {}

class NavBarInitial extends NavBarState {
  final int? val;
  NavBarInitial({this.val});
}

class NavBarInitialLoading extends NavBarState {}

class NavBarInitialSuccess extends NavBarState {
  final List<HomeProducts> list;

  NavBarInitialSuccess({required this.list});
}

class NavBarInitialChange extends NavBarState {}

class NavBarInitialError extends NavBarState {}
