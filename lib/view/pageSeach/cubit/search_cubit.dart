import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../res/constant/AppLinks.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  late String searchval;
  List list = [];
  final String _userUrl = AppLinks.productsViewsearch;
  RangeValues currentRangeValues = const RangeValues(1, 7200);
  //declr filter
  List size = ["s", "M", "X", "XL", "2X"];
  int? selectedSize;
  List cat = ["men", "Women", "kids"];
  int? selectedCat;
  List material = ["cotton", "poslter"];
  int? selectedmaterial;
  List colors = ["black", "white", "red", "blue"];
  int? selectedColors;
  String OrderBy = "item_time";
  String orderDirection = "DESC";
  //declr filter
  // func filter
  onopenfilter() {
    selectedCat = 0;
    selectedSize = 0;
    selectedmaterial = 0;
    selectedColors = 0;
    emit(SearchInitialSuccess());
  }

  onCangeCat(int val) {
    selectedCat = val;
    emit(SearchInitialSuccess());
  }

  onCangeColor(int val) {
    selectedColors = val;
    emit(SearchInitialSuccess());
  }

  onCangeMaterial(int val) {
    selectedmaterial = val;
    emit(SearchInitialSuccess());
  }

  onCangeSizes(int val) {
    selectedSize = val;
    emit(SearchInitialSuccess());
  }

  onCangePrice(RangeValues values) {
    currentRangeValues = values;
    emit(SearchInitialSuccess());
  }
  // func filter

  sreachProducts(String name) async {
    list.clear();
    emit(SearchInitialLoading());
    searchval = name;
    var body = {
      "itemname": name,
      'minprice': currentRangeValues.start.toString(),
      'maxprice': currentRangeValues.end.toString(),
      "orderBy": OrderBy,
      "orderDirection": orderDirection,
    };
    if (selectedSize != null) {
      body['size'] = size[selectedSize!].toString();
    }
    if (selectedmaterial != null) {
      body['material'] = material[selectedmaterial!].toString();
    }
    if (selectedColors != null) {
      body['color'] = colors[selectedColors!].toString();
    }
    if (selectedCat != null) {
      body['cat'] = (cat.indexOf(cat[selectedCat!]) + 1).toString();
    }

    try {
      Response response = await post(Uri.parse(_userUrl), body: body);
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['data'];
        list.addAll(result);
        print("list is   : $list");
        print(list.length);

        if (list.isEmpty) {
          emit(SearchInitialSuccessNoData());
        } else {
          emit(SearchInitialSuccess());
        }
      } else {
        emit(SearchInitialError());
        throw Exception(response.reasonPhrase);
      }
      // emit(NavBarInitial(val: 0));
    } catch (e) {
      emit(SearchInitialError());
    }
  }
}
