import 'package:expenses_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);
ColorScheme kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark);

void main() {
  var lightThemeColoring = ThemeColoring(kColorScheme);
  var darkThemeColoring = ThemeColoring(kDarkColorScheme);
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: darkThemeColoring.getAppBarTheme(),
        cardTheme: darkThemeColoring.getCardTheme(),
        elevatedButtonTheme: darkThemeColoring.getElevatedButtonTheme(),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: lightThemeColoring.getAppBarTheme(),
        cardTheme: lightThemeColoring.getCardTheme(),
        elevatedButtonTheme: lightThemeColoring.getElevatedButtonTheme(),
        textTheme: lightThemeColoring.getTextTheme(),
      ),
      home: const Expenses(),
    ),
  );
}

class ThemeColoring {
  ThemeColoring(this.colorScheme);
  final ColorScheme colorScheme;

  AppBarTheme getAppBarTheme() {
    return const AppBarTheme().copyWith(
      foregroundColor: colorScheme.primaryContainer,
      backgroundColor: colorScheme.onPrimaryContainer,
    );
  }

  CardTheme getCardTheme() {
    return const CardTheme().copyWith(
      color: colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    );
  }

  ElevatedButtonThemeData getElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer),
    );
  }

  TextTheme getTextTheme() {
    return ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: colorScheme.onSecondaryContainer,
          ),
        );
  }
}
