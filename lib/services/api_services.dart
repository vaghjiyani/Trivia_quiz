import 'package:dio/dio.dart';

import 'package:trivia_quiz/models/category_model.dart';
import 'package:trivia_quiz/models/question_model.dart';

class ApiServices {
  final Dio dio = Dio();

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await dio.get('https://opentdb.com/api_category.php');
      final List category = response
          .data["trivia_categories"]; //key that cantain list of categories

      // this is for convert list of json into object to list<Model>
      // in simple conversion
      return category.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<QuestionModel>> fetchQuestion(int cateforyId) async {
    try {
      final response = await dio.get(
        'https://opentdb.com/api.php',
        queryParameters: {
          'amount': 10,
          'category': cateforyId,
          'type': 'multiple',
        },
      );

      final List result =
          response.data["results"]; // becouse this is convert in json

      // conversion of the object to the list
      return result.map((json) => QuestionModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        throw Exception("Too Many Requests");
      }
      print(e);
      rethrow;
    }
  }
}
