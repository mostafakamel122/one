// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:one/model/HomeProducts.dart';
import 'package:one/res/components/customTextsmall.dart';
import 'package:one/view/Home/cubit/nav_bar_cubit.dart';
import 'package:one/view/Home/repository/homeProductrepo.dart';

import '../../../core/bloc/theme_bloc_bloc.dart';
import '../../../core/globalcubits.dart';
import '../../../core/jwt_token.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/images.dart';
import '../../Auth/screens/signin.dart';
import '../../Home/HomeNav.dart';
import '../../ProductView/productView.dart';
import '../cubit/search_cubit.dart';
import '../widget/upperWidget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
    required this.searchval,
  }) : super(key: key);
  final String searchval;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //  double width = MediaQuery.of(context).size.width;

    final cubit = BlocProvider.of<SearchCubit>(context)
      ..sreachProducts(searchval);
    final cubitAddFav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);

    return PopScope(
      canPop: true, // Or false to prevent popping
      onPopInvoked: (x) async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return BlocProvider(create: (_) => cubit, child: HomeMainNav());
        }), (route) => false);
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CustomTextsmall(text: cubit.searchval),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                        create: (_) => NavBarCubit(HomeRepositoryNav()),
                        child: HomeMainNav());
                  }), (route) => false);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                UpperWidget(height: height, searchval: searchval),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitialLoading) {
                      return Center(
                          child: Lottie.asset(AppImages.lottieLoading));
                    }
                    if (state is SearchInitialError) {
                      return Center(
                          child: Lottie.network(AppImages.lottieEmpty));
                    }
                    return cubit.list.isEmpty
                        ? Column(
                            children: [
                              Center(
                                  child: Lottie.asset(AppImages.lottieEmpty)),
                              const Center(
                                  child: CustomTextsmall(text: 'Empty search')),
                            ],
                          )
                        : Container(
                            height: height * 0.816,
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.65),
                                itemCount: cubit.list.length,
                                itemBuilder: (context, index) {
                                  final List<HomeProducts> products = cubit.list
                                      .map((e) => HomeProducts.fromJson(e))
                                      .toList();
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return ProductView(
                                            homeProducts: products[index]);
                                      }));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(2),
                                      height: height * 0.2,
                                      child: Column(
                                        children: [
                                          Hero(
                                            tag: products[index]
                                                .itemId
                                                .toString(),
                                            child: Container(
                                              height: height * 0.2,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppLinks.imgProducts +
                                                            products[index]
                                                                .itemImg!)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextsmall(
                                                text:
                                                    "${products[index].itemPrice.toString()} L.E",
                                                fontFamily: 'cairo',
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    cubitJwt.id == 0
                                                        ? AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .warning,
                                                                animType: AnimType
                                                                    .rightSlide,
                                                                title:
                                                                    'warning',
                                                                desc:
                                                                    'Please Sign in',
                                                                btnOkOnPress:
                                                                    () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return const SignIn();
                                                                  }));
                                                                },
                                                                btnOkColor:
                                                                    Colors
                                                                        .black)
                                                            .show()
                                                        : cubitAddFav.addFav(
                                                            products[index]
                                                                .itemId
                                                                .toString(),
                                                            cubitJwt.id
                                                                .toString());
                                                  },
                                                  icon: Image.asset(
                                                      AppImages.savepng,
                                                      color: context
                                                                  .read<
                                                                      ThemeBlocBloc>()
                                                                  .state ==
                                                              ThemeMode.dark
                                                          ? Colors.white
                                                          : null))
                                            ],
                                          ),
                                          CustomTextsmall(
                                            text: products[index]
                                                .itemName
                                                .toString(),
                                            fontFamily: 'cairo',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
