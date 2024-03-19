import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one/view/Design/cubit/design_cubit.dart';
import '../widget/designScreen.dart';
import '../widget/printScreen.dart';

class DesignMAinPage extends StatelessWidget {
  const DesignMAinPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    final DesignCubit cubitDesign = BlocProvider.of<DesignCubit>(context)
      ..getSVGView();

    return DefaultTabController(
      length: 1,
      child: Container(
        child: Column(
          children: [
            TabBar(
                onTap: (val) {
                  cubitDesign.onChangePage(val);
                },
                tabs: [
                  Tab(text: 'PRINT'.tr)
                  // , Tab(text: 'DESIGN'.tr)
                ]),
            // Container(
            //     height: height * 0.74,
            //     child: TabBarView(children: [
            //       PrintScreen(
            //           cubitDesign: cubitDesign,
            //           height: height,
            //           colors: colors,
            //           width: width),
            //       DesignScreen(
            //           cubitDesign: cubitDesign, height: height, width: width)
            //     ]))
            BlocBuilder<DesignCubit, DesignState>(builder: (context, state) {
              return cubitDesign.pageSelceted == 0
                  ? Container(
                      height: height * 0.74,
                      child: PrintScreen(
                          cubitDesign: cubitDesign,
                          height: height,
                          width: width),
                    )
                  : Container(
                      height: height * 0.74,
                      child: DesignScreen(
                          cubitDesign: cubitDesign,
                          height: height,
                          width: width),
                    );
            })
          ],
        ),
      ),
    );
  }
}
