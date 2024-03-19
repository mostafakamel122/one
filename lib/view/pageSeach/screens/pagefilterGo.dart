// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:one/model/HomeProducts.dart';
import 'package:one/res/components/customTextsmall.dart';

import '../../../core/globalcubits.dart';
import '../../../core/jwt_token.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/images.dart';
import '../../Auth/screens/signin.dart';
import '../../ProductView/productView.dart';
import '../cubit/search_cubit.dart';

class SearchPageFilter extends StatelessWidget {
  const SearchPageFilter({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SearchCubit cubit;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final cubitAddFav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);
    final search = BlocProvider.of<SearchCubit>(context)
      ..sreachProducts(cubit.searchval);

    cubit.sreachProducts(cubit.searchval);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomTextsmall(text: "seaech filter:" + cubit.searchval),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              //       UpperWidget(height: height),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitialLoading) {
                    return Center(child: Lottie.asset(AppImages.lottieLoading));
                  }
                  if (state is SearchInitialError) {
                    return Center(child: Lottie.network(AppImages.lottieEmpty));
                  }
                  if (state is SearchInitialSuccessNoData) {
                    return Column(
                      children: [
                        Center(child: Lottie.network(AppImages.lottieEmpty)),
                        const Center(
                            child: CustomTextsmall(text: 'Empty search')),
                      ],
                    );
                  }

                  return Container(
                    height: height * 0.816,
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.65),
                        itemCount: cubit.list.length,
                        itemBuilder: (context, index) {
                          final List<HomeProducts> products = cubit.list
                              .map((e) => HomeProducts.fromJson(e))
                              .toList();
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
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
                                    tag: products[index].itemId.toString(),
                                    child: Container(
                                      height: height * 0.2,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppLinks.imgProducts +
                                                    products[index].itemImg!)),
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
                                                        context: context,
                                                        dialogType:
                                                            DialogType.warning,
                                                        animType:
                                                            AnimType.rightSlide,
                                                        title: 'warning',
                                                        desc: 'Please Sign in',
                                                        btnOkOnPress: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return const SignIn();
                                                          }));
                                                        },
                                                        btnOkColor:
                                                            Colors.black)
                                                    .show()
                                                : cubitAddFav.addFav(
                                                    products[index]
                                                        .itemId
                                                        .toString(),
                                                    cubitJwt.id.toString());
                                          },
                                          icon:
                                              const Icon(Icons.favorite_border))
                                    ],
                                  ),
                                  CustomTextsmall(
                                    text: products[index].itemName.toString(),
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
        ));
  }
}
