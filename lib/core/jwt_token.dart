import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/constant/AppLinks.dart';
import 'cache_helper.dart';

abstract class JwtTokenStates {}

class JwtTokenInitialState extends JwtTokenStates {}

class JwtTokenLoadingState extends JwtTokenStates {}

class JwtTokenSuccessState extends JwtTokenStates {}

class JwtTokenErrorState extends JwtTokenStates {}

class removeTokenSuccessState extends JwtTokenStates {}

class JwtTokenCubit extends Cubit<JwtTokenStates> {
  JwtTokenCubit() : super(JwtTokenInitialState());

  int id = 0;
  String name = "";
  String email = "";
  String phone = "";
  String referralcode = "";
  DateTime now = DateTime.now();

  Map<String, String> headers = {
    'Authorization': CacheHelper.getToken().toString()
  };
  SharedPreferences? _prefs;

  refreshjwt() async {
    try {
      String _userUrl = AppLinks.refresh;

      emit(JwtTokenLoadingState());

      Response response = await get(Uri.parse(_userUrl), headers: headers);
      // print(headers);
      // print(response.body);
      if (response.statusCode == 200) {
        var responesBody = jsonDecode(response.body);
        CacheHelper.saveToken(responesBody['token']);
        emit(JwtTokenSuccessState());
        return true;
      } else {
        emit(JwtTokenErrorState());
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  void decodeJwtToken() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      String? jwtToken = _prefs!.getString('token');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);

      id = decodedToken['user_id'] ?? 0;
      name = decodedToken['user_name'] ?? "";
      email = decodedToken['user_email'] ?? "";
      phone = decodedToken['user_phone'] ?? "";
      referralcode = decodedToken['user_Referralcode'] ?? "";

      emit(JwtTokenSuccessState());
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchTokenAndDecode() async {
    _prefs = await SharedPreferences.getInstance();
    //String? jwtToken = _prefs!.getString('token');
    decodeJwtToken();
  }

  void deleteData() {
    id = 0;
    name = "";
    email = "";
    phone = "";
  }

  void toggleTheme() {
    state == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    emit(JwtTokenSuccessState());
  }
  // Future<void> removeToken() async {
  //   await CacheHelper.removeToken();
  //   emit(removeTokenSuccessState());
  // }
}
