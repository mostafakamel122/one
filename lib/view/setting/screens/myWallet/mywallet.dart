import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:one/res/components/customTextsmall.dart';
import 'package:one/view/setting/cubit/setting_cubit.dart';
import 'package:intl/intl.dart';

import '../../../../core/bloc/theme_bloc_bloc.dart';
import '../../../../res/constant/ColorApp.dart';
import '../../../../res/constant/images.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final cubitSetting = BlocProvider.of<SettingCubit>(context)
      ..getWalletData();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          if (state is SettingInitialLoading) {
            return Center(child: Lottie.asset(AppImages.lottieLoading));
          }
          if (state is SettingInitialError) {
            Center(child: Lottie.network(AppImages.lottieErrorNetwork));
          }
          return Container(
            margin: const EdgeInsets.all(10),
            child: ListView(
              children: [
                const CustomTextsmall(text: 'WALLET'),
                const SizedBox(height: 5),
                CustomTextsmall(
                    text: 'My Balance',
                    fontSize: 13,
                    color: Colors.grey.shade600),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextsmall(
                        text: cubitSetting.wallet.toString() + "ج.م",
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                        fontSize: 20),
                    InkWell(
                      onTap: () {
                        cubitSetting.getWalletData();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: width * 0.3,
                          height: height * 0.04,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: const CustomTextsmallCase(
                            text: 'Transfer',
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomTextsmall(
                        text: 'My Earn',
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                        fontSize: 18),
                    // Container(
                    //     child: const CustomTextsmall(
                    //   text: 'My Earn',
                    // )),
                  ],
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubitSetting.listTransaction.length,
                      itemBuilder: ((context, index) {
                        // تحويل النص إلى تاريخ
                        DateTime dateTime = DateTime.parse(cubitSetting
                            .listTransaction[index]['time']
                            .toString());

                        // تنسيق التاريخ للحصول على السنة، الشهر، اليوم
                        String formattedDate =
                            DateFormat("yyyy-MM-dd").format(dateTime);
                        return Container(
                          margin: const EdgeInsets.only(top: 7),
                          color: context.read<ThemeBlocBloc>().state ==
                                  ThemeMode.dark
                              ? Color(0xFF1C1B1F)
                              : ColorApp.settinggraylist,
                          child: ListTile(
                            leading: cubitSetting.listTransaction[index]
                                            ['percent']
                                        .toString() ==
                                    "5"
                                ? CustomTextsmall(text: "S")
                                : CustomTextsmall(text: "F"),
                            title: CustomTextsmall(
                                text: cubitSetting.listTransaction[index]
                                    ['user_name'],
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            trailing: Container(
                              width: width * 0.43,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextsmall(
                                        text: "Date: " + formattedDate,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    CustomTextsmall(
                                        text: cubitSetting
                                                .listTransaction[index]['value']
                                                .toString() +
                                            "EGP",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ]),
                            ),
                          ),
                        );
                      })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomTextsmall(
                        text: 'My Team',
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                        fontSize: 18),
                    Container(
                        child: const CustomTextsmall(
                      text: '',
                    )),
                  ],
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubitSetting.list.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 7),
                          color: context.read<ThemeBlocBloc>().state ==
                                  ThemeMode.dark
                              ? Color(0xFF1C1B1F)
                              : ColorApp.settinggraylist,
                          child: ListTile(
                            leading: Icon(Icons.person,
                                color: ColorApp.black.withOpacity(0.7)),
                            title: CustomTextsmall(
                                text: cubitSetting.list[index]['user_name'],
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        );
                      })),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
