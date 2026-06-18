import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/quiz_model.dart';
import 'quiz_state.dart';

final quizControllerProvider =
    StateNotifierProvider<QuizController, QuizStatus>(
      (ref) => QuizController(),
    );

class QuizController extends StateNotifier<QuizStatus> {
  QuizController() : super(QuizStatus.initial);

  void checkAnswer({required String selectedOption, required QuizModel quiz}) {
    if (selectedOption == quiz.answer) {
      state = QuizStatus.correct;
    } else {
      state = QuizStatus.incorrect;
    }
  }
}
