// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:one/res/components/customTextsmall.dart';

import '../../../core/globalcubits.dart';

import '../widget/recommendProducts.dart';
import '../widget/updderWidget.dart';
import 'cubit/categories_cubit.dart';
import 'cubit/home_products_cubit.dart';
import 'screensHome/seeAllproducts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit(),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final cubit = BlocProvider.of<HomeProductsCubit>(context)..getdata();

    // final subCatCubit =
    BlocProvider.of<CategoriesCubit>(context)..getSubCat(1);
    return BlocConsumer<AddFavTokenCubit, AddFav>(
      listener: (context, state) {
        if (state is AddFaviSuccessState) {
          Get.snackbar('تم بنجاح', 'تم الاضافة في المفضلة بنجاح');
        }
        if (state is AddFaviErrorState) {
          Get.snackbar('خطا', "Error: ${state.msg}");
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              UpperWidgerHome(
                width: width,
                height: height,
                cat: cubit.cat,
                homeProductsCubit: cubit,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.bottomCenter,
                height: height * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/homeimg.png"))),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          children: [
                            const CustomTextsmallCase(
                              text: 'offwhite Shirt with \n Blue Writings',
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            // Container(
                            //   width: width * 0.4,
                            //   height: 50,
                            //   margin: const EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(3),
                            //       color: Color(0xff262626)),
                            //   child: const CustomTextsmallCase(
                            //     alignment: Alignment.center,
                            //     fontSize: 18,
                            //     text: 'SHOP NOW',
                            //     color: Colors.white,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // )
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<HomeProductsCubit, HomeProductsState>(
                builder: (context, state) {
                  if (state is HomeProductsLoading) {}
                  if (state is HomeProductsSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextsmall(
                          text: 'recommendForu'.tr,
                          fontFamily: 'cairo',
                          color: Color(0xFF434343),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SeeAllProducts(
                                  products: cubit.list, cubit: cubit);
                            }));
                          },
                          child: CustomTextsmall(
                            text: 'seeAll'.tr,
                            fontFamily: 'cairo',
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    );
                  }
                  return Text('');
                },
              ),
              const SizedBox(height: 5),
              BlocBuilder<HomeProductsCubit, HomeProductsState>(
                builder: (context, state) {
                  if (state is HomeProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is HomeProductsError) {
                    return Center(
                        child: CustomTextsmall(
                            text: state.msg,
                            fontSize: 20,
                            fontWeight: FontWeight.bold));
                  }
                  if (state is HomeProductsSuccess) {
                    return RecommendedSlider(
                      height: height,
                      cubit: cubit,
                      products: cubit.list,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              BlocBuilder<HomeProductsCubit, HomeProductsState>(
                builder: (context, state) {
                  if (state is HomeProductsLoading) {}
                  if (state is HomeProductsSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextsmall(
                          text: 'recommendForu'.tr,
                          fontFamily: 'cairo',
                          color: Color(0xFF434343),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SeeAllProducts(
                                  products: cubit.list, cubit: cubit);
                            }));
                          },
                          child: CustomTextsmall(
                            text: 'seeAll'.tr,
                            fontFamily: 'cairo',
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    );
                  }
                  return Text('');
                },
              ),
              const SizedBox(height: 5),
              BlocBuilder<HomeProductsCubit, HomeProductsState>(
                builder: (context, state) {
                  if (state is HomeProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is HomeProductsError) {
                    return Center(
                        child: CustomTextsmall(
                            text: state.msg,
                            fontSize: 20,
                            fontWeight: FontWeight.bold));
                  }
                  if (state is HomeProductsSuccess) {
                    return ProductSlider(
                      height: height,
                      cubit: cubit,
                      products: cubit.list,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
