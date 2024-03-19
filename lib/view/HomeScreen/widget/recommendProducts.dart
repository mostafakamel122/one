//widget RecommendedSlider
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/theme_bloc_bloc.dart';
import '../../../core/globalcubits.dart';
import '../../../core/jwt_token.dart';
import '../../../model/HomeProducts.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/images.dart';
import '../../Auth/screens/signin.dart';
import '../../ProductView/productView.dart';
import '../Home/cubit/home_products_cubit.dart';

class RecommendedSlider extends StatelessWidget {
  final List<HomeProducts> products;
  final HomeProductsCubit cubit;
  const RecommendedSlider({
    Key? key,
    required this.cubit,
    required this.height,
    required this.products,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final cubitFav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);

    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        itemCount: cubit.list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProductView(
                  homeProducts: products[index],
                );
              }));
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              height: height * 0.2,
              child: Column(
                children: [
                  Container(
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              AppLinks.imgProducts + products[index].itemImg!)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextsmall(
                        text: "${products[index].itemPrice.toString()} L.E",
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      IconButton(
                          onPressed: () {
                            cubitJwt.id == 0
                                ? AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.rightSlide,
                                        title: 'warning',
                                        desc: 'Please Sign in',
                                        btnOkOnPress: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const SignIn();
                                          }));
                                        },
                                        btnOkColor: Colors.black)
                                    .show()
                                : cubitFav.addFav(
                                    products[index].itemId.toString(),
                                    cubitJwt.id.toString());
                          },
                          icon: Row(
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                color: context.read<ThemeBlocBloc>().state ==
                                        ThemeMode.dark
                                    ? Colors.white
                                    : null,
                              ),
                              CustomTextsmall(
                                  text: products[index].likes_count.toString())
                            ],
                          ))
                    ],
                  ),
                  CustomTextsmall(
                    alignment: AlignmentDirectional.topStart,
                    text: products[index].itemName.toString(),
                    fontFamily: 'cairo',
                    color: Color(0xFF434343),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ProductSlider extends StatelessWidget {
  final List<HomeProducts> products;

  final HomeProductsCubit cubit;
  const ProductSlider({
    super.key,
    required this.height,
    required this.products,
    required this.cubit,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    final cubitfav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        itemCount: cubit.list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProductView(
                  homeProducts: products[index],
                );
              }));
            },
            child: Container(
              margin: const EdgeInsets.all(4),
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
                            image: NetworkImage(AppLinks.imgProducts +
                                products[index].itemImg!)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextsmall(
                        text: "${products[index].itemPrice.toString()} L.E",
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      IconButton(
                          onPressed: () {
                            cubitJwt.id == 0
                                ? AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.rightSlide,
                                        title: 'warning',
                                        desc: 'Please Sign in',
                                        btnOkOnPress: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const SignIn();
                                          }));
                                        },
                                        btnOkColor: Colors.black)
                                    .show()
                                : cubitfav.addFav(
                                    products[index].itemId.toString(),
                                    cubitJwt.id.toString());
                          },
                          icon: Image.asset(AppImages.savepng,
                              color: context.read<ThemeBlocBloc>().state ==
                                      ThemeMode.dark
                                  ? Colors.white
                                  : null))
                    ],
                  ),
                  CustomTextsmall(
                    alignment: AlignmentDirectional.topStart,
                    text: products[index].itemName.toString(),
                    fontFamily: 'cairo',
                    color: Color(0xFF434343),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
