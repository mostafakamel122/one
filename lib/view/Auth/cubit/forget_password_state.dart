// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordInitialLoading extends ForgetPasswordState {}

class ForgetPasswordInitialSuccess extends ForgetPasswordState {}

class ForgetPasswordInitialSuccessAndGoChangePass extends ForgetPasswordState {}

class ForgetPasswordInitialSuccessAndGoHome extends ForgetPasswordState {}

class ForgetPasswordInitialError extends ForgetPasswordState {
  final String msg;
  ForgetPasswordInitialError({
    required this.msg,
  });
}

class ForgetPasswordInitialErrorCode extends ForgetPasswordState {
  final String msg;
  ForgetPasswordInitialErrorCode({
    required this.msg,
  });
}

class ForgetPasswordInitialErrorpass extends ForgetPasswordState {
  final String msg;
  ForgetPasswordInitialErrorpass({
    required this.msg,
  });
}
