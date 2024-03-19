part of 'basket_cubit.dart';

abstract class BasketState {}

class BasketinitialState extends BasketState {}

class BasketiDonetate extends BasketState {}

class BasketiLoadingState extends BasketState {}

class BasketiSuccessState extends BasketState {
  BasketiSuccessState();
}

class BasketiErrorState extends BasketState {}
