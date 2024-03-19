import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one/res/components/customTextsmall.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final TextEditingController? mycontroller;
  final bool? obscureText;
  final int? maxline;
  final int minvalidator;
  final int maxvalidator;
  final String? msgvalidatormin;
  final String? msgvalidatormax;
  final double? width;
  final String? Function(String?)? validator;
  final void Function()? onPressedicon;
  final String? initialValue;
  final bool? enabled;
  final TextInputType? keyboardType;
  final double? borderRed;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final GetUtils? validWithgetx;
  final String? msgvaildgtx;
  final Widget? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  const CustomTextFormAuth({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    this.mycontroller,
    this.obscureText,
    this.maxline,
    this.validator,
    required this.maxvalidator,
    required this.minvalidator,
    this.msgvalidatormin,
    this.width,
    this.msgvalidatormax,
    this.onPressedicon,
    this.initialValue,
    this.enabled,
    this.keyboardType,
    this.borderRed,
    this.enabledBorder,
    this.focusedBorder,
    this.validWithgetx,
    this.msgvaildgtx,
    this.prefixIcon,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
          keyboardType: keyboardType,
          enabled: enabled,
          initialValue: initialValue,
          validator: (value) {
            if (value!.length < minvalidator) {
              return "$msgvalidatormin $minvalidator";
            }
            if (value.length > maxvalidator) {
              return "$msgvalidatormax $maxvalidator";
            }
            if (validWithgetx != null) {
              return '$msgvaildgtx';
            }
            return null;
          },
          maxLines: maxline == null ? 1 : maxline,
          obscureText:
              obscureText == null || obscureText == false ? false : true,
          controller: mycontroller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            focusColor: Colors.grey,
            hoverColor: Colors.grey,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: borderRed == null
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(30),
            ),
            enabled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(fontSize: 14),
            //    hintText: hintText,
            label: Container(
                child: CustomTextsmall(text: labelText, color: Colors.grey)),
            suffixIcon: InkWell(onTap: onPressedicon, child: Icon(icon)),
          ),
          onFieldSubmitted: onFieldSubmitted),
    );
  }
}

class CustomTextFormAuthWithBorder extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final TextEditingController? mycontroller;
  final bool? obscureText;
  final int? maxline;
  final int minvalidator;
  final int maxvalidator;
  final String? msgvalidatormin;
  final String? msgvalidatormax;
  final double? width;
  final String? Function(String?)? validator;
  final void Function()? onPressedicon;
  final String? initialValue;
  final bool? enabled;
  final TextInputType? keyboardType;
  final double? borderRed;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final GetUtils? validWithgetx;
  final String? msgvaildgtx;
  const CustomTextFormAuthWithBorder({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    this.mycontroller,
    this.obscureText,
    this.maxline,
    this.validator,
    required this.maxvalidator,
    required this.minvalidator,
    this.msgvalidatormin,
    this.width,
    this.msgvalidatormax,
    this.onPressedicon,
    this.initialValue,
    this.enabled,
    this.keyboardType,
    this.borderRed,
    this.enabledBorder,
    this.focusedBorder,
    this.validWithgetx,
    this.msgvaildgtx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: enabled,
        initialValue: initialValue,
        validator: (value) {
          if (value!.length < minvalidator) {
            return "$msgvalidatormin $minvalidator";
          }
          if (value.length > maxvalidator) {
            return "$msgvalidatormax $maxvalidator";
          }
          if (validWithgetx != null) {
            return '$msgvaildgtx';
          }
          return null;
        },
        maxLines: maxline == null ? 1 : maxline,
        obscureText: obscureText == null || obscureText == false ? false : true,
        controller: mycontroller,
        decoration: InputDecoration(
          enabled: true,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          border: OutlineInputBorder(
              borderRadius: borderRed == null
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(30)),
          hintStyle: const TextStyle(fontSize: 14),
          hintText: hintText,
          label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(labelText)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          suffixIcon: InkWell(onTap: onPressedicon, child: Icon(icon)),
        ),
      ),
    );
  }
}
