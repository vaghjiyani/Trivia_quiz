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

  Future<List<QuestionModel>> fetchQuestion(
    int categoryId,
    String token,
  ) async {
    try {
      final response = await dio.get(
        'https://opentdb.com/api.php',
        queryParameters: {
          'amount': 10,
          'category': categoryId,
          'type': 'multiple',
          'token': token,
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

  Future<String> fetchToken() async {
    try {
      final response = await dio.get(
        'https://opentdb.com/api_token.php?command=request',
      );
      if (response.data['response_code'] == 0) {
        return response.data['token'];
      } else {
        throw Exception("token not found");
      }
    } catch (e) {
      rethrow;
    }
  }
}
