import 'package:flutter/material.dart';

class AppTextStyles {
  // Font Families
  static const String poppins = 'Poppins';

  // Predefined styles with Poppins (your default)
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Poppins-Bold',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Colors.brown,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: Colors.brown,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.black,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: Colors.black87,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.black87,
  );

  // Method to get custom style
  static TextStyle custom({
    double fontSize = 16,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily = 'Poppins',
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }


}

extension TextStyleCopyWith on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withSize(double size) => copyWith(fontSize: size);

  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);
}