import 'package:flutter/material.dart';
import 'package:quizz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onAnswerSelected});

  final void Function(String answwer) onAnswerSelected;

  @override
  State <QuestionsScreen> createState(){
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends  State <QuestionsScreen>{

  var currentQuestionIndex = 0;

  @override
  Widget build(context){

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
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
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:Container(
                width: 300.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    currentQuestion.question,
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              )
            ),
            const SizedBox(height: 20.0),
            ...currentQuestion.getShuffledOptions().map((answer){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                          widget.onAnswerSelected(answer);
                          currentQuestionIndex++;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                        answer,
                        style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                    ),
                  ),
                )
              );
            })

            /*
            for (var i = 0; i < currentQuestion.options.length; i++)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = currentQuestion.options[i];
                    });
                  },
                  child: Text(currentQuestion.options[i]),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
             */
          ],
        ),

      ),
    );
  }
}