import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/components/customTextsmall.dart';
import '../cubit/search_cubit.dart';
import '../screens/filterScreen.dart';

class UpperWidget extends StatelessWidget {
  const UpperWidget({
    super.key,
    required this.height,
    required this.searchval,
  });

  final double height;
  final String searchval;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final cubit = BlocProvider.of<SearchCubit>(context);

    return Container(
      height: height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                          create: (_) => cubit,
                          child: FilterItem(
                            cubit: cubit,
                          ));
                    }));
                  },
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
                                      cubit.sreachProducts(searchval);
                                    },
                                    child: const CustomTextsmall(
                                      text: 'Price',
                                      fontFamily: 'cairo',
                                      color: Color(0xFF262626),
                                      alignment: Alignment.centerLeft,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      cubit.OrderBy = "item_time";
                                      cubit.sreachProducts(searchval);
                                    },
                                    child: const CustomTextsmall(
                                      text: 'New',
                                      fontFamily: 'cairo',
                                      color: Color(0xFF262626),
                                      alignment: Alignment.centerLeft,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  // const CustomTextsmall(
                                  //   text: 'Most popular',
                                  //   fontFamily: 'cairo',
                                  //   color: Color(0xFF262626),
                                  //   alignment: Alignment.centerLeft,
                                  //   fontSize: 16,
                                  //   fontWeight: FontWeight.w300,
                                  // ),
                                  const Spacer(),
                                  MaterialButton(
                                    minWidth: width * 0.8,
                                    color: Colors.black,
                                    onPressed: () {},
                                    child: const CustomTextsmallCase(
                                        fontWeight: FontWeight.bold,
                                        text: 'APPLY',
                                        fontFamily: 'cairo',
                                        color: Colors.white),
                                  )
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
          ),
          // const CustomTextsmall(
          //   text: 'Sort By Price',
          //   color: Color(0xFF434343),
          //   fontSize: 17,
          //   fontFamily: 'cairo',
          //   fontWeight: FontWeight.w400,
          // ),
          // const CustomTextsmall(
          //   text: 'NEW',
          //   color: Color(0xFF434343),
          //   fontSize: 17,
          //   fontFamily: 'cairo',
          //   fontWeight: FontWeight.w400,
          // ),
        ],
      ),
    );
  }
}
  // Row(
          //   children: [
          //     InkWell(
          //         onTap: () {
          //           showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return AlertDialog(
          //                   surfaceTintColor: Colors.white,
          //                   content: Container(
          //                     height: height * 0.2,
          //                     child: Column(
          //                       children: [
          //                         const CustomTextsmall(
          //                           text: 'SORT BY',
          //                           fontFamily: 'cairo',
          //                           fontWeight: FontWeight.bold,
          //                           alignment: Alignment.centerLeft,
          //                         ),
          //                         const Divider(
          //                             thickness: 1,
          //                             color: Colors.grey,
          //                             height: 5),
          //                         const CustomTextsmall(
          //                           text: 'Price',
          //                           fontFamily: 'cairo',
          //                           color: Color(0xFF262626),
          //                           alignment: Alignment.centerLeft,
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.w300,
          //                         ),
          //                         const CustomTextsmall(
          //                           text: 'best seller',
          //                           fontFamily: 'cairo',
          //                           color: Color(0xFF262626),
          //                           alignment: Alignment.centerLeft,
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.w300,
          //                         ),
          //                         const CustomTextsmall(
          //                           text: 'sale',
          //                           fontFamily: 'cairo',
          //                           color: Color(0xFF262626),
          //                           alignment: Alignment.centerLeft,
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.w300,
          //                         ),
          //                         const Spacer(),
          //                         MaterialButton(
          //                           minWidth: width * 0.8,
          //                           color: Colors.black,
          //                           onPressed: () {},
          //                           child: const CustomTextsmallCase(
          //                               fontWeight: FontWeight.bold,
          //                               text: 'APPLY',
          //                               fontFamily: 'cairo',
          //                               color: Colors.white),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 );
          //               });
          //         },
          //         child: const Icon(Icons.compare_arrows, size: 35)),
          //     const CustomTextsmall(
          //       text: 'Sort By',
          //       color: Color(0xFF434343),
          //       fontSize: 17,
          //       fontFamily: 'cairo',
          //       fontWeight: FontWeight.w400,
          //     )
          //   ],
          // ),