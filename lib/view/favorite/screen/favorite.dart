// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:one/view/ProductView/productView.dart';

import '../../../core/jwt_token.dart';
import '../../../model/HomeProducts.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/images.dart';
import '../cubit/favorite_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteCubit(FavRepository()),
        ),
      ],
      child: FavoriteView(height: height),
    );
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const CustomTextsmall(
                text: 'Wishlist', fontWeight: FontWeight.bold)),
        body: ViewFav());
  }
}

class ViewFav extends StatelessWidget {
  const ViewFav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    BlocProvider.of<FavoriteCubit>(context).getFav();
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);

    final cubitFav = BlocProvider.of<FavoriteCubit>(context);
    return cubitJwt.id == 0
        ? Column(
            children: [
              Center(child: Lottie.asset(AppImages.lottieEmpty)),
              Center(child: CustomTextsmall(text: 'Empty'.tr)),
            ],
          )
        : BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FaviriiLoadingState) {
                return Center(child: Lottie.asset(AppImages.lottieLoading));
              }
              if (state is FaviriiErrorState) {
                return Center(
                    child: Lottie.network(AppImages.lottieErrorNetwork));
              }
              if (state is FaviriiSuccessState) {
                return cubitFav.favProducts.isEmpty
                    ? Column(
                        children: [
                          Center(child: Lottie.asset(AppImages.lottieEmpty)),
                          const Center(child: CustomTextsmall(text: 'Empty')),
                        ],
                      )
                    : Container(
                        margin: const EdgeInsets.all(5),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.65),
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              List<HomeProducts> products = state.list;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ProductView(
                                      homeProducts: products[index],
                                    );
                                  }));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  height: height * 0.2,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height * 0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(AppLinks
                                                      .imgProducts +
                                                  products[index].itemImg!)),
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
                                              onPressed: () async {
                                                cubitFav.removeFav(
                                                  products[index]
                                                      .itemId
                                                      .toString(),
                                                );
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                      CustomTextsmall(
                                        text:
                                            products[index].itemName.toString(),
                                        fontFamily: 'cairo',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
  }
}
