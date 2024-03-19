import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one/view/Auth/cubit/forget_password_cubit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../res/components/customTextformauth.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/ColorApp.dart';
import '../../../res/constant/images.dart';
import '../../Home/HomeNav.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
            title: Image.asset(AppImages.logoone, width: 50),
            centerTitle: true),
        body: ForgetPasswordView(height: height, width: width),
      ),
    );
  }
}

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgetPasswordCubit>(context);
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordInitialError) {
          final snackbar = SnackBar(
            content: Text(state.msg),
            duration: Duration(
                seconds: 3), // Duration for which the Snackbar is visible
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
        if (state is ForgetPasswordInitialErrorCode) {
          final snackbar = SnackBar(
            content: Text(state.msg),
            duration: Duration(
                seconds: 3), // Duration for which the Snackbar is visible
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
        if (state is ForgetPasswordInitialSuccessAndGoHome) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return HomeMainNav();
          }));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const CustomTextsmall(
              text: 'Forget Password',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              alignment: Alignment.centerLeft,
            ),
            const CustomTextsmall(
              text: 'Please enter Email address associated with your account.',
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 10),
            Container(
              height: height * 0.07,
              child: CustomTextFormAuth(
                mycontroller: cubit.email,
                hintText: 'email@one.com',
                labelText: 'Email',
                icon: Icons.email,
                maxvalidator: 100,
                minvalidator: 7,
                msgvalidatormin: "لا يمكن ان يكون اقل من ",
                msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                if (state is ForgetPasswordInitial) {
                  return MaterialButton(
                    minWidth: width,
                    height: height * 0.06,
                    color: ColorApp.black,
                    onPressed: () {
                      context.read<ForgetPasswordCubit>().sendEmail();
                    },
                    child: const CustomTextsmallCase(
                      text: "Send Mail",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  );
                }
                if (state is ForgetPasswordInitialLoading) {
                  return Center(child: const CircularProgressIndicator());
                }
                if (state is ForgetPasswordInitialSuccess ||
                    state is ForgetPasswordInitialErrorCode) {
                  return Column(
                    children: [
                      OTPTextField(
                        length: 5,
                        width: MediaQuery.of(context).size.width,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        onCompleted: (pin) {
                          cubit.verifycode(pin);
                        },
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        minWidth: width,
                        height: height * 0.06,
                        color: ColorApp.black,
                        onPressed: () {},
                        child: const CustomTextsmallCase(
                          text: "Confirm",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                }
                if (state is ForgetPasswordInitialSuccessAndGoChangePass) {
                  return Column(
                    children: [
                      Container(
                        height: height * 0.07,
                        child: CustomTextFormAuth(
                          mycontroller: cubit.passowrd,
                          hintText: '**********',
                          labelText: 'password',
                          icon: Icons.password,
                          maxvalidator: 100,
                          minvalidator: 7,
                          msgvalidatormin: "لا يمكن ان يكون اقل من ",
                          msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        minWidth: width,
                        height: height * 0.06,
                        color: ColorApp.black,
                        onPressed: () {
                          cubit.cangedpassword();
                        },
                        child: const CustomTextsmallCase(
                          text: "change",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                }
                if (state is ForgetPasswordInitialError) {
                  return MaterialButton(
                    minWidth: width,
                    height: height * 0.06,
                    color: ColorApp.black,
                    onPressed: () {
                      context.read<ForgetPasswordCubit>().returninit();
                    },
                    child: const CustomTextsmallCase(
                      text: "back send mail",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  );
                }
                return MaterialButton(
                  minWidth: width,
                  height: height * 0.06,
                  color: ColorApp.black,
                  onPressed: () {},
                  child: const CustomTextsmallCase(
                    text: "Send Mail",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
