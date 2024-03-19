part of 'favorite_cubit.dart';

abstract class FavoriteState {}

class FaviriinitialState extends FavoriteState {}

class FaviriiLoadingState extends FavoriteState {}

class FaviriiSuccessState extends FavoriteState {
  final List<HomeProducts> list;

  FaviriiSuccessState({required this.list});
}

class FaviriiErrorState extends FavoriteState {}
