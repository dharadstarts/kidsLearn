import 'package:flutter/material.dart';

class ColorHelper {
  static Color fromHex(String hexString) {
    hexString = hexString.replaceFirst('#', '');

    if (hexString.length == 6) {
      hexString = 'FF$hexString'; // Add full opacity
    } else if (hexString.length == 8) {
      // Already has alpha
    } else {
      throw FormatException('Invalid hex color format: $hexString');
    }

    return Color(int.parse(hexString, radix: 16));
  }
}