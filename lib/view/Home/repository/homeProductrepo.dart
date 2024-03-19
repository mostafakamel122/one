import 'dart:convert';

import 'package:http/http.dart';
import 'package:one/model/HomeProducts.dart';
import 'package:one/res/constant/AppLinks.dart';

class HomeRepositoryNav {
  final String _userUrl = AppLinks.productsViewsearch;

  Future<List<HomeProducts>> getdata(String name) async {
    Response response =
        await post(Uri.parse(_userUrl), body: {"itemname": name});

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      print(result);

      return result.map((e) => HomeProducts.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
