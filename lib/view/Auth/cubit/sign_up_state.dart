part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpInitialLoading extends SignUpState {}

class SignUpInitialSuccess extends SignUpState {}

class SignUpInitialLoadingShowPass extends SignUpState {}

class SignUpInitialLoadingpasswordNotRight extends SignUpState {}

class SignUpInitialSuccessShowPass extends SignUpState {
  bool isShow = true;

  SignUpInitialSuccessShowPass({required this.isShow});
}

class SignUpInitialSuccessShowConfirmPass extends SignUpState {
  bool isShow = true;

  SignUpInitialSuccessShowConfirmPass({required this.isShow});
}

class SignUpInitialError extends SignUpState {
  final String msg;

  SignUpInitialError(this.msg);
}
