import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services.dart';

class LocalController extends GetxController {
  Locale? language;
  MyServices myservices = Get.find();
  changeLang(String codelang) {
    Locale locale = Locale(codelang);
    myservices.sharedPreferences.setString("lang", codelang);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedpreflang = myservices.sharedPreferences.getString("lang");
    if (sharedpreflang == "ar") {
      language = const Locale("ar");
    } else if (sharedpreflang == "en") {
      language = const Locale("en");
    } else {
      language = const Locale("en");
      // language = Locale(Get.deviceLocale!.languageCode);
    }
    // TODO: implement onInit
    super.onInit();
  }
}
