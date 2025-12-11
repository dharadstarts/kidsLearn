import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Auth/ChristmasLaunchScreen.dart';
import 'package:kids_learn/screens/Auth/customLaunchScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _getLaunchScreen(),
    ),
  );
}

Widget _getLaunchScreen() {
  final DateTime now = DateTime.now();
  final DateTime expiryDate = DateTime(2026, 1, 1); // January 1, 2026

  // Show Christmas screen only if date is before Jan 1, 2026
  if (now.isBefore(expiryDate)) {
    return ChristmasLaunchScreen();
  } else {
    return customLaunchScreen();
  }
}

