part of 'product_view_cubit.dart';

abstract class ProductViewState {}

class ProductViewInitial extends ProductViewState {}

class ProductViewInitialSuccess extends ProductViewState {}

class ProductViewInitialLoading extends ProductViewState {}

class ProductViewInitialError extends ProductViewState {
  final String err;

  ProductViewInitialError(this.err);
}
