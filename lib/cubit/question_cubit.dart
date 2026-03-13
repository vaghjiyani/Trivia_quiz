import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trivia_quiz/models/question_model.dart';
import 'package:trivia_quiz/repository/quiz_repository.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final QuizRepository repo;

  QuestionCubit(this.repo) : super(QuestionInitial());

  Future<void> fetchQuestion(int categoryId) async {
    try {
      emit(QuestionLoading());
      final question = await repo.fetchQuestions(categoryId);
      emit(
        QuestionLoaded(
          questions: question,
          reammingTime: 30,
          didLoadAPIValues: true,
        ),
      );
    } catch (e) {
      emit(QuestionError(e.toString()));
    }
  }

  Future<void> answerQuestion(String answer) async {
    try {
      if (state is QuestionLoaded) {
        //type cast
        final currentState = state as QuestionLoaded;

        //this is for getting current question
        final question = currentState.questions[currentState.currentIndex];
        // this for new score calculation
        int newScore = currentState.score;
        //this for the wrong answer
        int newWrong = currentState.wrong;
        //this is for the skipped
        int newSkipped = currentState.skippedQuestion;

        // this is all logic that skipped, wrong, or correct answer
        if (answer.isEmpty) {
          newSkipped++;
          newWrong++;
        } else if (answer == question.correctAnswer) {
          newScore++;
        } else {
          newWrong++;
        }

        //to move to next question and show result at last
        int index = currentState.currentIndex + 1;

        // this loop is for next question and till length
        if (index < currentState.questions.length) {
          emit(
            QuestionLoaded(
              questions: currentState.questions,
              currentIndex: index,
              score: newScore,
              wrong: newWrong,
              skippedQuestion: newSkipped,
              reammingTime: 30,
            ),
          );
        } else {
          emit(
            QuestionCompleted(
              newScore,
              currentState.questions.length,
              newSkipped,
              newWrong,
            ),
          );
        }
      }
    } catch (e) {
      emit(QuestionError(e.toString()));
    }
  }

  void changeTime() {
    if (state is QuestionLoaded) {
      final currentState = state as QuestionLoaded;
      if (currentState.reammingTime > 0) {
        emit(
          QuestionLoaded(
            questions: currentState.questions,
            currentIndex: currentState.currentIndex,
            score: currentState.score,
            wrong: currentState.wrong,
            skippedQuestion: currentState.skippedQuestion,
            reammingTime: currentState.reammingTime - 1,
          ),
        );
      } else {
        answerQuestion(''); // Auto submit after the time is completade
      }
    }
  }
}
