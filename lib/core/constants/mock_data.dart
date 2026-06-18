import '../../features/quiz/model/quiz_model.dart';

const String storyText =
    "Once upon a time, a clever little robot named Pip lost his shiny blue gear in the Whispering Woods...";

const quizJson = {
  "question": "What colour was Pip the Robot's lost gear?",
  "options": ["Red", "Green", "Blue", "Yellow"],
  "answer": "Blue",
};

final QuizModel quizModel = QuizModel.fromJson(quizJson);
