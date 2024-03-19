// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:one/res/components/customTextsmall.dart';

import '../cubit/search_cubit.dart';
import 'pagefilterGo.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SearchCubit cubit;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    cubit..onopenfilter();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const CustomTextsmall(
                    text: 'Filter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo'),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _showDialog(
                      context,
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,

                        useMagnifier: true,
                        itemExtent: 32,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: cubit.selectedCat!,
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          cubit.onCangeCat(selectedItem);
                          print(cubit.selectedCat);
                        },

                        children: List<Widget>.generate(cubit.cat.length,
                            (int index) {
                          return Center(
                              child: CustomTextsmall(text: cubit.cat[index]));
                        }),
                      ),
                      height);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CustomTextsmall(
                          text: 'Category', color: Colors.grey.shade800),
                      CustomTextsmall(
                        text: cubit.cat[cubit.selectedCat!],
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
              // price
              const Divider(thickness: 2, height: 10, color: Colors.black12),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CustomTextsmall(
                          alignment: Alignment.centerLeft,
                          text: 'Price',
                          color: Colors.grey.shade800),
                      RangeSlider(
                        values: cubit.currentRangeValues,
                        max: 7200,
                        divisions: 72,
                        labels: RangeLabels(
                          cubit.currentRangeValues.start.toString(),
                          cubit.currentRangeValues.end.toString(),
                        ),
                        onChanged: (RangeValues values) {
                          cubit.onCangePrice(values);
                          print(cubit.currentRangeValues.end);
                        },
                      )
                    ],
                  )),
              const Divider(thickness: 2, height: 10, color: Colors.black12),
              InkWell(
                onTap: () {
                  _showDialogColor(
                      context,
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,

                        useMagnifier: true,
                        itemExtent: 32,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: cubit.selectedColors!,
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          cubit.onCangeColor(selectedItem);
                        },

                        children: List<Widget>.generate(cubit.colors.length,
                            (int index) {
                          return Center(
                              child:
                                  CustomTextsmall(text: cubit.colors[index]));
                        }),
                      ),
                      height);
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomTextsmall(
                            text: 'Color', color: Colors.grey.shade800),
                        CustomTextsmall(
                          text: cubit.colors[cubit.selectedColors!],
                          color: Colors.grey.shade300,
                          fontSize: 14,
                        ),
                      ],
                    )),
              ),
              const Divider(thickness: 2, height: 10, color: Colors.black12),
              InkWell(
                onTap: () {
                  _showDialogMaterial(
                      context,
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,

                        useMagnifier: true,
                        itemExtent: 32,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: cubit.selectedmaterial!,
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          cubit.onCangeMaterial(selectedItem);
                        },

                        children: List<Widget>.generate(cubit.material.length,
                            (int index) {
                          return Center(
                              child:
                                  CustomTextsmall(text: cubit.material[index]));
                        }),
                      ),
                      height);
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomTextsmall(
                            text: 'Material', color: Colors.grey.shade800),
                        CustomTextsmall(
                          text: cubit.material[cubit.selectedmaterial!],
                          color: Colors.grey.shade300,
                          fontSize: 14,
                        ),
                      ],
                    )),
              ),
              const Divider(thickness: 2, height: 10, color: Colors.black12),
              InkWell(
                onTap: () {
                  _showDialogMaterial(
                      context,
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,

                        useMagnifier: true,
                        itemExtent: 32,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: cubit.selectedSize!,
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          cubit.onCangeSizes(selectedItem);
                        },

                        children: List<Widget>.generate(cubit.size.length,
                            (int index) {
                          return Center(
                              child: CustomTextsmall(text: cubit.size[index]));
                        }),
                      ),
                      height);
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomTextsmall(
                            text: 'Size', color: Colors.grey.shade800),
                        CustomTextsmall(
                          text: cubit.size[cubit.selectedSize!],
                          color: Colors.grey.shade300,
                          fontSize: 14,
                        ),
                      ],
                    )),
              ),
              const Divider(thickness: 2, height: 10, color: Colors.black12),
              const Spacer(flex: 1),
              InkWell(
                onTap: () {
                  // cubit.sreachProducts(cubit.searchval);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPageFilter(
                      cubit: cubit,
                    );
                  }));
                  print(cubit.material[cubit.selectedmaterial!].toString());
                  // cubit.sreachProducts(cubit.searchval);
                },
                child: Container(
                  width: width,
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff262626)),
                  child: const CustomTextsmallCase(
                    alignment: Alignment.center,
                    fontSize: 18,
                    text: 'APPLY',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

void _showDialog(BuildContext context, Widget child, double height) {
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

void _showDialogColor(BuildContext context, Widget child, double height) {
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

void _showDialogMaterial(BuildContext context, Widget child, double height) {
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

void _showDialogSizes(BuildContext context, Widget child, double height) {
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
