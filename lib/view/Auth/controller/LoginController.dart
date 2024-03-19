import 'package:flutter/material.dart';

class LoginControllers {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

class SignUpControllers {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final secondUserNameController = TextEditingController();
  final phoneController = TextEditingController();
  final refCodeController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    secondUserNameController.dispose();
    phoneController.dispose();
    refCodeController.dispose();
    ageController.dispose();
    genderController.dispose();
    confirmpasswordController.dispose();
  }
}
