import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'res/constant/images.dart';
import 'view/Home/HomeNav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  SharedPreferences? prefs;

  splash() async {
    prefs = await SharedPreferences.getInstance();

    Future.delayed(Duration(seconds: 5), () {
      // if (prefs?.getString('token') != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return HomeMainNav();
      }), (route) => false);
      // } else {
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) {
      //     return SignIn();
      //   }), (route) => false);
      // }
    });
  }

  double height = Get.height;
  double width = Get.width;

  @override
  void initState() {
    splash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppImages.splash,
        height: height,
        width: width,
      ),
    );
  }
}
