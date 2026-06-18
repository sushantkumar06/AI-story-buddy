import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vibration/vibration.dart';

import 'success_card.dart';
import '../model/quiz_model.dart';
import '../provider/quiz_controller.dart';
import '../provider/quiz_state.dart';
import '../provider/selected_option_provider.dart';
import '../provider/shake_provider.dart';

class QuizCard extends ConsumerWidget {
  final QuizModel quiz;

  const QuizCard({super.key, required this.quiz});

  Future<void> handleAnswer({
    required WidgetRef ref,
    required String option,
    required QuizModel quiz,
  }) async {
    ref.read(selectedOptionProvider.notifier).state = option;

    ref
        .read(quizControllerProvider.notifier)
        .checkAnswer(selectedOption: option, quiz: quiz);

    final bool isCorrect = option == quiz.answer;

    final bool hasVibrator = await Vibration.hasVibrator();

    if (hasVibrator) {
      if (isCorrect) {
        Vibration.vibrate(duration: 100);
      } else {
        Vibration.vibrate(duration: 300);

        ref.read(shakeProvider.notifier).state++;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizStatus = ref.watch(quizControllerProvider);
    final selectedOption = ref.watch(selectedOptionProvider);
    final shakeCount = ref.watch(shakeProvider);

    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 12,
                offset: Offset(0, 4),
                color: Colors.black12,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ...quiz.options.map((option) {
                final bool isSelected = selectedOption == option;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            quizStatus == QuizStatus.correct &&
                                option == quiz.answer
                            ? Colors.green
                            : isSelected
                            ? Colors.deepPurple
                            : Colors.white,
                        foregroundColor: isSelected
                            ? Colors.white
                            : Colors.black,
                        side: BorderSide(
                          color: isSelected
                              ? Colors.deepPurple
                              : Colors.grey.shade300,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: quizStatus == QuizStatus.correct
                          ? null
                          : () {
                              handleAnswer(
                                ref: ref,
                                option: option,
                                quiz: quiz,
                              );
                            },
                      child: Text(option, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              if (quizStatus == QuizStatus.correct)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '🎉 Correct Answer!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

              if (quizStatus == QuizStatus.incorrect)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '❌ Incorrect. Try again.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

              if (quizStatus == QuizStatus.correct) const SuccessCard(),
            ],
          ),
        )
        .animate(target: shakeCount.toDouble())
        .shake(hz: 4, duration: const Duration(milliseconds: 500));
  }
}
