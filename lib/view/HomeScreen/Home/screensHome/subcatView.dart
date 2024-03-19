// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:one/res/components/customTextsmall.dart';

import '../../../../core/globalcubits.dart';
import '../../../../core/jwt_token.dart';
import '../../../../model/HomeProducts.dart';
import '../../../../res/constant/AppLinks.dart';
import '../../../../res/constant/images.dart';
import '../../../Auth/screens/signin.dart';
import '../../../ProductView/productView.dart';
import 'cubit/sub_cat_view_cubit.dart';
import 'upperWidget.dart';

class SubCatProducts extends StatelessWidget {
  final int subcat;
  final String titelsubcat;

  const SubCatProducts({
    Key? key,
    required this.subcat,
    required this.titelsubcat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubCatViewCubit(),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: CustomTextsmall(
                text: titelsubcat, fontWeight: FontWeight.bold)),
        body: ProductSubCatView(subcat: subcat, titelsubcat: titelsubcat),
      ),
    );
  }
}

class ProductSubCatView extends StatelessWidget {
  final int subcat;
  final String titelsubcat;

  const ProductSubCatView({
    super.key,
    required this.subcat,
    required this.titelsubcat,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SubCatViewCubit>(context)..getdata(subcat);

    return ViewSubCatMain(
        cubit: cubit, subcat: subcat, titelsubcat: titelsubcat);
  }
}

class ViewSubCatMain extends StatelessWidget {
  final int subcat;
  final String titelsubcat;

  final SubCatViewCubit cubit;
  const ViewSubCatMain(
      {super.key,
      required this.titelsubcat,
      required this.cubit,
      required this.subcat});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final cubitfav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);
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
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.extentAfter == 0) {
              // تحقق مما إذا كان المستخدم قد وصل إلى نهاية القائمة
              print(1);
              cubit.looadmoreData(subcat);
            }
            return true;
          },
          child: ListView(
            children: [
              UpperWidget(
                cubit: cubit,
                subcat: subcat,
              ),
              BlocBuilder<SubCatViewCubit, SubCatViewState>(
                builder: (context, state) {
                  if (state is SubCatViewInitialLoading) {
                    return Center(child: Lottie.asset(AppImages.lottieLoading));
                  }
                  if (state is SubCatViewInitialError) {
                    Center(child: Lottie.asset(AppImages.lottieErrorNetwork));
                  }
                  bool isloadmore = state is SubCatViewInitialLoadMore;
                  if (state is SubCatViewInitialnoMoreData) {
                    isloadmore = false;
                  }
                  return cubit.products.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Lottie.network(AppImages.lottieEmpty)),
                            CustomTextsmall(text: "Empty".tr)
                          ],
                        )
                      : Container(
                          margin: const EdgeInsets.all(5),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.65),
                              itemCount:
                                  cubit.products.length + (isloadmore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index >= cubit.products.length) {
                                  // If it's the last item, show a loading indicator
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                List<HomeProducts> products = cubit.products
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  cubitJwt.id == 0
                                                      ? AwesomeDialog(
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .warning,
                                                              animType: AnimType
                                                                  .rightSlide,
                                                              title: 'warning',
                                                              desc:
                                                                  'Please Sign in',
                                                              btnOkOnPress: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return const SignIn();
                                                                }));
                                                              },
                                                              btnOkColor:
                                                                  Colors.black)
                                                          .show()
                                                      : cubitfav.addFav(
                                                          products[index]
                                                              .itemId
                                                              .toString(),
                                                          cubitJwt.id
                                                              .toString());
                                                },
                                                icon: const Icon(
                                                  Icons.favorite_border,
                                                  size: 18,
                                                ))
                                          ],
                                        ),
                                        CustomTextsmall(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          text: products[index]
                                              .itemName
                                              .toString(),
                                          fontFamily: 'cairo',
                                          color: Color(0xFF434343),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
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
        );
      },
    );
  }
}
