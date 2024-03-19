import 'dart:convert';

import 'package:http/http.dart';
import 'package:one/res/constant/AppLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/BasketModel.dart';

class BasketRepository {
  final String _userUrl = AppLinks.viewbasket;

  Future<List<BasketModel>> getdata() async {
    SharedPreferences? _prefs;

    _prefs = await SharedPreferences.getInstance();
    Response response =
        await post(Uri.parse(_userUrl), body: {'uesrid': _prefs.get('id')});

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      print(response.body);

      return result.map((e) => BasketModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
