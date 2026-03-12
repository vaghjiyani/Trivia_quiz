import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trivia_quiz/models/category_model.dart';
import 'package:trivia_quiz/services/api_services.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ApiServices apiServices;
  CategoryCubit(this.apiServices) : super(CategoryInitial());

  Future<void> fetchCategory() async {
    try {
      emit(CategoryLoading());
      final categories = await apiServices.fetchCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
