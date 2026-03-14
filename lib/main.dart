import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_quiz/cubit/category_cubit.dart';
import 'package:trivia_quiz/cubit/question_cubit.dart';
import 'package:trivia_quiz/data/repository/quiz_repository.dart';
import 'package:trivia_quiz/screens/splace_screen.dart';
import 'package:trivia_quiz/data/services/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final QuizRepository repo = QuizRepository(apiServices: ApiServices());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (conntext) => CategoryCubit(repo)),
        BlocProvider(create: (context) => QuestionCubit(repo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trivia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplaceScreen(),
      ),
    );
  }
}
