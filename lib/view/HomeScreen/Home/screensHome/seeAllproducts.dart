// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:one/res/components/customTextsmall.dart';

import '../../../../core/bloc/theme_bloc_bloc.dart';
import '../../../../core/globalcubits.dart';
import '../../../../core/jwt_token.dart';
import '../../../../model/HomeProducts.dart';
import '../../../../res/constant/AppLinks.dart';
import '../../../../res/constant/images.dart';
import '../../../Auth/screens/signin.dart';
import '../../../ProductView/productView.dart';
import '../cubit/home_products_cubit.dart';

class SeeAllProducts extends StatelessWidget {
  final List<HomeProducts> products;
  final HomeProductsCubit cubit;

  const SeeAllProducts({
    Key? key,
    required this.products,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final cubitfav = BlocProvider.of<AddFavTokenCubit>(context);
    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const CustomTextsmall(
              text: 'products', fontWeight: FontWeight.bold)),
      body: BlocConsumer<AddFavTokenCubit, AddFav>(
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
              }
              return true;
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.65),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductView(homeProducts: products[index]);
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
                                        products[index].itemImg!)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      DialogType.warning,
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
                                        color: context
                                                    .read<ThemeBlocBloc>()
                                                    .state ==
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
                  }),
            ),
          );
        },
      ),
    );
  }
}
