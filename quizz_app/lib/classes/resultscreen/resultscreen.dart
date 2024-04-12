import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/data/questions.dart';
import 'package:quizz_app/classes/resultscreen/summaryquestion.dart';

class ResultScreen extends StatelessWidget{
  const ResultScreen(this.startQuiz, {super.key, required this.chosenAnswers});

  final void Function() startQuiz;

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryQuestions(){
    final List<Map<String, Object>> summaryQuestions = [];

    for(var i = 0; i < chosenAnswers.length; i++){
      summaryQuestions.add({
        'questionindex': i,
        'question': questions[i].question,
        'answer': chosenAnswers[i],
        'correctAnswer': questions[i].answer,
      });
    }

    return summaryQuestions;
  }

  String getSummaryData(){
    var correctAnswers = 0;
    for(var i = 0; i < chosenAnswers.length; i++){
      if(chosenAnswers[i] == questions[i].answer){
        correctAnswers++;
      }
    }

    var buffer = StringBuffer();
    buffer.write('Resultado, respuestas correctas: $correctAnswers/${questions.length}\n');


    return buffer.toString();
  }

  @override
  Widget build(context){
    return MaterialApp(
        home: Scaffold(
            body: Center(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(34, 139, 34, 1.0),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getSummaryData(),
                            style: GoogleFonts.lato(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          SummaryQuestion(getSummaryQuestions()),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              startQuiz();
                            },
                            child: const Text('Volver a intentar'),
                          ),
                        ],
                      ),
                    )
                  )
              ),
            ),
        )
    );
  }
}