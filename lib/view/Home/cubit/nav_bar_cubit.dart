import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:one/model/HomeProducts.dart';

import '../../../res/constant/AppLinks.dart';
import '../repository/homeProductrepo.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  final HomeRepositoryNav _homeRepository;

  NavBarCubit(this._homeRepository) : super(NavBarInitial(val: 0));
  late String searchval;
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
  //declr filter
  // func filter
  onopenfilter() {
    selectedCat = 0;
    selectedSize = 0;
    selectedmaterial = 0;
    selectedColors = 0;
    emit(NavBarInitialLoading());
  }

  onCangeCat(int val) {
    selectedCat = val;
    emit(NavBarInitialChange());
  }

  onCangeColor(int val) {
    selectedColors = val;
    emit(NavBarInitialChange());
  }

  onCangeMaterial(int val) {
    selectedmaterial = val;
    emit(NavBarInitialChange());
  }

  onCangeSizes(int val) {
    selectedSize = val;
    emit(NavBarInitialChange());
  }

  onCangePrice(RangeValues values) {
    currentRangeValues = values;
    emit(NavBarInitialChange());
  }
  // func filter

  onchangeSelected(int val) {
    emit(NavBarInitial(val: val));
  }

  sreachProducts(String name) async {
    emit(NavBarInitialLoading());
    searchval = name;
    var body = {
      "itemname": name,
      'minprice': currentRangeValues.start.toString(),
      'maxprice': currentRangeValues.end.toString(),
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
      print("swarch" + response.body);
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['data'];
        print(result);
        emit(NavBarInitialSuccess(
            list: result.map((e) => HomeProducts.fromJson(e)).toList()));

        return result.map((e) => HomeProducts.fromJson(e)).toList();
      } else {
        emit(NavBarInitialLoading());
        throw Exception(response.reasonPhrase);
      }
      // emit(NavBarInitial(val: 0));
    } catch (e) {
      emit(NavBarInitialError());
    }
  }
}

abstract class NavBarStateSearch {}

class NavBarStateinit extends NavBarStateSearch {}

class NavBarInitialSearch extends NavBarStateSearch {}

class NavBarCubitSearch extends Cubit<NavBarStateSearch> {
  NavBarCubitSearch() : super(NavBarStateinit());

  onSreach() {
    emit(NavBarInitialSearch());
  }

  onSreachremover() {
    emit(NavBarStateinit());
  }
}
