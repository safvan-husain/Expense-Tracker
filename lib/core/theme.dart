import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData light = ThemeData(
    applyElevationOverlayColor: true,
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primarySwatch: const MaterialColor(
      0xFFE0E0E0,
      <int, Color>{
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEAEAEA),
        300: Color(0xFFE0E0E0),
        400: Color(0xFFD6D6D6),
        500: Color(0xFFCCCCCC),
        600: Color(0xFFC2C2C2),
        700: Color(0xFFB8B8B8),
        800: Color(0xFFADADAD),
        900: Color(0xFFA3A3A3),
      },
    ),
    primaryColorLight: const Color.fromARGB(241, 1, 163, 33),
    primaryColorDark: const Color.fromARGB(255, 131, 130, 128),
    canvasColor: const Color.fromARGB(255, 243, 240, 236),
    scaffoldBackgroundColor: const Color.fromARGB(255, 21, 22, 21),
    dividerColor: const Color.fromARGB(255, 68, 70, 68),
    focusColor: Colors.deepOrange,
    splashColor: const Color.fromARGB(182, 251, 215, 56).withOpacity(0.3),
    cardColor: const Color(0xFFFFF8E7),
    highlightColor: const Color.fromARGB(255, 108, 145, 194),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      titleMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      titleLarge: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 25,
        ),
      ),
      headlineLarge: GoogleFonts.russoOne(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 25,
          // color: Colors.black,
        ),
      ),
      headlineSmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
          // color: Color.fromARGB(255, 37, 38, 39),
        ),
      ),
      headlineMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
          // color: Color.fromARGB(255, 37, 38, 39),
        ),
      ),
      displayLarge: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
      displayMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
      displaySmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
      bodyMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
        ),
      ),
      bodySmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 10,
        ),
      ),
      bodyLarge: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 249, 249, 250),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 145, 151, 174),
    ),
  );

  static ThemeData dark = ThemeData(
    applyElevationOverlayColor: true,
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primarySwatch: const MaterialColor(
      0xFFE0E0E0, // Set the primary color to white
      <int, Color>{
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEAEAEA),
        300: Color(0xFFE0E0E0),
        400: Color(0xFFD6D6D6),
        500: Color(0xFFCCCCCC),
        600: Color(0xFFC2C2C2),
        700: Color(0xFFB8B8B8),
        800: Color(0xFFADADAD),
        900: Color(0xFFA3A3A3),
      },
    ),
    primaryColorLight: const Color.fromARGB(255, 25, 196, 42),
    // primaryColorLight: const Color.fromARGB(255, 239, 184, 17),
    primaryColorDark: const Color.fromARGB(255, 82, 82, 81),
    canvasColor: const Color.fromARGB(255, 31, 31, 31),
    scaffoldBackgroundColor: const Color.fromARGB(255, 31, 32, 31),
    dividerColor: const Color.fromARGB(231, 37, 112, 79),
    // focusColor: const Color.fromARGB(255, 25, 196, 42),
    focusColor: const Color.fromARGB(255, 239, 184, 17),
    splashColor: const Color.fromARGB(223, 80, 82, 84),
    cardColor: const Color.fromARGB(255, 31, 32, 31),
    highlightColor: const Color.fromARGB(255, 246, 248, 250),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 211, 211, 211),
        textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      titleMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 237, 236, 236),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      titleLarge: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 212, 211, 211),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 25,
        ),
      ),
      headlineLarge: GoogleFonts.russoOne(
        color: const Color.fromARGB(255, 212, 212, 212),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 25,
          color: Color.fromARGB(255, 221, 220, 220),
        ),
      ),
      headlineSmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 223, 225, 226),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
          color: Color.fromARGB(255, 225, 225, 226),
        ),
      ),
      headlineMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 223, 224, 224),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
          color: Color.fromARGB(255, 231, 231, 232),
        ),
      ),
      displayLarge: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 226, 225, 225),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
      displayMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 232, 231, 231),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
      displaySmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 223, 222, 222),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
      bodyMedium: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 231, 230, 230),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
        ),
      ),
      bodySmall: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 227, 226, 226),
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 10,
        ),
      ),
      bodyLarge: GoogleFonts.outfit(
        color: const Color.fromARGB(255, 222, 221, 221),
        textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 145, 151, 174),
    ),
  );
}
