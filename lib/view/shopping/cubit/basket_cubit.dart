// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:one/core/cache_helper.dart';

import '../../../model/BasketModel.dart';
import '../../../res/constant/AppLinks.dart';
import 'controller.dart';

part 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit() : super(BasketinitialState());
  final String _userUrl = AppLinks.viewbasket;
  final String _baseUrl = AppLinks.removeBasket;
  final String _convertToOwner = AppLinks.convertToOrder;
  BasketControllers basketControllers = BasketControllers();
  String address = '';
  String buildNum = '';
  String city = '';
  String notes = '';

  int total = 0;
  var responsebody;
  var headers = {'Authorization': CacheHelper.getToken()};
  List<BasketModel> list = [];
  getBasketView() async {
    emit(BasketiLoadingState());
    try {
      Response response = await post(Uri.parse(_userUrl),
          body: {'uesrid': CacheHelper.getid()}, headers: headers);
      final List result = jsonDecode(response.body)['data'];
      responsebody = jsonDecode(response.body);
      total = responsebody['total'];
      print(response.body);
      list = result.map((e) => BasketModel.fromJson(e)).toList();
      emit(BasketiSuccessState());
    } catch (e) {
      emit(BasketiErrorState());

      print(e);
    }
  }

  removeBasket(String ID) async {
    emit(BasketiLoadingState());
    Response response = await post(Uri.parse(_baseUrl), body: {'id': ID});
    final Map result = jsonDecode(response.body);
    print(result);
    print(response);
    if (response.statusCode == 200) {
      getBasketView();
      // final Map result = jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      emit(BasketiErrorState());

      throw Exception(response.reasonPhrase);
    }
  }

  orderBasket() async {
    print(headers);
    //  emit(BasketiLoadingState());
    Response response = await post(Uri.parse(_convertToOwner),
        body: {
          'notes': notes,
          'buildNum': buildNum,
          'address': address,
          'city': city,
          'totalPrice': total.toString(),
        },
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);

      emit(BasketiDonetate());
    } else if (response.statusCode == 400) {
      emit(BasketiErrorState());

      throw Exception(response.reasonPhrase);
    }
  }

  saveAddress(
      String addrsesFun, String buildNumFun, String cityFun, String notesFun) {
    address = addrsesFun;
    buildNum = buildNumFun;
    city = cityFun;
    notes = notesFun;
    emit(BasketiSuccessState());
  }
}
