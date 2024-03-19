// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:one/core/jwt_token.dart';
import 'package:one/res/components/customTextsmall.dart';
import 'package:one/res/constant/AppLinks.dart';
import 'package:one/view/ProductView/cubit/product_view_cubit.dart';

import '../../core/bloc/theme_bloc_bloc.dart';
import '../../core/globalcubits.dart';
import '../../model/HomeProducts.dart';
import '../../res/constant/ColorApp.dart';
import '../../res/constant/images.dart';
import '../Auth/screens/signin.dart';

class ProductView extends StatelessWidget {
  final HomeProducts homeProducts;
  const ProductView({
    Key? key,
    required this.homeProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddbasketTokenCubit(),
        ),
        BlocProvider(
          create: (context) => JwtTokenCubit(),
        ),
        BlocProvider(
          create: (context) => AddFavTokenCubit(),
        ),
      ],
      child: ProductViewMain(
        height: height,
        width: width,
        homeProducts: homeProducts,
      ),
    );
  }
}

class ProductViewMain extends StatelessWidget {
  const ProductViewMain({
    Key? key,
    required this.height,
    required this.width,
    required this.homeProducts,
  }) : super(key: key);

  final double height;
  final double width;
  final HomeProducts homeProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddbasketTokenCubit>(context);
    final cubitfav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitProduct = BlocProvider.of<ProductViewCubit>(context)..getdata();

    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context)
      ..fetchTokenAndDecode();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const CustomTextsmall(
            text: 'Product Details',
            fontSize: 18,
          )),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: ListView(
          children: [
            Hero(
              tag: homeProducts.itemId.toString(),
              child: Container(
                height: height * 0.5,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppLinks.imgProducts + homeProducts.itemImg!)),
                ),
              ),
            ),
            BlocConsumer<AddFavTokenCubit, AddFav>(
              listener: (context, state) {
                if (state is AddFaviSuccessState) {
                  Get.snackbar('تم بنجاح', 'تم الاضافة في السلة بنجاح');
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextsmall(
                      text: homeProducts.itemName!,
                      fontFamily: 'cairo',
                      fontSize: 16,
                    ),
                    IconButton(
                        onPressed: () {
                          cubitfav.addFav(homeProducts.itemId.toString(),
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
                                text: homeProducts.likes_count.toString())
                          ],
                        )),
                  ],
                );
              },
            ),
            CustomTextsmall(
              text: '${homeProducts.itemPrice} L.E',
              fontFamily: 'cairo',
              fontSize: 16,
            ),
            SizedBox(height: 10),
            BlocBuilder<ProductViewCubit, ProductViewState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    _showDialog(
                        context,
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,

                          useMagnifier: true,
                          itemExtent: 32,
                          // This sets the initial item.
                          scrollController: FixedExtentScrollController(
                            initialItem: cubitProduct.selectedSize,
                          ),
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            cubitProduct.onChangeSize(selectedItem);
                          },

                          children: List<Widget>.generate(
                              cubitProduct.sizes.length, (int index) {
                            return Center(
                                child: CustomTextsmall(
                                    text: cubitProduct.sizes[index]));
                          }),
                        ),
                        height);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CustomTextsmall(
                              text: 'Size:  ', color: Colors.grey.shade800),
                          CustomTextsmall(
                            text: cubitProduct.sizes[cubitProduct.selectedSize],
                            color: Colors.grey.shade300,
                            fontSize: 14,
                          ),
                        ],
                      )),
                );
              },
            ),
            SizedBox(height: 10),
            BlocConsumer<AddbasketTokenCubit, Addbasket>(
              listener: (context, state) {
                if (state is AddbasketiSuccessState) {
                  Get.snackbar('تم بنجاح', 'تم الاضافة في السلة بنجاح');
                }
                if (state is AddbasketiErrorState) {
                  Get.snackbar('خطا', "Error:");
                }
              },
              builder: (context, state) {
                return MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    height: height * 0.05,
                    color: ColorApp.black,
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
                                        MaterialPageRoute(builder: (context) {
                                      return const SignIn();
                                    }));
                                  },
                                  btnOkColor: Colors.black)
                              .show()
                          : cubit.addBasket(homeProducts.itemId.toString(),
                              cubitJwt.id.toString());
                    },
                    child: const CustomTextsmallCase(
                      text: 'Add To Cart',
                      color: Colors.white,
                    ));
              },
            ),
            SizedBox(height: 5),
            const CustomTextsmall(
              text: 'product details',
              fontFamily: 'cairo',
              fontSize: 16,
            ),
            CustomTextsmall(
              text: homeProducts.itemDesc!,
              fontFamily: 'cairo',
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
            const Divider(thickness: 2, height: 5),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const CustomTextsmall(
            //       text: 'Shop More From ONDE',
            //       fontFamily: 'cairo',
            //       fontSize: 18,
            //     ),
            //     IconButton(
            //         onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
            //   ],
            // ),
            //const Divider(thickness: 2, height: 5),
            // SizedBox(height: 10),
            const CustomTextsmall(
              text: 'More Like',
              fontFamily: 'cairo',
              fontSize: 18,
            ),
            SizedBox(height: 10),
            BlocBuilder<ProductViewCubit, ProductViewState>(
              builder: (context, state) {
                if (state is ProductViewInitialLoading) {
                  return Center(child: Lottie.asset(AppImages.lottieLoading));
                }
                if (state is ProductViewInitialError) {
                  return Center(child: Lottie.network(AppImages.lottieEmpty));
                }
                return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.65),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      List<HomeProducts> listModel = cubitProduct.list;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProductView(
                              homeProducts: listModel[index],
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
                                      image: NetworkImage(AppLinks.imgProducts +
                                          listModel[index].itemImg!)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextsmall(
                                    text: '${listModel[index].itemPrice} L.E',
                                    fontFamily: 'cairo',
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(AppImages.savepng))
                                ],
                              ),
                              CustomTextsmall(
                                text: listModel[index].itemName!,
                                fontFamily: 'cairo',
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, Widget child, double height) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      decoration: BoxDecoration(
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: height * 0.3,
      padding: const EdgeInsets.only(top: 6.0),
      // The Bottom margin is provided to align the popup above the system navigation bar.
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),

      // Use a SafeArea widget to avoid system overlaps.
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}
