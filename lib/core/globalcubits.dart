import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:one/core/cache_helper.dart';
import 'package:one/res/constant/AppLinks.dart';

var headers = {'Authorization': CacheHelper.getToken()};

abstract class AddFav {}

class AddFavinitialState extends AddFav {}

class AddFaviLoadingState extends AddFav {}

class AddFaviSuccessState extends AddFav {}

class AddFaviErrorState extends AddFav {
  final String msg;

  AddFaviErrorState({required this.msg});
}

class AddFavTokenCubit extends Cubit<AddFav> {
  AddFavTokenCubit() : super(AddFavinitialState());
  final String _baseUrl = AppLinks.addfav;
  addFav(String productID, String userID) async {
    try {
      print("id $productID   user $userID");
      emit(AddFaviLoadingState());
      Response response = await post(Uri.parse(_baseUrl),
          body: {'productid': productID, 'uesrid': userID}, headers: headers);
      Map result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(AddFaviSuccessState());
      } else if (response.statusCode == 400) {
        emit(AddFaviErrorState(msg: "Error: ${result['msg']}"));
      }
    } catch (e) {
      print(e);
      emit(AddFaviErrorState(msg: "Error: $e"));
    }
  }
}

abstract class Addbasket {}

class AddbasketinitialState extends Addbasket {}

class AddbasketiLoadingState extends Addbasket {}

class AddbasketiSuccessState extends Addbasket {}

class AddbasketiErrorState extends Addbasket {}

class AddbasketTokenCubit extends Cubit<Addbasket> {
  AddbasketTokenCubit() : super(AddbasketinitialState());
  final String _baseUrl = AppLinks.addbasket;
  var headers = {'Authorization': CacheHelper.getToken()};

  addBasket(String productID, String userID) async {
    print(headers);
    emit(AddbasketiLoadingState());
    Response response = await post(Uri.parse(_baseUrl),
        body: {'productid': productID}, headers: headers);
    final Map result = jsonDecode(response.body);
    print(result);
    print(response);
    if (response.statusCode == 200) {
      emit(AddbasketiSuccessState());
      emit(AddbasketinitialState());

      // final Map result = jsonDecode(response.body);

      return result;
    } else if (response.statusCode == 400) {
      emit(AddbasketiErrorState());

      throw Exception(response.reasonPhrase);
    }
    emit(AddbasketinitialState());
  }
}

abstract class RemoveBasket {}

class RemoveBasketinitialState extends RemoveBasket {}

class RemoveBasketiLoadingState extends RemoveBasket {}

class RemoveBasketiSuccessState extends RemoveBasket {}

class RemoveBasketiErrorState extends RemoveBasket {}

class RemoveBasketCubit extends Cubit<RemoveBasket> {
  RemoveBasketCubit() : super(RemoveBasketinitialState());
  final String _baseUrl = AppLinks.removeBasket;
  removeBasket(String ID) async {
    emit(RemoveBasketiLoadingState());
    Response response = await post(Uri.parse(_baseUrl), body: {'id': ID});
    final Map result = jsonDecode(response.body);
    print(result);
    print(response);
    if (response.statusCode == 200) {
      emit(RemoveBasketiSuccessState());

      // final Map result = jsonDecode(response.body);

      return result;
    } else if (response.statusCode == 400) {
      emit(RemoveBasketiErrorState());

      throw Exception(response.reasonPhrase);
    }
    emit(RemoveBasketinitialState());
  }
}
