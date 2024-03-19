// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../../core/bloc/theme_bloc_bloc.dart';
import '../../../../core/cache_helper.dart';
import '../../../../res/components/customTextsmall.dart';
import '../../../../res/constant/AppLinks.dart';
import '../../../../res/constant/images.dart';

class MazadInfo extends StatefulWidget {
  final String id;
  const MazadInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<MazadInfo> createState() => _MazadInfoState();
}

class _MazadInfoState extends State<MazadInfo> {
  TextEditingController price = TextEditingController();
  Duration durationDifference = Duration();

  final String _userUrl = AppLinks.auctionsId;
  final String _userUrlBid = AppLinks.bidAucations;

  var headers = {'Authorization': CacheHelper.getToken()};
  List list = [];
  List<DateTime> times = [];
  bidAuction() async {
    http.Response response = await http.post(Uri.parse(_userUrlBid),
        body: {'id': widget.id, "price": price.text}, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        list[0]['endPrice'] = price.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الاضافة بنجاح'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('حدث خطا ما '),
        ),
      );
    }
  }

  getMazadView() async {
    http.Response response = await http.post(Uri.parse(_userUrl),
        body: {'id': widget.id}, headers: headers);
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
      durationDifference = DateTime.now().difference(times[0]);
    } else {}
  }

  final Stream<DateTime> timeStream = Stream.periodic(
    Duration(seconds: 1),
    (count) => DateTime.now(),
  );
  @override
  void initState() {
    getMazadView();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            //  title: CustomTextsmall(text: 'ZRNKSH'),
            ),
        body: StreamBuilder<DateTime>(
            stream: timeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && list.isNotEmpty) {
                DateTime currentTime = snapshot.data!;
                DateTime targetTime = times[0];

                // حساب الفرق بين الأوقات
                Duration difference = targetTime.difference(currentTime);

                int days = difference.inDays;
                int hours = difference.inHours % 24;
                int minutes = difference.inMinutes % 60;
                int seconds = difference.inSeconds % 60;
                return Column(
                  children: [
                    Hero(
                      tag: list[0]['img'],
                      child: Container(
                        height: height * 0.439,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(list[0]['img']))),
                      ),
                    ),
                    Card(
                      surfaceTintColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: height * 0.4196,
                        width: width,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://wealthest22.com/automark/upload/productimg/Vector.png')),
                            color: context.read<ThemeBlocBloc>().state ==
                                    ThemeMode.dark
                                ? null
                                : Colors.grey.shade200.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(50))),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextsmall(
                                        text: 'highest bid', fontSize: 12),
                                    CustomTextsmall(
                                        text: list[0]['endPrice'].toString() +
                                            " L.E",
                                        fontSize: 18),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextsmall(
                                        text: 'auction ends in', fontSize: 12),
                                    CustomTextsmall(
                                        text: '$days:$hours:$minutes:$seconds',
                                        fontSize: 20),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      child: Wrap(
                                        children: <Widget>[
                                          CustomTextsmall(
                                            text: 'EnterYourBid'.tr,
                                            fontFamily: 'cairo',
                                            fontSize: 17,
                                            alignment: Alignment.center,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            controller: price,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: 'Bid Amount',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: ElevatedButton(
                                              child: CustomTextsmall(
                                                text: 'bidNow'.tr,
                                                fontFamily: 'cairo',
                                                fontSize: 17,
                                                alignment: Alignment.center,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              onPressed: () async {
                                                // Handle the bid logic

                                                bidAuction();
                                                Navigator.pop(
                                                    context); // Dismiss the bottom sheet
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                height: height * 0.05,
                                width: width * 0.9,
                                child: CustomTextsmallCase(
                                    alignment: Alignment.center,
                                    text: 'bidNow'.tr,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: height * 0.04),
                            const CustomTextsmall(
                              text: 'Details',
                              fontSize: 17,
                              alignment: Alignment.topLeft,
                              fontWeight: FontWeight.bold,
                            ),
                            Row(
                              children: [
                                CustomTextsmall(
                                    text: 'owned :',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                CustomTextsmall(
                                    text: list[0]['owned'], fontSize: 12),
                              ],
                            ),
                            Row(
                              children: [
                                CustomTextsmall(
                                    text: 'brand :',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                CustomTextsmall(
                                    text: list[0]['Barnd'], fontSize: 12),
                              ],
                            ),
                            Row(
                              children: [
                                CustomTextsmall(
                                    text: 'sience :',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                CustomTextsmall(
                                    text: list[0]['sience'].toString(),
                                    fontSize: 12),
                              ],
                            ),
                            const Row(
                              children: [
                                CustomTextsmall(
                                    text: 'country :',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                CustomTextsmall(text: 'maraqu', fontSize: 12),
                              ],
                            ),
                            Row(
                              children: [
                                CustomTextsmall(
                                    text: 'country :',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                CustomTextsmall(
                                    text: list[0]['country'], fontSize: 12),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return Center(child: Lottie.asset(AppImages.lottieLoading));
            }));
  }
}
