import 'package:flutter/material.dart';

class BasketControllers {
  final notes = TextEditingController();
  final buildNum = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();

  void dispose() {
    notes.dispose();
    buildNum.dispose();
    address.dispose();
    city.dispose();
  }
}
