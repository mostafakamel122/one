import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:one/res/constant/AppLinks.dart';

part 'sub_cat_view_state.dart';

class SubCatViewCubit extends Cubit<SubCatViewState> {
  SubCatViewCubit() : super(SubCatViewInitial());
  List products = [];
  int page = 1;
  String OrderBy = "item_time";
  String orderDirection = "DESC";
  getdata(int ID) async {
    products.clear();
    const String _userUrl = AppLinks.productsViewsubCat;
    emit(SubCatViewInitialLoading());
    Response response = await post(Uri.parse(_userUrl), body: {
      "ID": '$ID',
      "page": "$page",
      "orderBy": OrderBy,
      "orderDirection": orderDirection,
    });

    if (response.statusCode == 200) {
      products = jsonDecode(response.body)['data'];
      emit(SubCatViewInitialSuccess());
    } else {
      emit(SubCatViewInitialError());

      throw Exception(response.reasonPhrase);
    }
  }

  looadmoreData(int ID) async {
    page++;
    const String _userUrl = AppLinks.productsViewsubCat;
    emit(SubCatViewInitialLoadMore());
    Response response = await post(Uri.parse(_userUrl), body: {
      "ID": '$ID',
      "page": "$page",
      "orderBy": OrderBy,
      "orderDirection": orderDirection,
    });

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['data'];
      if (list.isEmpty) {
        emit(SubCatViewInitialnoMoreData());
      } else {
        products.addAll(list);
        emit(SubCatViewInitialSuccess());
      }
    } else {
      emit(SubCatViewInitialError());

      throw Exception(response.reasonPhrase);
    }
  }
}
