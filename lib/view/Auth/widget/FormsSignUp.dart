// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/components/customTextformauth.dart';
import '../cubit/sign_up_cubit.dart';

class FormPersonalSignUp extends StatelessWidget {
  final SignUpCubit cubit;
  const FormPersonalSignUp({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String value = 'male';
    return Column(
      children: [
        Container(
          height: height * 0.1,
          child: CustomTextFormAuth(
            mycontroller: cubit.controllers.userNameController,
            hintText: '',
            labelText: 'first Name',
            icon: Icons.person,
            maxvalidator: 100,
            minvalidator: 2,
            msgvalidatormin: "لا يمكن ان يكون اقل من ",
            msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: height * 0.1,
          child: CustomTextFormAuth(
            mycontroller: cubit.controllers.secondUserNameController,
            hintText: '',
            labelText: 'second Name',
            icon: Icons.person,
            maxvalidator: 100,
            minvalidator: 2,
            msgvalidatormin: "لا يمكن ان يكون اقل من ",
            msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: height * 0.1,
          child: CustomTextFormAuth(
            keyboardType: TextInputType.number,
            mycontroller: cubit.controllers.phoneController,
            hintText: '+20111*******',
            labelText: 'phone',
            icon: Icons.phone,
            maxvalidator: 100,
            minvalidator: 7,
            msgvalidatormin: "لا يمكن ان يكون اقل من ",
            msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
            enabledBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: width,
          child: DropdownButton<String>(
            value: value,
            items: ['male', 'famale'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              print(val);
              val = value;
              cubit.controllers.genderController.text = value;
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: height * 0.1,
          child: CustomTextFormAuth(
            keyboardType: TextInputType.number,
            mycontroller: cubit.controllers.ageController,
            hintText: 'Age',
            labelText: 'Age',
            icon: Icons.calendar_month,
            maxvalidator: 3,
            minvalidator: 0,
            msgvalidatormin: "لا يمكن ان يكون اقل من ",
            msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
            enabledBorder: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class FormReqisterSignUp extends StatelessWidget {
  final SignUpCubit cubit;

  const FormReqisterSignUp({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: height * 0.1,
          child: CustomTextFormAuth(
            mycontroller: cubit.controllers.emailController,
            hintText: 'email@example',
            labelText: 'Email',
            icon: Icons.email,
            maxvalidator: 100,
            minvalidator: 7,
            msgvalidatormin: "لا يمكن ان يكون اقل من ",
            msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state is SignUpInitialSuccessShowPass) {
              return Container(
                height: height * 0.1,
                child: CustomTextFormAuth(
                  mycontroller: cubit.controllers.passwordController,
                  obscureText: state.isShow,
                  onPressedicon: () {
                    if (state.isShow) {
                      cubit.showPassword(false);
                      print(state.isShow);
                    } else {
                      cubit.showPassword(true);
                      print(state.isShow);
                    }
                  },
                  hintText: '***********',
                  labelText: 'password',
                  icon: Icons.remove_red_eye_outlined,
                  maxvalidator: 100,
                  minvalidator: 6,
                  msgvalidatormin: "لا يمكن ان يكون اقل من ",
                  msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                  enabledBorder: OutlineInputBorder(),
                ),
              );
            }
            return Container(
              height: height * 0.1,
              child: CustomTextFormAuth(
                mycontroller: cubit.controllers.passwordController,
                obscureText: cubit.isShowPass,
                onPressedicon: () {
                  cubit.showPassword(false);
                  print(cubit.isShowPass);
                },
                hintText: '***********',
                labelText: 'password',
                icon: Icons.remove_red_eye_outlined,
                maxvalidator: 100,
                minvalidator: 6,
                msgvalidatormin: "لا يمكن ان يكون اقل من ",
                msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                enabledBorder: OutlineInputBorder(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state is SignUpInitialSuccessShowConfirmPass) {
              return Container(
                height: height * 0.1,
                child: CustomTextFormAuth(
                  mycontroller: cubit.controllers.confirmpasswordController,
                  obscureText: state.isShow,
                  onPressedicon: () {
                    if (state.isShow) {
                      cubit.showConfirmPassword(false);
                      print(state.isShow);
                    } else {
                      cubit.showConfirmPassword(true);
                      print(state.isShow);
                    }
                  },
                  hintText: '***********',
                  labelText: ' confirm password',
                  icon: Icons.remove_red_eye_outlined,
                  maxvalidator: 100,
                  minvalidator: 6,
                  msgvalidatormin: "لا يمكن ان يكون اقل من ",
                  msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                  enabledBorder: OutlineInputBorder(),
                ),
              );
            }
            return Container(
              height: height * 0.1,
              child: CustomTextFormAuth(
                mycontroller: cubit.controllers.confirmpasswordController,
                obscureText: cubit.isShowPass,
                onPressedicon: () {
                  cubit.showConfirmPassword(false);
                  print(cubit.isShowPass);
                },
                hintText: '***********',
                labelText: 'confirm password',
                icon: Icons.remove_red_eye_outlined,
                maxvalidator: 100,
                minvalidator: 6,
                msgvalidatormin: "لا يمكن ان يكون اقل من ",
                msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
                enabledBorder: OutlineInputBorder(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Container(
          height: height * 0.1,
          child: CustomTextFormAuth(
            mycontroller: cubit.controllers.refCodeController,
            hintText: 'FV6GlZ0e',
            labelText: 'Referral code',
            icon: Icons.emoji_events,
            maxvalidator: 20,
            minvalidator: 0,
            msgvalidatormin: "لا يمكن ان يكون اقل من ",
            msgvalidatormax: ' لا يمكن ان يكون اكتبر من',
            enabledBorder: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
