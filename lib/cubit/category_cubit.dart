import 'package:bloc/bloc.dart';
import 'package:trivia_quiz/models/category_model.dart';
import 'package:trivia_quiz/repository/quiz_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final QuizRepository repo;
  CategoryCubit(this.repo) : super(CategoryInitial());

  Future<void> fetchCategory() async {
    try {
      emit(CategoryLoading());
      final categories = await repo.fetchCategory();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
