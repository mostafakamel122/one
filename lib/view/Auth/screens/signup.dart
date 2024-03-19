import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/ColorApp.dart';
import '../../../res/constant/images.dart';

import '../../Home/HomeNav.dart';
import '../cubit/sign_up_cubit.dart';
import '../widget/FormsSignUp.dart';
import 'signin.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final cubit = BlocProvider.of<SignUpCubit>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Image.asset(AppImages.logoone, width: 50), centerTitle: true),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: ListView(
          children: [
            /// Personal Information
            Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextsmall(
                    text: 'personalInfo'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 10),
                  FormPersonalSignUp(cubit: cubit),

                  /// Register Information
                  CustomTextsmall(
                    text: 'registerInfo'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 10),
                  FormReqisterSignUp(cubit: cubit),
                ],
              ),
            ),

            ///footer
            const SizedBox(height: 20),
            BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpInitialLoadingpasswordNotRight) {
                  Get.snackbar("password", "confirm password not same");
                }
                if (state is SignUpInitialLoading) {
                  const Center(child: CircularProgressIndicator());
                } else if (state is SignUpInitialSuccess) {
                  Get.snackbar('', "تم انشاء الحساب");

                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return HomeMainNav();
                  }));
                } else if (state is SignUpInitialError) {
                  Get.snackbar('Error', state.msg);
                }
              },
              builder: (context, state) {
                if (state is SignUpInitialLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: height * 0.06,
                  color: Colors.black,
                  onPressed: () {
                    cubit.signUpUsers();
                  },
                  child: CustomTextsmallCase(
                    text: "signUp".tr,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width * 0.35,
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                const CustomTextsmall(text: "OR", color: Colors.grey),
                Container(
                  width: width * 0.35,
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SignUpSocail(width: width, height: height),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextsmall(text: "haveaccount".tr, color: Colors.black),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignIn();
                      }));
                    },
                    child: CustomTextsmall(
                        text: "signInButoon".tr, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpSocail extends StatelessWidget {
  const SignUpSocail({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: ColorApp.white,
                content: Container(
                  width: width * 0.9,
                  height: height * 0.3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      CustomTextsmall(
                          text: 'signupAnotherWay'.tr,
                          fontWeight: FontWeight.bold),
                      const Divider(thickness: 3, height: 5),
                      const SizedBox(height: 50),
                      Container(
                          padding: const EdgeInsets.all(3),
                          width: width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: ColorApp.black, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                AppImages.googelLogo,
                                height: 35,
                                width: 35,
                              ),
                              const CustomTextsmall(
                                  text: 'Log In With Googel',
                                  fontWeight: FontWeight.bold)
                            ],
                          )),
                      const SizedBox(height: 10),
                      Container(
                          padding: const EdgeInsets.all(3),
                          width: width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: ColorApp.black, width: 2)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook,
                                  size: 35, color: Colors.blue),
                              CustomTextsmall(
                                  text: 'Log In With Facebook',
                                  fontWeight: FontWeight.bold)
                            ],
                          )),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
          padding: const EdgeInsets.all(7),
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorApp.black, width: 2)),
          child: const CustomTextsmall(
              alignment: Alignment.center,
              text: 'SIGN UP in Another Way',
              fontWeight: FontWeight.bold)),
    );
  }
}
