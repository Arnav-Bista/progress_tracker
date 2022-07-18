import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF1d3461),
              onPrimary: Colors.white,
              secondary: const Color(0xFFfb3640),
              onSecondary: Colors.white,
            ),
      ),
      home: const MainScreen(),
    );
  }
}

// ColorScheme(
//           brightness: Brightness.light,
//           primary: const Color(0xFF1d3461),
//           onPrimary: Colors.white,
//           secondary: const Color(0xFFfb3640),
//           onSecondary: Colors.white,
//           error: Colors.red,
//           onError: Colors.white,
          
//         ),