import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one/res/components/customTextformauth.dart';
import 'package:one/view/Design/cubit/design_cubit.dart';

import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/images.dart';

class BottomSheetDesign extends StatelessWidget {
  const BottomSheetDesign({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final DesignCubit cubitDesign = BlocProvider.of<DesignCubit>(context);

    return SingleChildScrollView(
      child: Container(
          width: width * 0.9,
          height: height,
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                width: width * 0.9,
                height: height * 0.7,
                child: ListView(children: [
                  const SizedBox(height: 25),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.name,
                          hintText: 'name',
                          labelText: 'name',
                          icon: Icons.emoji_emotions,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.category,
                          hintText: 'category',
                          labelText: 'category',
                          icon: Icons.category,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.material,
                          hintText: 'material',
                          labelText: 'material',
                          icon: Icons.manage_accounts_rounded,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.sizes,
                          hintText: 'sizes',
                          labelText: 'sizes',
                          icon: Icons.numbers,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.colors,
                          hintText: 'colors',
                          labelText: 'colors',
                          icon: Icons.color_lens,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.age,
                          hintText: 'age',
                          labelText: 'age',
                          icon: Icons.numbers,
                          keyboardType: TextInputType.number,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitDesign.desc,
                          hintText: 'description',
                          labelText: 'description',
                          icon: Icons.description,
                          maxline: 2,
                          maxvalidator: 100,
                          minvalidator: 5)),
                ]),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  cubitDesign.onOPen(cubitDesign.slectedModel);
                  Navigator.pop(context);
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
                    text: 'Save',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class SelectModelWidget extends StatelessWidget {
  const SelectModelWidget({
    super.key,
    required this.height,
    required this.width,
    required this.cubitDesign,
  });

  final double height;
  final double width;
  final DesignCubit cubitDesign;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DesignCubit, DesignState>(
      builder: (context, state) {
        if (state is DesignModelSelected) {
          return Container(
            height: height * 0.4,
            width: width,
            child: Column(
              children: [
                const CustomTextsmall(
                    text: 'MODEL TYPE', fontWeight: FontWeight.w500),
                const Divider(height: 10, thickness: 1),
                Container(
                  height: height * 0.26,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppImages.models.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            cubitDesign.onSelected(
                                index, AppImages.models[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                height: height * 0.2,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: cubitDesign.slectedModel == index
                                        ? Colors.blue.shade100.withOpacity(0.4)
                                        : null,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            AppImages.models[index]))),
                              ),
                              CustomTextsmall(text: 'name model')
                            ],
                          ),
                        );
                      })),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff262626)),
                    child: const CustomTextsmallCase(
                      alignment: Alignment.center,
                      fontSize: 18,
                      text: 'Apply',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: CustomTextsmall(text: 'Has Erro'),
        );
      },
    );
  }
}
