class QuizQuestions{

  const QuizQuestions(this.question, this.options, this.answer);

  final String question;
  final List<String> options;
  final String answer;

  List<String> getShuffledOptions(){
    final shuffledOptions = List.of(options);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

  factory QuizQuestions.fromJson(Map<String, dynamic> json){
    return QuizQuestions(
      json['question'],
      json['options'],
      json['answer']
    );
  }
}