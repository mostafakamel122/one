import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/theme_bloc_bloc.dart';
import '../../../res/constant/images.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        context.read<ThemeBlocBloc>().state == ThemeMode.dark
                            ? AppImages.whitelogo
                            : AppImages.blacklogo,
                        width: 75,
                        color: context.read<ThemeBlocBloc>().state ==
                                ThemeMode.dark
                            ? Colors.white
                            : null,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'One Style, ONE Community',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              MissionSection(),
              SizedBox(height: 20.0),
              CommunitySection(),
              SizedBox(height: 20.0),
              BenefitsSection(),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'Join us in celebrating \'One Style, One Community\' at ONE. Together, we redefine fashion, support emerging talent, and build a world where style knows no bounds.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'At ONE, we believe that fashion is more than just clothing; it\'s about creating a vibrant community that celebrates style, quality, and creativity.',
          ),
          SizedBox(height: 10.0),
          Text(
            'Our mission is simple yet powerful: to provide premium, high-quality clothing for both men and women while nurturing a sense of togetherness and empowerment.',
          ),
        ],
      ),
    );
  }
}

class CommunitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'One Style, ONE Community',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '"One Style, ONE Community" isn\'t just a slogan for us; it\'s our guiding principle. We\'re more than a fashion brand; we\'re a collective of individuals who share a passion for fashion.',
          ),
          SizedBox(height: 10.0),
          Text(
            'We actively encourage young and aspiring fashion designers to submit their unique creations to us.',
          ),
        ],
      ),
    );
  }
}

class BenefitsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join Our ONE Community',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'As you shop with us, you\'ll receive an exclusive code to share with your friends and family. When they use your unique code, they\'ll enjoy a fantastic discount, and you\'ll receive a cash-back reward on any product they purchase. It\'s our way of expressing gratitude for being a part of our ONE community.',
          ),
        ],
      ),
    );
  }
}
