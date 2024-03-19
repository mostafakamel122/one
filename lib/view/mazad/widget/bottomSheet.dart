import 'package:flutter/material.dart';

import '../../../res/components/customTextsmall.dart';

class BottomMazad extends StatelessWidget {
  const BottomMazad({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.12,
      width: width,
      decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextsmall(text: 'highest bid', fontSize: 12),
              CustomTextsmall(text: '550 L.E', fontSize: 18),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextsmall(text: 'auction ends in', fontSize: 12),
              CustomTextsmall(text: '02 : 05 : 42', fontSize: 18),
            ],
          )
        ],
      ),
    );
  }
}
