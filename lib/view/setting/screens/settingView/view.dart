import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one/res/components/customTextsmall.dart';

import '../../../../core/bloc/theme_bloc_bloc.dart';
import '../../../../core/cache_helper.dart';
import '../../../../localizatoin/changelocal.dart';
import '../../../../res/constant/ColorApp.dart';

class SettingOfSetting extends StatelessWidget {
  const SettingOfSetting({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());

    return Scaffold(
      appBar: AppBar(
        title: CustomTextsmall(text: '"Setting'),
        centerTitle: true,
      ),
      body: BlocBuilder<ThemeBlocBloc, ThemeMode>(builder: (context, state) {
        return Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                    color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                        ? Color(0xFF1C1B1F)
                        : ColorApp.settinggraylist,
                    child: ListTile(
                      leading: Icon(
                        Icons.dark_mode,
                      ),
                      title: CustomTextsmall(
                          text: 'darkMode'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      trailing: Switch(
                          value: context.read<ThemeBlocBloc>().state ==
                              ThemeMode.dark,
                          onChanged: (val) {
                            val = !val;
                            CacheHelper.saveMode(!val ? "dark" : "ligh");
                            print(CacheHelper.getMode());
                            context
                                .read<ThemeBlocBloc>()
                                .add(ThemeChanged(val));
                          }),
                    )),
                SizedBox(height: 10),
                Container(
                  color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                      ? Color(0xFF1C1B1F)
                      : ColorApp.settinggraylist,
                  child: ListTile(
                    leading: Icon(
                      Icons.language,
                    ),
                    title: CustomTextsmall(
                        text: 'language'.tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    onTap: () => _showLanguagePicker(context, controller),
                  ),
                ),
              ],
            ));
      }),
    );
  }
}

void _showLanguagePicker(BuildContext context, LocalController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                controller.changeLang('ar');
                Navigator.pop(context);
              },
              child: const Text('العربية'),
            ),
            SimpleDialogOption(
              onPressed: () {
                controller.changeLang('en');
                Navigator.pop(context);
              },
              child: const Text('English'),
            ),
          ],
        ),
      );
    },
  );
}
