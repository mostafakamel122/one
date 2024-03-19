part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesInitialSuccess extends CategoriesState {
  final List<SubCat> listCat;

  CategoriesInitialSuccess(this.listCat);
}

class CategoriesInitialLoading extends CategoriesState {}

class CategoriesInitialError extends CategoriesState {}
