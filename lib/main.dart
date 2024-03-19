import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:one/core/globalcubits.dart';
import 'package:one/theme.dart';
import 'package:one/view/Design/cubit/design_cubit.dart';
import 'package:one/view/setting/cubit/setting_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/bloc/theme_bloc_bloc.dart';
import 'core/cache_helper.dart';
import 'core/jwt_token.dart';
import 'core/services.dart';
import 'localizatoin/changelocal.dart';
import 'localizatoin/translation.dart';
import 'splashscree.dart';
import 'view/Home/cubit/nav_bar_cubit.dart';
import 'view/Home/repository/homeProductrepo.dart';
import 'view/HomeScreen/Home/cubit/home_products_cubit.dart';
import 'view/ProductView/cubit/product_view_cubit.dart';
import 'view/mazad/cubit/mazad_cubit.dart';
import 'view/pageSeach/cubit/search_cubit.dart';
import 'view/shopping/cubit/basket_cubit.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
  await Future.wait([
    CacheHelper.init(),
  ]);
  await initialServices();
  runApp(const MyApp());
  prefs = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode =
        CacheHelper.getMode() == "dark" ? ThemeMode.dark : ThemeMode.light;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductViewCubit(),
        ),
        BlocProvider(
          create: (context) => JwtTokenCubit()
            // ..refreshjwt()
            ..fetchTokenAndDecode(),
        ),
        BlocProvider(
          create: (context) => DesignCubit(),
        ),
        BlocProvider(
          create: (context) => AddFavTokenCubit(),
        ),
        BlocProvider(
          create: (context) => HomeProductsCubit(),
        ),
        BlocProvider(
          create: (context) => NavBarCubit(HomeRepositoryNav()),
        ),
        BlocProvider(
          create: (context) => ThemeBlocBloc(themeMode),
        ),
        BlocProvider(
          create: (context) => BasketCubit(),
        ),
        BlocProvider(
          create: (context) => SettingCubit(),
        ),
        BlocProvider(
          create: (context) => MazadCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BlocBuilder<ThemeBlocBloc, ThemeMode>(
        builder: (context, state) {
          LocalController controller = Get.put(LocalController());

          return GetMaterialApp(
              translations: MyTranslatoin(),
              locale: controller.language,
              debugShowCheckedModeBanner: false,
              theme: lightMood,
              themeMode: state,
              darkTheme: DarkMood,
              home: SplashScreen());
        },
      ),
    );
  }
}
