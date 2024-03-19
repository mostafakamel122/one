import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:one/core/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/constant/AppLinks.dart';
import '../controller/LoginController.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());

  final String _userUrl = AppLinks.signin;
  final controllers = LoginControllers();
  final formKey = GlobalKey<FormState>();
  final String error = '';

  Future signInUsers() async {
    SharedPreferences? _prefs;

    _prefs = await SharedPreferences.getInstance();

    emit(SigninInitialLoading());
    try {
      if (formKey.currentState!.validate()) {
        Response response = await post(Uri.parse(_userUrl), body: {
          'email': controllers.emailController.text,
          'password': controllers.passwordController.text
        });
        final Map result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // final Map result = jsonDecode(response.body);
          emit(SigninInitialSuccess());
          CacheHelper.saveToken(result['data']['user_token']);
          CacheHelper.saveid(result['data']['user_id'].toString());
          print("cach");
          var headers = {'Authorization': CacheHelper.getToken()};
          print(headers);
          print("native");
          print(result['data']['user_token']);

          _prefs.setString('status', 'home');
          return result;
        } else if (response.statusCode == 400) {
          emit(SigninInitialError(result['status']));
          emit(SigninInitial());

          throw Exception(response.reasonPhrase);
        }
      } else {
        emit(SigninInitial());

        print('valida');
      }
    } catch (e) {
      emit(SigninInitial());
      print(e);
    }
  }
}
