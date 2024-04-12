import 'package:explorer/views/bar/Tabs.dart';
import 'package:explorer/views/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark().copyWith(
    background: Colors.black,
    primary: Colors.pink,
    secondary: Colors.white,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {},
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const TabsScreen(),
    );
  }
}
