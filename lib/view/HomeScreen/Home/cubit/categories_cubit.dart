import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:one/model/subCat.dart';

import '../../../../res/constant/AppLinks.dart';
import 'package:http/http.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  final String _userUrl = AppLinks.viewcat;
  List<SubCat> listCatMain = [];
  Future<void> getSubCat(int selectedCat) async {
    emit(CategoriesInitialLoading());
    Response response = await post(Uri.parse(_userUrl),
        body: {"catID": selectedCat.toString()});

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];

      emit(CategoriesInitialSuccess(
          result.map((e) => SubCat.fromJson(e)).toList()));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
