import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: const Color(0xFF3cbcc7),

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    // iconTheme: IconThemeData(color: kContentColorLightTheme),
    textTheme: textTheme,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF3cbcc7),
      secondary: Colors.grey.shade700,
      error: Colors.orange.shade300,
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: Colors.white,
    //   selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
    //   unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
    //   selectedIconTheme: IconThemeData(color: kPrimaryColor),
    //   showUnselectedLabels: true,
    // ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.grey),
      fillColor: MaterialStateProperty.all(
        const Color(0xFF3cbcc7),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade700,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF3cbcc7)),
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: Colors.orange,

    // scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: appBarTheme,
    // iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: textTheme,
    // colorScheme: ColorScheme.dark().copyWith(
    //   primary: kPrimaryColor,
    //   secondary: kSecondaryColor,
    //   error: kErrorColor,
    // ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: kContentColorLightTheme,
    //   selectedItemColor: Colors.white70,
    //   unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
    //   selectedIconTheme: IconThemeData(color: kPrimaryColor),
    //   showUnselectedLabels: true,
    // ),
  );
}

const appBarTheme = AppBarTheme(
  color: Color(0xFF3cbcc7),
  centerTitle: false,
  elevation: 0,
);

final TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
    fontSize: 97,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  displayMedium: GoogleFonts.roboto(
    fontSize: 61,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  displaySmall: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headlineSmall: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleMedium: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  bodySmall: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelSmall: GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
