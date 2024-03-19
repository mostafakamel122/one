import 'package:get/get.dart';

import '../core/services.dart';

translateString(columnAr, columnEn) {
  MyServices myServices = Get.find();
  if (myServices.sharedPreferences.getString('lang') == 'ar') {
    return columnAr;
  } else {
    return columnEn;
  }
}
