import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/mock_data.dart';
import '../../quiz/provider/quiz_provider.dart';
import '../../quiz/widget/quiz_card.dart';
import '../provider/story_controller.dart';
import '../provider/story_state.dart';
import '../provider/tts_service.dart';
import '../widget/buddy_card.dart';
import '../widget/read_story_button.dart';
import '../widget/story_card.dart';

class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({super.key});

  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  final TtsService ttsService = TtsService();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ttsService.initialize(
      onComplete: () {
        ref.read(storyControllerProvider.notifier).setCompleted();

        ref.read(quizVisibleProvider.notifier).state = true;

        Future.delayed(const Duration(milliseconds: 300), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        });
      },
      onError: () {
        ref.read(storyControllerProvider.notifier).setError();
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> startStory() async {
    ref.read(storyControllerProvider.notifier).setLoading();

    await Future.delayed(const Duration(milliseconds: 500));

    ref.read(storyControllerProvider.notifier).setPlaying();

    await ttsService.speak(storyText);
  }

  @override
  Widget build(BuildContext context) {
    final storyStatus = ref.watch(storyControllerProvider);
    final quizVisible = ref.watch(quizVisibleProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('AI Story Buddy'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Center(child: BuddyCard()),

            const SizedBox(height: 30),

            StoryCard(storyText: storyText),

            const SizedBox(height: 30),

            ReadStoryButton(onPressed: startStory),

            const SizedBox(height: 20),

            if (storyStatus == StoryStatus.loading)
              const CircularProgressIndicator(),

            if (storyStatus == StoryStatus.playing)
              const Text('Reading story...'),

            if (storyStatus == StoryStatus.error)
              const Text('Something went wrong. Please try again.'),

            const SizedBox(height: 30),

            if (quizVisible) QuizCard(quiz: quizModel),
          ],
        ),
      ),
    );
  }
}
