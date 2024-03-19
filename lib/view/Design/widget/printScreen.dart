import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';

import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/images.dart';
import '../cubit/design_cubit.dart';

class PrintScreen extends StatelessWidget {
  const PrintScreen({
    super.key,
    required this.height,
    required this.cubitDesign,
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
          BlocBuilder<DesignCubit, DesignState>(
            builder: ((context, state) {
              if (state is DesignInitialLoaing) {
                return Center(child: Lottie.asset(AppImages.lottieLoading));
              }
              if (state is DesignInitialError) {
                return Text("problem in get data");
              }
              return Container(
                height: height * 0.31,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.3,
                      child: SvgPicture.network(
                        'https://morabrand.net/one/upload/SVGimage/${cubitDesign.resultimg[cubitDesign.selectedResult].toString()}', // Replace with the path to your SVG file
                        color:
                            cubitDesign.pickerColor, // Set the color you want
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.4,
                      child: cubitDesign.imageLoading
                          ? IconButton(
                              onPressed: () {
                                cubitDesign.onSelectImg();
                              },
                              icon: Icon(Icons.add, size: 50))
                          : null,
                    ),
                    cubitDesign.imageLoading
                        ? Container()
                        : Positioned(
                            left: cubitDesign.leftpos,
                            top: cubitDesign.toptpos,
                            child: GestureDetector(
                              onScaleUpdate: (ScaleUpdateDetails details) {
                                // Handle Scaling
                                double newWidth = cubitDesign.containerWidth *
                                    details.horizontalScale;
                                double newHeight = cubitDesign.containerHeight *
                                    details.verticalScale;

                                // Check that the new width and height are greater than a certain value
                                if (newWidth > 50 && newHeight > 50) {
                                  cubitDesign.onChangeHeightWidth(
                                      newHeight, newWidth);
                                }

                                // Handle Panning
                                double newLeft = max(
                                    0,
                                    cubitDesign.leftpos +
                                        details.focalPointDelta.dx);
                                double newTop = max(
                                    -90,
                                    cubitDesign.toptpos +
                                        details.focalPointDelta.dy);

                                cubitDesign.movephoto(newLeft, newTop);
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
                                  imageProvider: FileImage(cubitDesign.file),
                                  enableRotation: true,
                                  backgroundDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.covered * 2,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ...List.generate(
                      cubitDesign.colorslist.length,
                      (index) => InkWell(
                            onTap: () {
                              cubitDesign
                                  .changeColor(cubitDesign.colorslist[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: cubitDesign.colorslist[index]),
                            ),
                          )),
                ],
              ),
              BlocBuilder<DesignCubit, DesignState>(
                builder: (context, state) {
                  return !cubitDesign.imageLoading
                      ? InkWell(
                          onTap: () {
                            cubitDesign.onSelectImg();
                          },
                          child: const CustomTextsmall(
                            text: 'Selected Another',
                            color: Colors.grey,
                          ),
                        )
                      : Container();
                },
              )
            ],
          ),
          const SizedBox(height: 10),

          Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pick a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: cubitDesign.pickerColor,
                          onColorChanged: cubitDesign.changeColor,
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Choose color'),
            ),
          ),
          BlocBuilder<DesignCubit, DesignState>(
            builder: (context, state) {
              if (state is DesignInitialLoaing) {
                return Text("loading");
              }
              if (state is DesignInitialError) {
                return Text("problem in get data");
              }
              return Container(
                height: 125.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cubitDesign.resultimg.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        cubitDesign.onchangeSelectedSVG(index);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: SvgPicture.network(
                          // Assuming images are hosted online; replace with local asset or network image URL
                          'https://morabrand.net/one/upload/SVGimage/${cubitDesign.resultimg[index].toString()}',
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          SizedBox(height: 5),
          // BlocBuilder<DesignCubit, DesignState>(
          //   builder: (context, state) {
          //     return !cubitDesign.imageLoading
          //         ? InkWell(
          //             onTap: () {
          //               cubitDesign.removeFile();
          //             },
          //             child: const CustomTextsmall(
          //               text: 'Remove Selected',
          //               color: Colors.red,
          //             ),
          //           )
          //         : Container();
          //   },
          // ),
          const Spacer(),
          InkWell(
            onTap: () {
              cubitDesign.sendPrint(
                  cubitDesign.result[cubitDesign.selectedResult].toString());
            },
            child: Container(
              width: width,
              height: 40,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff262626)),
              child: CustomTextsmallCase(
                alignment: Alignment.center,
                fontSize: 18,
                text: 'SendPrint'.tr,
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
