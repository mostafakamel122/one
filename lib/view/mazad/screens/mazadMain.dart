import 'package:flutter/material.dart';
import 'package:one/res/components/customTextsmall.dart';

import '../widget/sliderMazad.dart';

class MazadMain extends StatefulWidget {
  const MazadMain({super.key});

  @override
  State<MazadMain> createState() => _MazadMainState();
}

class _MazadMainState extends State<MazadMain> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //  double width = MediaQuery.of(context).size.width;
    List categories = ["All", "men", "women", "Accsesories"];

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://wealthest22.com/automark/upload/productimg/Vector.png'))),
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: CustomTextsmall(
                            text: categories[index],
                            fontFamily: 'cairo',
                            fontWeight: index == 1 ? FontWeight.bold : null,
                            fontSize: 18,
                          )),
                    );
                  }),
            ),

            Container(
              height: height * 0.68,
              child: const SliderWidgetMazad(),
            ),
            const Spacer(),
            //  BottomMazad(height: height, width: width)
          ],
        ));
  }
}
