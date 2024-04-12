
import 'package:flutter/material.dart';
import 'questions_screens.dart';
import '../startscreen/start_screen.dart';
import 'package:quizz_app/data/questions.dart';
import 'package:quizz_app/classes/resultscreen/resultscreen.dart';


class Quiz extends StatefulWidget{
  const Quiz({super.key});

  @override
  State <Quiz> createState(){
    return _QuizState();
  }
}

class _QuizState extends State<Quiz>{

  Widget? activeScreen;
  List <String> selectedAnswer = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void chooseAnswer(String answer){
    selectedAnswer.add(answer);

    if(selectedAnswer.length == questions.length){
      setState(() {
        activeScreen = ResultScreen(switchScreen, chosenAnswers: selectedAnswer);
        selectedAnswer = [];
      });
    }
  }

  void switchScreen(){
    setState(() {
      if(activeScreen is ResultScreen){
        activeScreen = StartScreen(switchScreen);
      }else{
        activeScreen = QuestionsScreen(onAnswerSelected: chooseAnswer);
      }
    });
  }
  
  


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        /*
        appBar: AppBar(
          title: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    'Veamos que tanto conoces',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          backgroundColor: Colors.green,
        ),
        */
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color.fromRGBO(0, 100, 0, 1.0), // dark green
                Color.fromRGBO(34, 139, 34, 1.0), // forest green
                Color.fromRGBO(144, 238, 144, 1.0), // light green
              ],
            ),
          ),
          child: activeScreen,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}