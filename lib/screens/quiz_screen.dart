import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_quiz/cubit/question_cubit.dart';
import 'package:trivia_quiz/screens/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String>? currentAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions"), centerTitle: true),

      body: BlocListener<QuestionCubit, QuestionState>(
        listener: (context, state) {
          //loading the shuffleing the question
          if (state is QuestionLoaded) {
            final question = state.questions[state.currentIndex];
            currentAnswer = [
              ...question.incorrectAnswers,
              question.correctAnswer,
            ];
            currentAnswer!.shuffle();
          }
          // error
          if (state is QuestionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Wait for some second or the Questions")),
            );
            Navigator.pop(context);
          }

          // navigating ti result screen
          if (state is QuestionCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ResultScreen()),
            );
          }
        },
        child: BlocBuilder<QuestionCubit, QuestionState>(
          builder: (context, state) {
            if (state is QuestionLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is QuestionLoaded) {
              final time = state.reammingTime;
              //this is taking questions from state
              final questions = state.questions[state.currentIndex];
              //this is gets all answers from questions
              final answers = questions.allAnswer;

              return Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(),
                    Text(
                      // this is question count
                      "Questions ${state.currentIndex + 1}/ ${state.questions.length}",
                    ),
                    SizedBox(height: 20),
                    Text(
                      //this is question text
                      questions.question,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "${time} seconds left",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 40),

                    //this make button for every answer chnage the question after the clicking the buttoin
                    ...answers.map((answers) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<QuestionCubit>().answerQuestion(
                              answers,
                            );
                          },
                          child: Text(answers),
                        ),
                      );
                    }),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
