import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255, // Opacity (0-255)
    random.nextInt(55) + 150, // Red (0-255)
    random.nextInt(56) + 120, // Green (0-255)
    random.nextInt(56) + 140, // Blue (0-255)
  );
}
