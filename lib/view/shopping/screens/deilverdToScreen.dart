import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../model/BasketModel.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/ColorApp.dart';
import '../../../res/constant/images.dart';
import '../../Home/HomeNav.dart';
import '../cubit/basket_cubit.dart';
import '../widget/FormAddress.dart';

class DeliverdScreen extends StatelessWidget {
  const DeliverdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: DeliverdScreenView(height: height, width: width),
    );
  }
}

class DeliverdScreenView extends StatelessWidget {
  const DeliverdScreenView({
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
    //final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);
    return BlocConsumer<BasketCubit, BasketState>(
      listener: ((context, state) {
        if (state is BasketiLoadingState) {
          Center(child: Lottie.asset(AppImages.lottieLoading));
        }
        if (state is BasketiDonetate) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return HomeMainNav();
          }), (route) => false);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    surfaceTintColor: Colors.white,
                    content: Container(
                        width: width * 0.3,
                        height: width * 0.4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(AppImages.lottiesuccess,
                                  height: width * 0.3, width: width * 0.3),
                              CustomTextsmall(text: 'تمت الطلب بنجاح')
                            ])));
              });
        }
      }),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextsmall(text: 'Deliver To', fontSize: 18),
                Divider(thickness: 2, color: Colors.grey.shade400, height: 5),
                ListTile(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              surfaceTintColor: Colors.white,
                              content: FormAddress(
                                width: width,
                                height: height,
                                cubitBasket: cubitBasket,
                              ));
                        });
                  },
                  title: CustomTextsmall(
                      text: cubitBasket.address == ''
                          ? "Enter Your Address"
                          : cubitBasket.address,
                      fontSize: 16),
                  trailing: IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
                ),
                Divider(thickness: 2, color: Colors.grey.shade400, height: 5),
                const CustomTextsmall(text: 'Products', fontSize: 18),

                //item
                Container(
                  height: height * 0.56,
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
                                    image: NetworkImage(AppLinks.imgProducts +
                                        products[index].itemImg!)),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextsmall(
                                    text: products[index].itemName!,
                                    fontFamily: 'cairo',
                                  ),
                                  CustomTextsmall(
                                    text: '${products[index].itemPrice!}',
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
                                            BlocProvider.of<BasketCubit>(
                                                    context)
                                                .getBasketView();
                                          },
                                          child:
                                              const Icon(Icons.delete_forever)),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        );
                      })),
                ),
                //item

                const Spacer(),
                Column(
                  children: [
                    const Divider(
                        thickness: 2, color: ColorApp.black, height: 5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextsmall(text: 'SHIPPING', fontSize: 18),
                        CustomTextsmall(text: '30 L.E', fontSize: 16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<BasketCubit, BasketState>(
                        builder: ((context, state) {
                      return MaterialButton(
                        minWidth: width * 0.85,
                        color: ColorApp.buttonCart,
                        onPressed: () {
                          cubitBasket.orderBasket();
                        },
                        child: const CustomTextsmallCase(
                            text: 'CONTENUE',
                            color: ColorApp.white,
                            fontSize: 18),
                      );
                    })),
                  ],
                )
              ],
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextsmall(text: 'Deliver To', fontSize: 18),
              Divider(thickness: 2, color: Colors.grey.shade400, height: 5),
              ListTile(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            surfaceTintColor: Colors.white,
                            content: FormAddress(
                              width: width,
                              height: height,
                              cubitBasket: cubitBasket,
                            ));
                      });
                },
                title: CustomTextsmall(
                    text: cubitBasket.address == ''
                        ? "Enter Your Address"
                        : cubitBasket.address,
                    fontSize: 16),
                trailing: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
              ),
              Divider(thickness: 2, color: Colors.grey.shade400, height: 5),
              const CustomTextsmall(text: 'Products', fontSize: 18),

              //item
              Container(
                height: height * 0.56,
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
                                  image: NetworkImage(AppLinks.imgProducts +
                                      products[index].itemImg!)),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextsmall(
                                  text: products[index].itemName!,
                                  fontFamily: 'cairo',
                                ),
                                CustomTextsmall(
                                  text: '${products[index].itemPrice!}',
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
                                          BlocProvider.of<BasketCubit>(context)
                                              .getBasketView();
                                        },
                                        child:
                                            const Icon(Icons.delete_forever)),
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      );
                    })),
              ),
              //item

              const Spacer(),
              Column(
                children: [
                  const Divider(thickness: 2, color: ColorApp.black, height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextsmall(text: 'SHIPPING', fontSize: 18),
                      CustomTextsmall(text: '30 L.E', fontSize: 16),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: width * 0.85,
                    color: ColorApp.buttonCart,
                    onPressed: () {
                      cubitBasket.orderBasket();
                    },
                    child: const CustomTextsmallCase(
                        text: 'CONTENUE', color: ColorApp.white, fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
