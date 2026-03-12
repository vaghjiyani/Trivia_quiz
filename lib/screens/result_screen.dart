import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_quiz/cubit/question_cubit.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result Screen'), centerTitle: true),

      body: BlocBuilder<QuestionCubit, QuestionState>(
        builder: (context, state) {
          if (state is QuestionCompleted) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text(
                    "Correct : ${state.score}",
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Wrong : ${state.wrong}",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  Text(
                    "Skipped : ${state.skipped}",
                    style: TextStyle(color: Colors.blue, fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Totol score : ${state.score} / Total Question ${state.total}",
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text("loading"));
        },
      ),
    );
  }
}
