import 'package:flutter/material.dart';
import 'package:tanvir/splash_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        colorSchemeSeed: Colors.blue,
        inputDecorationTheme: _buildInputDecorationTheme(),
        elevatedButtonTheme: _buildElevatedButtonThemeData(),
      ),
      home: SplashScreen(),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[600],
        foregroundColor: Colors.grey[300],
        fixedSize: const Size(double.maxFinite, 54),
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.grey),
      border: _buildOutlineInputBorder(),
      focusedBorder: _buildOutlineInputBorder(),
      enabledBorder: _buildOutlineInputBorder(),
      errorBorder: _buildOutlineInputBorder(),
      focusedErrorBorder: _buildOutlineInputBorder(),
      disabledBorder: _buildOutlineInputBorder(),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.shade100),
    );
  }
  }
