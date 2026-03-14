import 'package:trivia_quiz/models/category_model.dart';
import 'package:trivia_quiz/models/question_model.dart';
import 'package:trivia_quiz/data/services/api_services.dart';

class QuizRepository {
  final ApiServices apiServices;

  QuizRepository({required this.apiServices});

  Future<List<CategoryModel>> fetchCategory() async =>
      await apiServices.fetchCategories();

  Future<List<QuestionModel>> fetchQuestions(int cateforyId) async {
    var token = await apiServices.fetchToken();
    print(token);
    final data = await apiServices.fetchQuestion(cateforyId, token);
    return data;
  }
}

  // Future<List<QuestionModel>> fetchQuestions(
  //   int cateforyId,
  //   String token,
  // ) async {
  //   try {

  //     print("fetching Questions");
  //     final data = await apiServices.fetchQuestion(cateforyId, token);
  //     print("Questions are fetched ${data.length}");
  //     return data;
  //   } catch (e) {
  //     print("Questions not fetched $e");
  //     rethrow;
  //   }
  // }

