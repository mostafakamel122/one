import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one/res/components/customTextformauth.dart';

import '../../../res/constant/images.dart';
import '../../Home/HomeNav.dart';
import '../cubit/signin_cubit.dart';
import 'ForgetPassword.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/ColorApp.dart';
import 'signup.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: SignInBody(height: height, width: width),
    );
  }
}

class SignInBody extends StatelessWidget {
  const SignInBody({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SigninCubit>(context);

    return Scaffold(
      appBar: AppBar(
          title: Image.asset(AppImages.logoone, width: 50), centerTitle: true),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomTextsmall(
              alignment: Alignment.centerLeft,
              text: 'signIn'.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            const SizedBox(height: 10),
            Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Container(
                    height: height * 0.07,
                    child: CustomTextFormAuth(
                      mycontroller: cubit.controllers.emailController,
                      hintText: 'email@one.com',
                      labelText: 'Email',
                      icon: Icons.email,
                      maxvalidator: 100,
                      minvalidator: 7,
                      msgvalidatormin: "لا يمكن ان يكون اقل من ",
                      msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: height * 0.07,
                    child: CustomTextFormAuth(
                      mycontroller: cubit.controllers.passwordController,
                      obscureText: true,
                      hintText: '**************',
                      labelText: 'password',
                      icon: Icons.remove_red_eye_outlined,
                      maxvalidator: 100,
                      minvalidator: 7,
                      msgvalidatormin: "لا يمكن ان يكون اقل من ",
                      msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ForgetPassword();
                }));
              },
              child: CustomTextsmall(
                text: 'ForegetPassword'.tr,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                alignment: Alignment.bottomRight,
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<SigninCubit, SigninState>(
              listener: (context, state) {
                if (state is SigninInitialLoading) {
                  const Center(child: CircularProgressIndicator());
                } else if (state is SigninInitialSuccess) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HomeMainNav();
                  }));
                } else if (state is SigninInitialError) {
                  Get.snackbar('Error', state.msg!);
                }
              },
              builder: (context, state) {
                if (state is SigninInitialLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minWidth: width,
                  height: height * 0.06,
                  color: ColorApp.black,
                  onPressed: () {
                    cubit.signInUsers();
                  },
                  child: CustomTextsmallCase(
                    text: "signInButoon".tr,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
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
            const SizedBox(height: 35),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(3),
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorApp.black, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          AppImages.googelLogo,
                          height: 35,
                          width: 35,
                        ),
                        CustomTextsmall(
                            text: 'GoogelButton'.tr,
                            fontWeight: FontWeight.bold)
                      ],
                    )),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(3),
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorApp.black, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.facebook, size: 35, color: Colors.blue),
                        CustomTextsmall(
                            text: 'FaceBookButton'.tr,
                            fontWeight: FontWeight.bold)
                      ],
                    )),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextsmall(
                    text: "donthaveaccount".tr, color: Colors.black),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    },
                    child:
                        CustomTextsmall(text: "signUp".tr, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
