class QuestionModel {
  final String category;
  final String correctAnswer;
  final String question;
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.category,
    required this.correctAnswer,
    required this.question,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      category: json['category'],
      correctAnswer: json['correct_answer'],

      question: json['question'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }
  List<String> get allAnswer {
    final answer = [...incorrectAnswers, correctAnswer];
    return answer;
  }
}
