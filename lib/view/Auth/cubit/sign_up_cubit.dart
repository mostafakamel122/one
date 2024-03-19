import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../core/cache_helper.dart';
import '../../../res/constant/AppLinks.dart';
import '../controller/LoginController.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final String _userUrl = AppLinks.signup;
  final controllers = SignUpControllers();
  final formKey = GlobalKey<FormState>();
  final String error = '';
  bool isShowPass = true;

  Future signUpUsers() async {
    emit(SignUpInitialLoading());
    try {
      if (formKey.currentState!.validate()) {
        if (controllers.passwordController.text ==
            controllers.confirmpasswordController.text) {
          Response response = await post(Uri.parse(_userUrl), body: {
            'email': controllers.emailController.text,
            'password': controllers.passwordController.text,
            'phone': controllers.phoneController.text,
            'username':
                "${controllers.userNameController.text} ${controllers.secondUserNameController.text}",
            'refcode': controllers.refCodeController.text,
            'age': controllers.ageController.text,
            'gender': controllers.genderController.text
          });
          final Map result = jsonDecode(response.body);
          if (response.statusCode == 200) {
            // final Map result = jsonDecode(response.body);
            emit(SignUpInitialSuccess());
            print(result);
            CacheHelper.saveToken(result['jwt']);
            print(CacheHelper.getToken());

            return result;
          } else if (response.statusCode == 400) {
            throw Exception(response.reasonPhrase);
          }
        } else {
          emit(SignUpInitialLoadingpasswordNotRight());
          print("password not confirm");
        }
      } else {
        emit(SignUpInitial());

        print('valida');
      }
    } catch (e) {
      emit(SignUpInitial());
      print(e);
    }
  }

  showPassword(bool isShow) {
    emit(SignUpInitialSuccessShowPass(isShow: isShow));
  }

  showConfirmPassword(bool isShow) {
    emit(SignUpInitialSuccessShowConfirmPass(isShow: isShow));
  }
}
