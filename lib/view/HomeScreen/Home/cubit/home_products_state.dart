part of 'home_products_cubit.dart';

sealed class HomeProductsState extends Equatable {
  const HomeProductsState();

  @override
  List<Object> get props => [];
}

final class HomeProductsInitial extends HomeProductsState {}

final class HomeProductsLoading extends HomeProductsState {}

final class HomeProductsSuccess extends HomeProductsState {}

final class HomeProductsInitialLoadMore extends HomeProductsState {}

final class HomeProductsError extends HomeProductsState {
  final String msg;

  const HomeProductsError(this.msg);
}
