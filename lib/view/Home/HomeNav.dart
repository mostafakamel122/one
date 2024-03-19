import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:one/core/jwt_token.dart';
import 'package:one/res/constant/images.dart';
import 'package:one/view/Home/cubit/nav_bar_cubit.dart';
import 'package:one/view/Home/repository/homeProductrepo.dart';
import 'package:one/view/favorite/screen/favorite.dart';

import '../../core/bloc/theme_bloc_bloc.dart';
import '../../data/dataApp.dart';
import '../../res/components/customTextformauth.dart';
import '../pageSeach/cubit/search_cubit.dart';
import '../pageSeach/screens/searchpage.dart';
import '../setting/setting.dart';

class HomeMainNav extends StatelessWidget {
  const HomeMainNav({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavBarCubit(HomeRepositoryNav()),
        ),
        BlocProvider(
          create: (context) => NavBarCubitSearch(),
        ),
      ],
      child: HomeNavBody(),
    );
  }
}

class HomeNavBody extends StatelessWidget {
  const HomeNavBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    //JwtTokenCubit cubitJwt =
    BlocProvider.of<JwtTokenCubit>(context)
      ..refreshjwt()
      ..fetchTokenAndDecode();
    return BlocConsumer<NavBarCubit, NavBarState>(
      listener: (context, state) {
        final homeRepositoryNav = context.read<NavBarCubit>();
        if (state is NavBarInitialSuccess) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BlocProvider(
                create: (_) => SearchCubit(),
                child: SearchPage(searchval: homeRepositoryNav.searchval));
          }));
        }
        if (state is NavBarInitialError) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BlocProvider(
                create: (_) => SearchCubit(),
                child: SearchPage(searchval: homeRepositoryNav.searchval));
          }));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              context.read<ThemeBlocBloc>().state == ThemeMode.dark
                  ? AppImages.whitelogo
                  : AppImages.blacklogo,
              width: 75,
              color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                  ? Colors.white
                  : null,
            ),
            centerTitle: true,
            actions: [
              BlocBuilder<NavBarCubitSearch, NavBarStateSearch>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: _buildChildBasedOnState(context, state),
                  );
                },
              ),
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SettingScreen();
                  }));
                },
                icon: Image.asset(AppImages.barssolidpng,
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Colors.white
                        : null)),
          ),
          bottomNavigationBar: BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              return GNav(
                  padding: const EdgeInsets.all(15),
                  onTabChange: (val) {
                    context.read<NavBarCubit>().onchangeSelected(val);
                    print(val);
                  },
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'home'.tr,
                    ),
                    GButton(
                      leading: Image.asset(
                        AppImages.aucationpng,
                        width: 25,
                        height: 25,
                        color: context.read<ThemeBlocBloc>().state ==
                                ThemeMode.dark
                            ? Colors.white
                            : Color(0xFF1C1B1F),
                      ),
                      icon: Icons.favorite,
                      text: 'auction'.tr,
                    ),
                    GButton(
                      icon: Icons.design_services,
                      text: 'design'.tr,
                    ),
                    GButton(
                      icon: Icons.shopping_cart,
                      text: 'cart'.tr,
                    )
                  ]);
            },
          ),
          body: BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              if (state is NavBarInitial) {
                return SafeArea(child: widget.elementAt(state.val!));
              }
              return Center(child: Lottie.asset(AppImages.lottieLoading));
            },
          ),
        );
      },
    );
  }
}

Widget _buildChildBasedOnState(BuildContext context, NavBarStateSearch state) {
  if (state is NavBarInitialSearch) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      width: width * 0.8,
      height: height * 0.06,
      child: CustomTextFormAuth(
        prefixIcon: const Icon(Icons.search),
        hintText: '',
        icon: Icons.arrow_forward_ios,
        labelText: 'search',
        maxvalidator: 50,
        minvalidator: 3,
        msgvalidatormax: 'لا يمكن ان يكون اكثر من ',
        msgvalidatormin: 'لا يمكن ان يقول اقل من ',
        onPressedicon: () {
          context.read<NavBarCubitSearch>().onSreachremover();
        },
        onFieldSubmitted: (String x) {
          print(x);
          context.read<NavBarCubit>().sreachProducts(x);
        },
      ),
    );
  } else {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FavoriteScreen();
            }));
          },
          icon: Image.asset(AppImages.savepng,
              color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                  ? Colors.white
                  : null),
        ),
        IconButton(
          onPressed: () {
            context.read<NavBarCubitSearch>().onSreach();
          },
          icon: Image.asset(AppImages.searchpng,
              color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                  ? Colors.white
                  : null),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
