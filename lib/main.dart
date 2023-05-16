import 'package:bolsa_projeto/screens/games_screen.dart';
import 'package:bolsa_projeto/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/games': (context) => const GamesScreen(),
        
      },
    );
  }
}

ThemeData theme = ThemeData(
  textTheme: TextTheme(
    titleMedium: GoogleFonts.aBeeZee(),
    titleLarge: GoogleFonts.aBeeZee(),
    titleSmall: GoogleFonts.aBeeZee(),
    bodyMedium: GoogleFonts.aBeeZee(),
    bodySmall: GoogleFonts.aBeeZee(),
    bodyLarge: GoogleFonts.aBeeZee(),
  ),
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.grey,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.black,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Color.fromARGB(255, 55, 55, 55),
      onSurface: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.deepPurple),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(GoogleFonts.aBeeZee()),
      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
    ),
  ),
);
