import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/theme_bloc_bloc.dart';

class CustomTextsmall extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final AlignmentGeometry? alignment;
  final String? fontFamily;
  final double? margin;
  final FontWeight? fontWeight;
  final int? maxLine;
  const CustomTextsmall(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.alignment,
      this.margin,
      this.fontWeight,
      this.maxLine,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      alignment: alignment,
      //  margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        maxLines: maxLine,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                ? Colors.white
                : Color(0xFF1C1B1F),
            fontSize: fontSize == null ? 15 : fontSize,
            fontFamily: fontFamily,
            fontWeight: fontWeight),
      ),
    );
  }
}

class CustomTextsmallCase extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final AlignmentGeometry? alignment;
  final String? fontFamily;
  final double? margin;
  final FontWeight? fontWeight;
  final int? maxLine;
  const CustomTextsmallCase(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.alignment,
      this.margin,
      this.fontWeight,
      this.maxLine,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      alignment: alignment,
      //  margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        maxLines: maxLine,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: context.read<ThemeBlocBloc>().state == ThemeMode.dark
                ? Colors.white
                : color,
            fontSize: fontSize == null ? 15 : fontSize,
            fontFamily: 'cairo',
            fontWeight: fontWeight),
      ),
    );
  }
}
