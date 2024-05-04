import 'package:flutter/material.dart';

class ItAdminColorTheme {
  static ThemeData get light => ThemeData(
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(81, 81, 81, 1.0),
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(81, 81, 81, 1.0),
          ),
          titleLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(81, 81, 81, 1.0),
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(38, 71, 86, 0.5),
          ),
          headlineLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(38, 71, 86, 0.7),
          ),
          headlineSmall: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(38, 71, 86, 1.0),
          ),
          labelMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(38, 71, 86, 1)),
          displayLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(22, 27, 28, 1),
          ),
        ),
        colorScheme: const ColorScheme(
          background: Color.fromARGB(255, 249, 252, 255), //! already set
          brightness: Brightness.light,
          error: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          primary: Colors.black, //! already set
          secondary: Color.fromRGBO(242, 242, 242, 1), //! already set
          surface: Color.fromRGBO(226, 226, 226, 1), //! already set
          secondaryContainer: Colors.white, //! already set
          onSecondaryContainer:
              Color.fromRGBO(205, 210, 218, 1), //! already set
          onTertiaryContainer: Color.fromRGBO(249, 249, 249, 1), //! already set
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color.fromARGB(255, 205, 210, 218),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 249, 252, 255),
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.black,
          thickness: 1,
        ),
      );
  ThemeData get dark => ThemeData(
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(255, 255, 255, 0.5),
          ),
          titleLarge: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          bodySmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(255, 255, 255, 0.7),
          ),
          headlineMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(255, 255, 255, 0.5),
          ),
          headlineLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(255, 255, 255, 0.7),
          ),
          headlineSmall: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
          labelMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(255, 255, 255, 1)),
          displayLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(22, 27, 28, 1),
          ),
        ),
        colorScheme: const ColorScheme(
          background: Color.fromARGB(255, 22, 27, 28), //! already set
          brightness: Brightness.dark,
          error: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          primary: Color.fromARGB(255, 31, 35, 38), //! already set
          secondary: Colors.white, //! color for different themes
          surface: Color.fromRGBO(215, 215, 215, 1), //! already set
          secondaryContainer: Color.fromARGB(255, 33, 37, 38), //! already set
          onSecondaryContainer:
              Color.fromRGBO(215, 215, 215, 1), //! already set
          onTertiaryContainer: Colors.white, //! already set
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 31, 35, 38),
            foregroundColor: const Color.fromARGB(255, 120, 120, 120),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 22, 27, 28),
        ),
        dividerTheme: const DividerThemeData(
          color: Color.fromARGB(50, 195, 239, 255),
          thickness: 1,
        ),
      );
}
