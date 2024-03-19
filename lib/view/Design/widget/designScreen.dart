import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:one/view/Design/cubit/design_cubit.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/bloc/theme_bloc_bloc.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/ColorApp.dart';
import 'widgetDesign.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({
    super.key,
    required this.cubitDesign,
    required this.height,
    required this.width,
  });

  final DesignCubit cubitDesign;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<DesignCubit, DesignState>(builder: (context, state) {
                return cubitDesign.selectedImgModel == ''
                    ? InkWell(
                        onTap: () {
                          cubitDesign.onOPen(0);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  content: SelectModelWidget(
                                      height: height,
                                      width: width,
                                      cubitDesign: cubitDesign),
                                );
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.5,
                          height: height * 0.4,
                          color: context.read<ThemeBlocBloc>().state ==
                                  ThemeMode.dark
                              ? Color(0xFF1C1B1F)
                              : ColorApp.settinggraylist,
                          child: const CustomTextsmall(text: 'Select Model'),
                        ),
                      )
                    : Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                width: width * 0.5,
                                height: height * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            cubitDesign.selectedImgModel))),
                              ),
                              cubitDesign.imageLoading
                                  ? Container()
                                  : Positioned(
                                      left: cubitDesign.leftposDes,
                                      top: cubitDesign.toptposDes,
                                      child: GestureDetector(
                                        onScaleUpdate:
                                            (ScaleUpdateDetails details) {
                                          // Handle Scaling
                                          double newWidth =
                                              cubitDesign.containerWidth *
                                                  details.horizontalScale;
                                          double newHeight =
                                              cubitDesign.containerHeight *
                                                  details.verticalScale;

                                          // Check that the new width and height are greater than a certain value
                                          if (newWidth > 50 && newHeight > 50) {
                                            cubitDesign.onChangeHeightWidth(
                                                newHeight, newWidth);
                                          }

                                          // Handle Panning
                                          double newLeft = max(
                                              0,
                                              cubitDesign.leftposDes +
                                                  details.focalPointDelta.dx);
                                          double newTop = max(
                                              -90,
                                              cubitDesign.toptposDes +
                                                  details.focalPointDelta.dy);

                                          cubitDesign.movephotoDes(
                                              newLeft, newTop);
                                        },
                                        // onPanUpdate: (details) {
                                        //   cubitDesign.movephoto(
                                        //     max(0,
                                        //         cubitDesign.leftpos + details.delta.dx),
                                        //     max(-90,
                                        //         cubitDesign.toptpos + details.delta.dy),
                                        //   );
                                        // },
                                        child: Container(
                                          height: cubitDesign.containerHeight,
                                          width: cubitDesign.containerWidth,
                                          child: PhotoView(
                                            imageProvider:
                                                FileImage(cubitDesign.file),
                                            enableRotation: true,
                                            backgroundDecoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            minScale: PhotoViewComputedScale
                                                .contained,
                                            maxScale:
                                                PhotoViewComputedScale.covered *
                                                    2,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                cubitDesign.onOPen(0);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        surfaceTintColor: context
                                                    .read<ThemeBlocBloc>()
                                                    .state ==
                                                ThemeMode.dark
                                            ? Color(0xFF1C1B1F)
                                            : ColorApp.settinggraylist,
                                        content: SelectModelWidget(
                                            height: height,
                                            width: width,
                                            cubitDesign: cubitDesign),
                                      );
                                    });
                              },
                              child: CustomTextsmall(text: 'Change Model')),
                          SizedBox(height: height * 0.02),
                          InkWell(
                            onTap: () {
                              cubitDesign.onSelectImg();
                            },
                            child: Container(
                              width: width * 0.42,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff262626)),
                              child: CustomTextsmallCase(
                                text: 'selectedImg'.tr,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                alignment: Alignment.center,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      );
              }),
              BlocBuilder<DesignCubit, DesignState>(builder: (context, state) {
                return Container(
                  width: width * 0.43,
                  height: height * 0.4,
                  margin: const EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextsmall(
                          text: 'DATA', fontWeight: FontWeight.w400),
                      const SizedBox(height: 5),
                      CustomTextsmall(text: 'Name: ${cubitDesign.name.text}'),
                      const SizedBox(height: 5),
                      CustomTextsmall(
                          text: 'Catgeory: ${cubitDesign.category.text}'),
                      const SizedBox(height: 5),
                      CustomTextsmall(
                          text: 'Material: ${cubitDesign.material.text}'),
                      const SizedBox(height: 5),
                      CustomTextsmall(text: 'Sizes: ${cubitDesign.sizes.text}'),
                      const SizedBox(height: 5),
                      CustomTextsmall(
                          text: 'Colors: ${cubitDesign.colors.text}'),
                      const SizedBox(height: 5),
                      CustomTextsmall(text: 'Age: ${cubitDesign.age.text}'),
                      const SizedBox(height: 5),
                      CustomTextsmall(
                          text: 'Discreption: ${cubitDesign.desc.text}'),
                      Center(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      surfaceTintColor: Colors.white,
                                      content: BottomSheetDesign(
                                          width: width, height: height));
                                });
                          },
                          child: Container(
                            width: width * 0.42,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff262626)),
                            child: CustomTextsmallCase(
                              text: 'Edit'.tr,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              alignment: Alignment.center,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              width: width,
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff262626)),
              child: CustomTextsmallCase(
                alignment: Alignment.center,
                fontSize: 18,
                text: 'SendDesign'.tr,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
