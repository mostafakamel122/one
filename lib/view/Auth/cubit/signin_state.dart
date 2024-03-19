part of 'signin_cubit.dart';

abstract class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninInitialLoading extends SigninState {}

final class SigninInitialSuccess extends SigninState {}

final class SigninInitialError extends SigninState {
  final String? msg;

  SigninInitialError(this.msg);
}
