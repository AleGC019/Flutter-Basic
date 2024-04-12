import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {

  const StartScreen(this.startQuiz,{super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Image(
              image: AssetImage('assets/images/quiz-logo.png'),
              width: 300.0,
              height: 300.0,
              color: Color.fromRGBO(255, 255, 255, 0.75),
            ),
            /*
            child: Opacity(
                opacity: 0.75,
              child: Image(
                image: AssetImage('assets/images/quiz-logo.png'),
                width: 300.0,
                height: 300.0,
              ),
            ),
             */
          ),
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              'Learn Flutter the fun way!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      startQuiz();
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 30.0,
                      color: Color.fromRGBO(144, 238, 144, 1.0),
                    ),
                    label: const Text(
                        'Start Quiz'
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
