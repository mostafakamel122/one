// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:one/res/components/customTextsmall.dart';

import '../../../../core/bloc/theme_bloc_bloc.dart';
import '../../../../core/jwt_token.dart';
import '../../../../res/constant/ColorApp.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => JwtTokenCubit(),
      child: MyProfileView(height: height, width: width),
    );
  }
}

class MyProfileView extends StatelessWidget {
  const MyProfileView({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<JwtTokenCubit>(context)
      ..fetchTokenAndDecode();

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<JwtTokenCubit, JwtTokenStates>(
        builder: (context, state) {
          if (state is JwtTokenLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is JwtTokenSuccessState) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UpperSetting(
                    height: height,
                    width: width,
                    cubit: cubit,
                  ),
                  const SizedBox(height: 20),
                  CustomTextsmall(text: 'Name'),
                  Container(
                    height: height * 0.05,
                    width: width,
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: CustomTextsmall(
                      text: cubit.name,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(height: 7),
                  CustomTextsmall(text: 'phone', color: Colors.grey.shade400),
                  Container(
                    height: height * 0.05,
                    width: width,
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: CustomTextsmall(
                      text: cubit.phone,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(height: 7),
                  CustomTextsmall(text: 'Gender', color: Colors.grey.shade400),
                  Container(
                    height: height * 0.05,
                    width: width,
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: const CustomTextsmall(
                      text: 'Engineer that const Even Now',
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(height: 7),
                  CustomTextsmall(text: 'age', color: Colors.grey.shade400),
                  Container(
                    height: height * 0.05,
                    width: width,
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: const CustomTextsmall(
                      text: '25',
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(height: 7),
                  CustomTextsmall(text: 'Email', color: Colors.grey.shade400),
                  Container(
                    height: height * 0.05,
                    width: width,
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: CustomTextsmall(
                      text: cubit.email,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Spacer(),
                  // MaterialButton(
                  //   minWidth: width,
                  //   color: ColorApp.buttonCart,
                  //   onPressed: () {},
                  //   child: const CustomTextsmall(
                  //     text: 'Save',
                  //     color: ColorApp.white,
                  //   ),
                  // ),
                ],
              ),
            );
          }
          return Text('Error');
        },
      ),
    );
  }
}

class UpperSetting extends StatelessWidget {
  final JwtTokenCubit cubit;
  const UpperSetting({
    Key? key,
    required this.cubit,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJIwASCJpICHRbFDOQXQ2S-pmikc8vs6K2GA&usqp=CAU'),
            radius: 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextsmall(
                  text: 'referral code', fontWeight: FontWeight.bold),
              Container(
                  width: width * 0.55,
                  color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                      ? Color(0xFF1C1B1F)
                      : ColorApp.settinggraylist,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextsmall(text: cubit.referralcode),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: cubit.referralcode));
                          Get.snackbar('تم النسخ بنجاح', "");
                        },
                        child: Icon(Icons.copy),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
