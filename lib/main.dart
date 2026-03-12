import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_quiz/cubit/category_cubit.dart';
import 'package:trivia_quiz/cubit/question_cubit.dart';
import 'package:trivia_quiz/screens/splace_screen.dart';
import 'package:trivia_quiz/services/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ApiServices apiServices = ApiServices();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (conntext) => CategoryCubit(apiServices)),
        BlocProvider(create: (context) => QuestionCubit(apiServices)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplaceScreen(),
      ),
    );
  }
}
