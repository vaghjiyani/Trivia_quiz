import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_quiz/cubit/category_cubit.dart';
import 'package:trivia_quiz/cubit/question_cubit.dart';
import 'package:trivia_quiz/screens/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), centerTitle: true),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CategoryError) {
            return Center(child: Text(state.message));
          }
          if (state is CategoryLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final categories = state.categories[index];
                return Card(
                  child: ListTile(
                    title: Text(categories.name),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      context.read<QuestionCubit>().fetchQuestion(
                        categories.id,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizScreen()),
                      );
                    },
                  ),
                );
              },
            );
          }

          return Center(child: Text("no Category is loaded"));
        },
      ),
    );
  }
}
