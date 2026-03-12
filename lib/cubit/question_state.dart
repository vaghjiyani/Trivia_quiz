part of 'question_cubit.dart';

class QuestionState {}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

//this is for to see update live as a quiz progress
class QuestionLoaded extends QuestionState {
  final List<QuestionModel> questions;
  final int currentIndex;
  final int score;
  final int skippedQuestion;
  final int wrong;
  final int reammingTime;

  QuestionLoaded({
    required this.questions,
    this.currentIndex = 0,
    this.score = 0,
    this.skippedQuestion = 0,
    this.wrong = 0,
    required this.reammingTime,
  });
}

// this is for when quiz is completed to show the what happen in screen or u can say to see score

class QuestionCompleted extends QuestionState {
  final int score;
  final int total;
  final int skipped;
  final int wrong;

  QuestionCompleted(this.score, this.total, this.skipped, this.wrong);
}

class QuestionError extends QuestionState {
  final String message;

  QuestionError(this.message);
}
