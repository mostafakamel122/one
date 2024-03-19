// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:one/res/components/customTextformauth.dart';

import '../../../res/components/customTextsmall.dart';
import '../cubit/basket_cubit.dart';

class FormAddress extends StatelessWidget {
  const FormAddress({
    Key? key,
    required this.width,
    required this.height,
    required this.cubitBasket,
  }) : super(key: key);

  final double width;
  final double height;
  final BasketCubit cubitBasket;

  @override
  Widget build(BuildContext context) {
    // final cubitBasket = BlocProvider.of<BasketCubit>(context);

    return SingleChildScrollView(
      child: Container(
          width: width * 0.9,
          height: height * 0.46,
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                width: width * 0.9,
                height: height * 0.35,
                child: ListView(children: [
                  const SizedBox(height: 25),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitBasket.basketControllers.address,
                          hintText: 'adddress',
                          labelText: 'address',
                          icon: Icons.home_filled,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitBasket.basketControllers.buildNum,
                          hintText: 'build number',
                          labelText: 'build number',
                          icon: Icons.location_city,
                          maxvalidator: 100,
                          minvalidator: 0)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitBasket.basketControllers.city,
                          hintText: 'city',
                          labelText: 'city',
                          icon: Icons.location_city_outlined,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                  Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: CustomTextFormAuth(
                          mycontroller: cubitBasket.basketControllers.notes,
                          hintText: 'notes',
                          labelText: 'notes',
                          icon: Icons.description,
                          maxvalidator: 100,
                          minvalidator: 5)),
                  SizedBox(height: 10),
                ]),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  cubitBasket.saveAddress(
                      cubitBasket.basketControllers.address.text,
                      cubitBasket.basketControllers.buildNum.text,
                      cubitBasket.basketControllers.city.text,
                      cubitBasket.basketControllers.notes.text);

                  print(cubitBasket.basketControllers.address);
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
