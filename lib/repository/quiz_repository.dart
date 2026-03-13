import 'package:trivia_quiz/models/category_model.dart';
import 'package:trivia_quiz/models/question_model.dart';
import 'package:trivia_quiz/services/api_services.dart';

class QuizRepository {
  final ApiServices apiServices;

  QuizRepository({required this.apiServices});

  Future<List<CategoryModel>> fetchCategory() async {
    try {
      print("fetching categories");
      final data = await apiServices.fetchCategories();
      print("Category is fateched ${data.length}");
      return data;
    } catch (e) {
      print("category not get $e");
      rethrow;
    }
  }

  Future<List<QuestionModel>> fetchQuestions(int cateforyId) async {
    try {
      print("fetching Questions");
      final data = await apiServices.fetchQuestion(cateforyId);
      print("Questions are fetched ${data.length}");
      return data;
    } catch (e) {
      print("Questions not fetched $e");
      rethrow;
    }
  }
}
