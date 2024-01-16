// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

class _Primary {
  final Brand = const Color(0xFF2EA4AB);
  final Negative = const Color(0xFFD76263);
}

abstract class DPColors extends _Primary {
  static const Grayscale = {
    100: Color(0xFFFDFEFE),
    200: Color(0xFFF4F5F5),
    300: Color(0xFFEAEBEB),
    400: Color(0xFFDADDDD),
    500: Color(0xFFB4B9B9),
    600: Color(0xFF808989),
    700: Color(0xFF626A6B),
    800: Color(0xFF4B5152),
    900: Color(0xFF333738),
    1000: Color(0xFF1C1F1F),
  };

  static final Primary = _Primary();
}
