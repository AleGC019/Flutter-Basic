import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'classes/expenses/expenses.dart';

var tcolorsScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var tdarkcolorsScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
  brightness: Brightness.dark,
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((function) => {
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
              darkTheme: ThemeData().copyWith(
                  colorScheme: tdarkcolorsScheme,
                  appBarTheme: const AppBarTheme().copyWith(
                    backgroundColor: tdarkcolorsScheme.primary,
                    foregroundColor: tdarkcolorsScheme.primaryContainer,
                  ),
                  cardTheme: const CardTheme().copyWith(
                    color: tdarkcolorsScheme.secondaryContainer,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdarkcolorsScheme.primaryContainer,
                    ),
                  )),
              theme: ThemeData().copyWith(
                  colorScheme: tcolorsScheme,
                  appBarTheme: const AppBarTheme().copyWith(
                    backgroundColor: tcolorsScheme.primary,
                    foregroundColor: tcolorsScheme.primaryContainer,
                  ),
                  cardTheme: const CardTheme().copyWith(
                    color: tcolorsScheme.secondaryContainer,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tcolorsScheme.primaryContainer,
                    ),
                  )),
              themeMode: ThemeMode.system,
              home: const Expenses()
          ),
        );
     // });
}
