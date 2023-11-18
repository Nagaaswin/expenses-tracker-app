import 'package:expenses_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: kColorScheme.primaryContainer,
          backgroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.secondaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
