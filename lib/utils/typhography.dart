import 'package:flutter/material.dart';
import './colors.dart';

abstract class SUIT {
  static const Thin = FontWeight.w100;
  static const ExtraLight = FontWeight.w200;
  static const Light = FontWeight.w300;
  static const Regular = FontWeight.w400;
  static const Medium = FontWeight.w500;
  static const Semibold = FontWeight.w600;
  static const Bold = FontWeight.w700;
  static const ExtraBold = FontWeight.w800;
  static const Black = FontWeight.w900;
}

class Typography {
  TextStyle style(FontWeight weight, double size, double height) => TextStyle(
      fontFamily: 'SUIT',
      fontWeight: weight,
      fontSize: size,
      color: DPColors.Grayscale[700],
      height: height / size);

  static TextStyle Title = Typography.style(SUIT.Semibold, 28, 36);
}
