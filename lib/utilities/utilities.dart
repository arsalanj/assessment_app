import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

/// A utility class containing various helper functions.
class Utilities {
  static final Utilities _instance = Utilities._internal();

  /// Creates an instance of the [Utilities] class.
  factory Utilities() => _instance;

  Utilities._internal();

  /// Determines whether the device screen size corresponds to a tablet.
  ///
  /// Returns `true` if the shortest side of the device screen is greater
  /// than or equal to the specified [tabletThreshold], indicating that the
  /// device is considered a tablet.
  static bool isTablet(BuildContext context, {double tabletThreshold = 600.0}) {
    final Size screenSize = MediaQuery.of(context).size;
    final double shortestSide = screenSize.shortestSide;

    return shortestSide >= tabletThreshold;
  }

  /// Calculates an adaptive font size based on the screen width.
  ///
  /// The [context] parameter is used to obtain the device's screen width,
  /// which is then used to calculate the adaptive font size. The [baseFontSize]
  /// parameter represents a base font size for reference. The font size is scaled
  /// using the [scaleFactor] calculated from the reference [screenWidth].
  double adaptiveFontSize(BuildContext context, {double baseFontSize = 1.0}) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double referenceScreenWidth = 400.0;

    // Calculate font size based on screen width
    double scaleFactor = screenWidth / referenceScreenWidth;

    // Calculate and return the adaptive font size
    return baseFontSize * scaleFactor;
  }
}
