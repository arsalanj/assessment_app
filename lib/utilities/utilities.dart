import 'dart:ui';

import 'package:flutter/material.dart';

class Utilities {
  static final Utilities _instance = Utilities._internal();
  factory Utilities() => _instance;

  Utilities._internal();

  static bool isTablet(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double shortestSide = screenSize.shortestSide;

    // Adjust this threshold as needed based on your criteria
    return shortestSide >= 600; // Example threshold for tablet size
  }

  double adaptiveFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate font size based on screen width
    double baseFontSize = 1.0; // A base font size for reference
    double scaleFactor =
        screenWidth / 400.0; // Reference screen width for scaling

    // Calculate and return the adaptive font size
    return baseFontSize * scaleFactor;
  }
}
