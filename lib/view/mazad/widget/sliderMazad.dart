import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../core/bloc/theme_bloc_bloc.dart';
import '../../../core/cache_helper.dart';
import '../../../res/components/customTextsmall.dart';
import '../../../res/constant/AppLinks.dart';
import '../../../res/constant/images.dart';
import '../MazadInfo/screen/mazadindo.dart';

class SliderWidgetMazad extends StatefulWidget {
  const SliderWidgetMazad({
    super.key,
  });

  @override
  State<SliderWidgetMazad> createState() => _SliderWidgetMazadState();
}

class _SliderWidgetMazadState extends State<SliderWidgetMazad>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double _currentPageValue = 0;
  int currentPage = 0;

  late AnimationController controller; //<-- Create a controller

  @override
  void initState() {
    getMazadView();
    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
    controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    super.initState();
  }

  void toggel() {
    final bool isOPen = controller.status == AnimationStatus.completed;
    controller.fling(velocity: isOPen ? -2 : 2);
  }

  double? lerp(double min, double max) =>
      lerpDouble(min, max, controller.value);
  double? get opacity => lerp(0.2, 1);
  double? get heightt => lerp(220, 420);

// get Data
  int selectedCard = 0;
  Duration durationDifference = Duration();

  final String _userUrl = AppLinks.auctions;
  var headers = {'Authorization': CacheHelper.getToken()};
  List list = [];
  List<DateTime> times = [];
  oncangeSelectedCard(int val) {
    selectedCard = val;
  }

  getMazadView() async {
    http.Response response =
        await http.get(Uri.parse(_userUrl), headers: headers);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      list.addAll(responseBody['data']);
      times = list.map((jsonData) {
        return DateTime(
          int.parse(jsonData['TimeEnd']['Year']),
          int.parse(jsonData['TimeEnd']['Month']),
          int.parse(jsonData['TimeEnd']['Day']),
          int.parse(jsonData['TimeEnd']['Hour']),
          int.parse(jsonData['TimeEnd']['Minute']),
          int.parse(jsonData['TimeEnd']['Second']),
        );
      }).toList();
      // حساب الفرق بين الوقت الحالي والوقت الثابت
      durationDifference = DateTime.now().difference(times[selectedCard]);
    } else {}
  }

  final Stream<DateTime> timeStream = Stream.periodic(
    Duration(seconds: 1),
    (count) => DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<DateTime>(
        stream: timeStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && list.isNotEmpty) {
            DateTime currentTime = snapshot.data!;
            DateTime targetTime = times[currentPage];

            // حساب الفرق بين الأوقات
            Duration difference = targetTime.difference(currentTime);

            int days = difference.inDays;
            int hours = difference.inHours % 24;
            int minutes = difference.inMinutes % 60;
            int seconds = difference.inSeconds % 60;
            return AnimatedBuilder(
              animation: controller,
              builder: (context, widget) {
                return GestureDetector(
                  onTap: toggel,
                  child: PageView.builder(
                      onPageChanged: (val) {
                        setState(() {
                          currentPage = val;
                        });
                      },
                      controller: _pageController,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final double opacity =
                            (1 - ((_currentPageValue - index).abs() * 0.5))
                                .clamp(0.0, 1.0);
                        final double scale = 0.8 -
                            ((_currentPageValue - index).abs() * 0.5)
                                .clamp(0.0, 0.5);
                        bool isActive = currentPage == index;
                        return Container(
                            height: heightt,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MazadInfo(
                                      id: list[index]['id'].toString());
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.all(isActive ? 5 : 30),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          context.read<ThemeBlocBloc>().state ==
                                                  ThemeMode.dark
                                              ? Colors.transparent
                                              : Color(0xffF5F5F5)
                                                  .withOpacity(opacity),
                                          Color(0xffEEE7CD).withOpacity(opacity)
                                        ]),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Hero(
                                            tag: list[index]['img'],
                                            child: Opacity(
                                              opacity: opacity,
                                              child: Image.network(
                                                list[index]['img'],
                                                fit: BoxFit.cover,
                                                width: width * 0.5,
                                                height: height * 0.3,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: height * 0.12,
                                            width: width,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(60),
                                                    topRight:
                                                        Radius.circular(60))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomTextsmall(
                                                        text: 'Startbid'.tr,
                                                        fontSize: 16),
                                                    CustomTextsmall(
                                                        text: list[index][
                                                                    'startPrice']
                                                                .toString() +
                                                            "L.E",
                                                        fontSize: 20),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomTextsmall(
                                                        text:
                                                            'auctionendsin'.tr,
                                                        fontSize: 16),
                                                    CustomTextsmall(
                                                        text:
                                                            '$days:$hours:$minutes:$seconds',
                                                        fontSize: 20),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ));
                      }),
                );
              },
            );
          }
          return Center(child: Lottie.asset(AppImages.lottieLoading));
        });
  }
}
