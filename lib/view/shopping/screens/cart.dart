import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one/res/components/customTextsmall.dart';
import 'package:one/res/constant/ColorApp.dart';
import 'package:lottie/lottie.dart';

import '../../../core/jwt_token.dart';
import '../../../model/BasketModel.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/images.dart';
import '../cubit/basket_cubit.dart';
import 'deilverdToScreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BasketCubit(),
        ),
      ],
      child: BasketView(height: height, width: width),
    );
  }
}

class BasketView extends StatelessWidget {
  const BasketView({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BasketCubit>(context).getBasketView();

    final cubitBasket = BlocProvider.of<BasketCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);

    return cubitJwt.id == 0
        ? Column(
            children: [
              Center(child: Lottie.network(AppImages.lottieemptyCart)),
              Center(child: CustomTextsmall(text: 'Empty'.tr)),
            ],
          )
        : BlocBuilder<BasketCubit, BasketState>(
            builder: (context, state) {
              if (state is BasketiLoadingState) {
                return Center(child: Lottie.asset(AppImages.lottieLoading));
              }
              if (state is BasketiErrorState) {
                Center(child: Lottie.network(AppImages.lottieErrorNetwork));
              }
              if (state is BasketiSuccessState) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.71,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubitBasket.list.length,
                              itemBuilder: ((context, index) {
                                List<BasketModel> products = cubitBasket.list;

                                return Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      height: height * 0.3,
                                      width: width * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppLinks.imgProducts +
                                                    products[index].itemImg!)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextsmall(
                                            text: products[index].itemName!,
                                            fontFamily: 'cairo',
                                          ),
                                          CustomTextsmall(
                                            text:
                                                '${products[index].itemPrice!}',
                                            fontFamily: 'cairo',
                                            color: Colors.grey.shade700,
                                          ),
                                          CustomTextsmall(
                                            text: 'color: Gray',
                                            fontFamily: 'cairo',
                                            color: Colors.grey.shade700,
                                          ),
                                          CustomTextsmall(
                                            text: '1',
                                            fontFamily: 'cairo',
                                            color: Colors.grey.shade700,
                                          ),
                                          SizedBox(height: height * 0.085),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextsmall(
                                                text: 'Delete',
                                                fontFamily: 'cairo',
                                                color: Colors.grey.shade700,
                                              ),
                                              MaterialButton(
                                                  onPressed: () {
                                                    cubitBasket.removeBasket(
                                                        products[index]
                                                            .basketId
                                                            .toString());
                                                    BlocProvider.of<
                                                                BasketCubit>(
                                                            context)
                                                        .getBasketView();
                                                  },
                                                  child: const Icon(
                                                      Icons.delete_forever)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                );
                              })),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              color: ColorApp.buttonCart,
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return BlocProvider(
                                    create: (context) => BasketCubit(),
                                    child: DeliverdScreen(),
                                  );
                                }));
                              },
                              child: const CustomTextsmallCase(
                                text: 'CONTENUE',
                                color: ColorApp.white,
                              ),
                            ),
                            Row(
                              children: [
                                const CustomTextsmall(
                                    text: 'Total:', fontSize: 18),
                                CustomTextsmall(
                                    text: cubitBasket.total.toString() + 'L.E',
                                    fontSize: 18),
                              ],
                            )
                          ],
                        )
                      ],
                    ));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Lottie.asset(AppImages.lottieEmpty,
                          fit: BoxFit.cover)),
                  const Center(
                      child: CustomTextsmall(text: 'Empty Cart', fontSize: 18)),
                ],
              );
            },
          );
  }
}
