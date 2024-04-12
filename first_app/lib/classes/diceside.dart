import 'package:flutter/material.dart';
import 'dart:math';

class DiceSide extends StatefulWidget{

  const DiceSide({super.key});

  @override
  State <DiceSide> createState(){
    return _DiceSideState();
  }
}

class _DiceSideState extends State<DiceSide> {

  List<String> images = [
    'assets/dice-1.png',
    'assets/dice-2.png',
    'assets/dice-3.png',
    'assets/dice-4.png',
    'assets/dice-5.png',
    'assets/dice-6.png',
  ];

  int number = 0;

  int getRandomNumber() {
    var random = Random();
    return random.nextInt(6);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  size: 40.0,
                ),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    number = getRandomNumber();
                  });
                },
              ),
            ],
          ),

        ),
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
                child: Image.asset(
                  images[number],
                  width: 200.0,
                  height: 200.0,
                )
            )
        ),
      ],
    );
  }
}