import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one/core/cache_helper.dart';
import 'package:one/res/components/customTextsmall.dart';
import 'package:one/res/constant/ColorApp.dart';
import 'package:one/view/Auth/screens/signin.dart';
import 'package:one/view/setting/screens/myWallet/mywallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/bloc/theme_bloc_bloc.dart';
import '../../core/jwt_token.dart';
import '../favorite/screen/favorite.dart';
import 'screens/TermsOfUsePage.dart';
import 'screens/aboutus.dart';
import 'screens/myProfile/view.dart';
import 'screens/privacyAndPolicy.dart';
import 'screens/settingView/view.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SharedPreferences prefs;

    final cubitJwt = BlocProvider.of<JwtTokenCubit>(context);
    String characterName = cubitJwt.name;
    characterName = characterName.trim();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: BlocBuilder<ThemeBlocBloc, ThemeMode>(
          builder: (context, state) {
            return ListView(
              children: [
                //upper
                InkWell(
                  onTap: () {
                    cubitJwt.id == 0
                        ? AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'warning',
                                desc: 'Please Sign in',
                                btnOkOnPress: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const SignIn();
                                  }));
                                },
                                btnOkColor: Colors.black)
                            .show()
                        : Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                            return MyProfile();
                          }));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(7),
                      width: width,
                      height: height * 0.11,
                      color:
                          context.read<ThemeBlocBloc>().state == ThemeMode.dark
                              ? Color(0xFF1C1B1F)
                              : ColorApp.settinggraylist,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: CustomTextsmall(
                              text: cubitJwt.id == 0
                                  ? 'O'
                                  : characterName[0].toUpperCase(),
                              fontSize: 20),
                        ),
                        title: CustomTextsmall(
                            text: cubitJwt.id == 0
                                ? 'userName'
                                : '${cubitJwt.name}',
                            fontWeight: FontWeight.bold,
                            color: ColorApp.black,
                            fontSize: 20),
                        subtitle: CustomTextsmall(
                          text: cubitJwt.id == 0
                              ? 'my code : ####'
                              : 'my code : ${cubitJwt.referralcode}',
                          fontSize: 14,
                          color: ColorApp.black,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )),
                ),

                //List Titels
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FavoriteScreen();
                    }));
                  },
                  child: Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(
                        Icons.favorite,
                      ),
                      title: CustomTextsmall(
                          text: 'Like'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(height: 2),

                // Container(
                //   color: ColorApp.settinggraylist,
                //   child: ListTile(
                //     leading: Icon(Icons.shopping_cart,
                //         color: ColorApp.black.withOpacity(0.7)),
                //     title: const CustomTextsmall(
                //         text: 'Cart', fontWeight: FontWeight.bold, fontSize: 14),
                //     trailing: Icon(Icons.arrow_forward_ios),
                //   ),
                // ),
                const SizedBox(height: 2),

                InkWell(
                  onTap: () {
                    cubitJwt.id == 0
                        ? AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'warning',
                                desc: 'Please Sign in',
                                btnOkOnPress: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const SignIn();
                                  }));
                                },
                                btnOkColor: Colors.black)
                            .show()
                        : Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                            return const MyWallet();
                          }));
                  },
                  child: Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(
                        Icons.balance,
                      ),
                      title: CustomTextsmall(
                          text: 'Wallet'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(height: 2),

                const SizedBox(height: 2),

                // Second List Titel

                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SettingOfSetting();
                    }));
                  },
                  child: Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: CustomTextsmall(
                          text: 'Setting'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return TermsOfUsePage();
                    }));
                  },
                  child: Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(Icons.list),
                      title: CustomTextsmall(
                          text: 'TermOfUse'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(height: 2),

                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PrivacyPolicyPage();
                    }));
                  },
                  child: Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: CustomTextsmall(
                          text: 'PrivcyAndPolicy'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(height: 2),

                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AboutUsPage();
                    }));
                  },
                  child: Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: CustomTextsmall(
                          text: 'Aboutus'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Container(
                //     color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                //         ? Color(0xFF1C1B1F)
                //         : ColorApp.settinggraylist,
                //     child: ListTile(
                //       leading: Icon(
                //         Icons.dark_mode,
                //       ),
                //       title: const CustomTextsmall(
                //           text: 'DarkMode',
                //           fontWeight: FontWeight.bold,
                //           fontSize: 14),
                //       trailing: Switch(
                //           value: context.read<ThemeBlocBloc>().state ==
                //               ThemeMode.dark,
                //           onChanged: (val) {
                //             val = !val;

                //             context
                //                 .read<ThemeBlocBloc>()
                //                 .add(ThemeChanged(val));
                //           }),
                //     )),

                const SizedBox(height: 20),

                cubitJwt.id == 0
                    ? InkWell(
                        onTap: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SignIn();
                          }));
                        },
                        child: Container(
                          color: context.read<ThemeBlocBloc>().state ==
                                  ThemeMode.dark
                              ? Color(0xFF1C1B1F)
                              : ColorApp.settinggraylist,
                          child: ListTile(
                            leading: Icon(Icons.logout),
                            title: CustomTextsmall(
                                text: 'LogIn'.tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          prefs = await SharedPreferences.getInstance();

                          await prefs.clear();
                          CacheHelper.getToken();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return SignIn();
                          }), (route) => false);
                        },
                        child: Container(
                          color: context.read<ThemeBlocBloc>().state ==
                                  ThemeMode.dark
                              ? Color(0xFF1C1B1F)
                              : ColorApp.settinggraylist,
                          child: ListTile(
                            leading: Icon(Icons.logout),
                            title: CustomTextsmall(
                                text: 'LogOut'.tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
