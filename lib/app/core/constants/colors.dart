import 'package:flutter/material.dart';

class AppColors {
  AppColors._privateConstructor();

  static final AppColors _instance = AppColors._privateConstructor();

  factory AppColors() {
    return _instance;
  }

  static const white = Colors.white;
  static const black = Colors.black; //Color(0xFF2B2B2B);
  static const newblack = Color(0xFF2B2B2B);
  static const subtitleColor = Color(0xFF393B3D);
  static const subtitleHeadersColor = Color(0xFFA9ABAE); //Color(0xFF393B3D);
  static const green = Color(0xFF49D95A);
  static const newGreen = Color(0xFF00C476);
  static const darkGreen = Color.fromARGB(255, 0, 111, 67);
  static const lightGreen = Color(0xFFD4F5D0);
  static const darkBlue = Color(0xFF515A5D);
  static const orange = Color(0xFFE4CF8C);
  static const lightOrange = Color(0xFFF9EEC4);
  static const yellow = Color(0xFFDDC36E);

  static const newGrey = Color(0xFFF6F6F6);
  static const borderGrey = Color(0xFFF1F1F2);
  static const grey = Color(0xFFA9ABAE);
  static const lightGrey = Color(0xFFF3F3F3);
  static const pink = Color(0xFFEDBBBE);
  static const lightPink = Color(0xFFFFE3E5);
  static const blue = Color(0xFFACBAD4);
  static const lightBlue = Color(0xFFCEDDF1);
  static const red = Color(0xFFA34D4D);
  static const buttonsColor = Color(0xFF44474A);
  static const purple = Color(0xFF615AF5);
  static const normalRed = Color(0xFFA34D4D);
}
