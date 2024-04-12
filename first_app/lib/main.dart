import 'package:flutter/material.dart';
import 'package:first_app/classes/app_bar.dart';
import 'package:first_app/classes/navigation_container.dart';
import 'package:first_app/classes/information_container.dart';
import 'package:first_app/classes/cube.dart';

void main() {

  String text = 'Bienvenido a tu lugar favorito en la universidad!';

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: BarContainer(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InformationContainer(text),
              cubePoints(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationContainer(),
      ),
    ),
  );
}

/*
decoration: const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color.fromRGBO(0, 0, 0, 0.5),
      Color.fromRGBO(0, 0, 0, 0.5),
      Color.fromRGBO(0, 0, 0, 0.5),
    ],
  ),
),

 */

