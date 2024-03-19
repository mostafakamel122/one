import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';

import '../../../core/cache_helper.dart';
import '../../../model/HomeProducts.dart';
import '../../../res/constant/AppLinks.dart';

part 'product_view_state.dart';

class ProductViewCubit extends Cubit<ProductViewState> {
  ProductViewCubit() : super(ProductViewInitial());
  List<String> sizes = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
  ];
  List<HomeProducts> list = [];
  final String _userUrl = AppLinks.productsView;
  var headers = {'Authorization': CacheHelper.getToken()};

  int selectedSize = 0;
  onChangeSize(int val) {
    selectedSize = val;
    emit(ProductViewInitialSuccess());
  }

  getdata() async {
    emit(ProductViewInitialLoading());
    Response response = await await post(Uri.parse(_userUrl), body: {
      "catID": '1',
      "page": "1",
    });
    ;
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      list = result.map((e) => HomeProducts.fromJson(e)).toList();
      emit(ProductViewInitialSuccess());
    } else {
      emit(ProductViewInitialError(response.body));
    }
  }
}
