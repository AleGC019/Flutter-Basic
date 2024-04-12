import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget{

  InformationContainer(this.outputText, {super.key});

  String outputText;

  @override
  Widget build(context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            outputText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Probemos algo nuevo!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
