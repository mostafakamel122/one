import 'package:flutter/material.dart';

import '../../../../res/components/customTextsmall.dart';
import 'cubit/sub_cat_view_cubit.dart';

class UpperWidget extends StatelessWidget {
  final SubCatViewCubit cubit;
  final int subcat;

  const UpperWidget({super.key, required this.cubit, required this.subcat});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.sort,
                    size: 35,
                  )),
              const CustomTextsmall(
                text: 'Filter',
                color: Color(0xFF434343),
                fontSize: 17,
                fontFamily: 'cairo',
                fontWeight: FontWeight.w400,
              )
            ],
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            surfaceTintColor: Colors.white,
                            content: Container(
                              height: height * 0.16,
                              padding: const EdgeInsets.all(7),
                              child: Column(
                                children: [
                                  const CustomTextsmall(
                                    text: 'SORT BY',
                                    fontFamily: 'cairo',
                                    fontWeight: FontWeight.bold,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                      height: 5),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      cubit.OrderBy = "item_price";

                                      cubit.getdata(subcat);
                                    },
                                    child: const CustomTextsmall(
                                      text: 'Price',
                                      color: Color(0xFF434343),
                                      alignment: Alignment.centerLeft,
                                      fontSize: 17,
                                      fontFamily: 'cairo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      cubit.OrderBy = "item_time";

                                      cubit.getdata(subcat);
                                    },
                                    child: const CustomTextsmall(
                                      text: 'NEW',
                                      color: Color(0xFF434343),
                                      alignment: Alignment.centerLeft,
                                      fontSize: 17,
                                      fontFamily: 'cairo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const CustomTextsmall(
                                      text: 'Most popular',
                                      color: Color(0xFF434343),
                                      alignment: Alignment.centerLeft,
                                      fontSize: 17,
                                      fontFamily: 'cairo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Icon(Icons.compare_arrows, size: 35)),
              const CustomTextsmall(
                text: 'Sort By',
                color: Color(0xFF434343),
                fontSize: 17,
                fontFamily: 'cairo',
                fontWeight: FontWeight.w400,
              )
            ],
          )
        ],
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     InkWell(
      //       onTap: () {
      //         cubit.getdata(subcat, "item_price", "DESC");
      //       },
      //       child: const CustomTextsmall(
      //         text: 'Sort By Price',
      //         color: Color(0xFF434343),
      //         fontSize: 17,
      //         fontFamily: 'cairo',
      //         fontWeight: FontWeight.w400,
      //       ),
      //     ),
      //     InkWell(
      //       onTap: () {},
      //       child: const CustomTextsmall(
      //         text: 'Most popular',
      //         color: Color(0xFF434343),
      //         fontSize: 17,
      //         fontFamily: 'cairo',
      //         fontWeight: FontWeight.w400,
      //       ),
      //     ),
      //     InkWell(
      //       onTap: () {
      //         cubit.getdata(subcat, "item_time", "DESC");
      //       },
      //       child: const CustomTextsmall(
      //         text: 'NEW',
      //         color: Color(0xFF434343),
      //         fontSize: 17,
      //         fontFamily: 'cairo',
      //         fontWeight: FontWeight.w400,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
