// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one/model/subCat.dart';
import 'package:one/res/constant/images.dart';

import '../../../core/bloc/theme_bloc_bloc.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/ColorApp.dart';
import '../Home/cubit/categories_cubit.dart';
import '../Home/cubit/home_products_cubit.dart';
import '../Home/screensHome/subcatView.dart';

class UpperWidgerHome extends StatelessWidget {
  const UpperWidgerHome({
    Key? key,
    required this.width,
    required this.height,
    required this.cat,
    required this.homeProductsCubit,
  }) : super(key: key);

  final double width;
  final double height;
  final List<String> cat;
  final HomeProductsCubit homeProductsCubit;

  @override
  Widget build(BuildContext context) {
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          decoration: BoxDecoration(
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: height * 0.3,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),

          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
    }

    final subCatCubit = BlocProvider.of<CategoriesCubit>(context)..getSubCat(1);

    return Row(
      children: [
        BlocBuilder<HomeProductsCubit, HomeProductsState>(
          builder: (context, state) {
            return CupertinoButton(
              onPressed: () {
                _showDialog(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,

                    useMagnifier: true,
                    itemExtent: 32,
                    // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: homeProductsCubit.valueCupertinoPicker,
                    ),
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      homeProductsCubit.changeSelectedval(selectedItem);
                      subCatCubit.getSubCat(selectedItem + 1);
                    },
                    children: List<Widget>.generate(cat.length, (int index) {
                      return Center(child: CustomTextsmall(text: cat[index]));
                    }),
                  ),
                );
              },
              child: BlocBuilder<ThemeBlocBloc, ThemeMode>(
                  builder: (context, state) {
                return Container(
                  color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                      ? Color(0xFF1C1B1F)
                      : ColorApp.settinggraylist,
                  width: width * 0.3,
                  height: height * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextsmall(
                        text: cat[homeProductsCubit.valueCupertinoPicker],
                        fontFamily: 'cairo',
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                );
              }),
            );
          },
        ),

// DropdownButtonHideUnderline(
//                 child: DropdownButton2<String>(
//                     isExpanded: true,
//                     value: homeProductsCubit.valueDropMuen,
//                     items: cat
//                         .map((String e) => DropdownMenuItem<String>(
//                             value: e, child: CustomTextsmall(text: e)))
//                         .toList(),
//                     onChanged: (String? val) {
//                       homeProductsCubit.changeSelectedval(val!);
//                       subCatCubit.getSubCat(cat.indexOf(val) + 1);
//                     }),
//               ),

        const SizedBox(width: 15),
        Image.asset(AppImages.line, height: height * 0.04),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesInitialLoading) {
              return const Text("Loding.....");
            }
            if (state is CategoriesInitialSuccess) {
              return Expanded(
                child: Container(
                  width: width * 0.75,
                  height: height * 0.04,
                  child: ListView.builder(
                      itemCount: state.listCat.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(5),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        List<SubCat> cat = state.listCat;
                        return InkWell(
                          onTap: () {
                            print(cat[index].subcategoriesId);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SubCatProducts(
                                subcat: cat[index].subcategoriesId!,
                                titelsubcat: cat[index].subcategoriesName!,
                              );
                            }));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: CustomTextsmall(
                                text: cat[index].subcategoriesName.toString(),
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      })),
                ),
              );
            }
            return const Text("Error");
          },
        )
      ],
    );
  }
}
