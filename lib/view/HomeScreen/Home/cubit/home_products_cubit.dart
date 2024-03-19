// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'package:one/model/HomeProducts.dart';

import '../../../../res/constant/AppLinks.dart';

part 'home_products_state.dart';

class HomeProductsCubit extends Cubit<HomeProductsState> {
  HomeProductsCubit() : super(HomeProductsInitial());
  List<String> cat = ["All", "Men", "Women", "Kids"];
  int valueCupertinoPicker = 0;
  List<HomeProducts> list = [];
  final String _userUrl = AppLinks.productsView;

  getdata() async {
    list.clear();
    print(valueCupertinoPicker);
    emit(HomeProductsLoading());
    Response response = await post(Uri.parse(_userUrl), body: {
      "catID": '$valueCupertinoPicker',
      "page": "1",
    });

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      list = result.map((e) => HomeProducts.fromJson(e)).toList();
      emit(HomeProductsSuccess());
    } else {
      emit(HomeProductsError(response.body));

      throw Exception(response.reasonPhrase);
    }
  }

  changeSelectedval(int val) {
    valueCupertinoPicker = val;
    getdata();
  }
}
