// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:one/res/constant/AppLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/HomeProducts.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavRepository favRepository;

  FavoriteCubit(this.favRepository) : super(FaviriinitialState());
  final String _baseUrl = AppLinks.removefav;
  List<HomeProducts> favProducts = [];
  getFav() async {
    emit(FaviriiLoadingState());

    try {
      final response = await favRepository.getdata();
      emit(FaviriiSuccessState(list: response));
      favProducts = response;
    } catch (e) {
      emit(FaviriiErrorState());

      print(e);
    }
  }

  removeFav(String productID) async {
    SharedPreferences? _prefs;

    _prefs = await SharedPreferences.getInstance();
    emit(FaviriiLoadingState());
    Response response = await post(Uri.parse(_baseUrl),
        body: {'productid': productID, 'uesrid': _prefs.get('id').toString()});
    final Map result = jsonDecode(response.body);
    print(result);
    print(response);
    if (response.statusCode == 200) {
      getFav();
      // final Map result = jsonDecode(response.body);

      return result;
    } else if (response.statusCode == 400) {
      emit(FaviriiErrorState());

      throw Exception(response.reasonPhrase);
    }
  }
}

class FavRepository {
  final String _userUrl = AppLinks.viewfav;

  Future<List<HomeProducts>> getdata() async {
    SharedPreferences? _prefs;

    _prefs = await SharedPreferences.getInstance();
    print(_prefs.get('id'));
    Response response =
        await post(Uri.parse(_userUrl), body: {'uesrid': _prefs.get('id')});

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      print(response.body);

      return result.map((e) => HomeProducts.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
