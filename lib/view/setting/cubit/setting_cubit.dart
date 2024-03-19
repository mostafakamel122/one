import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';

import '../../../core/cache_helper.dart';
import '../../../res/constant/AppLinks.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  int wallet = 0;
  final String _userUrl = AppLinks.viewWallet;
  var headers = {'Authorization': CacheHelper.getToken()};
  List list = [];
  List listTransaction = [];

  getWalletData() async {
    print(headers);

    emit(SettingInitialLoading());
    Response response = await get(Uri.parse(_userUrl), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      emit(SettingInitialSuccess());
      var responseBody = jsonDecode(response.body);
      wallet = responseBody['wallet'];
      list = responseBody['myTeam'];
      listTransaction = responseBody['Transction'];
    } else {
      print(response.body);

      emit(SettingInitialError());
    }
  }
}
