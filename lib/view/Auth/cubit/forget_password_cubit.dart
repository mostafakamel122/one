import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:one/res/constant/AppLinks.dart';

import '../../../core/cache_helper.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  TextEditingController email = TextEditingController();
  TextEditingController passowrd = TextEditingController();
  var headers = {'Authorization': CacheHelper.getToken()};

  sendEmail() async {
    emit(ForgetPasswordInitialLoading());
    const String _baseurl = AppLinks.otpMail;
    Response response =
        await post(Uri.parse(_baseurl), body: {"email": email.text});
    if (response.statusCode == 200) {
      emit(ForgetPasswordInitialSuccess());
    } else {
      emit(ForgetPasswordInitialError(
          msg: "email not found , let's go sign up!"));
    }
  }

  verifycode(String verifycode) async {
    emit(ForgetPasswordInitialLoading());
    const String _baseurl = AppLinks.verifycode;
    Response response = await post(Uri.parse(_baseurl),
        body: {"email": email.text, "verifycode": verifycode});
    if (response.statusCode == 200) {
      final Map result = jsonDecode(response.body);
      CacheHelper.saveToken(result['token']);

      emit(ForgetPasswordInitialSuccessAndGoChangePass());
    } else {
      emit(ForgetPasswordInitialErrorCode(msg: "error in code"));
    }
  }

  cangedpassword() async {
    print(headers);
    emit(ForgetPasswordInitialLoading());
    const String _baseurl = AppLinks.cangedpassword;
    Response response = await post(Uri.parse(_baseurl),
        body: {"email": email.text, "newpassword": passowrd.text},
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      emit(ForgetPasswordInitialSuccessAndGoHome());
    } else {
      print(response.body);

      emit(ForgetPasswordInitialErrorpass(msg: "error in code"));
    }
  }

  returninit() {
    emit(ForgetPasswordInitial());
  }
}
