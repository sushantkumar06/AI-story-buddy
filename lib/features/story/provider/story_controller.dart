import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'story_state.dart';

final storyControllerProvider =
    StateNotifierProvider<StoryController, StoryStatus>(
      (ref) => StoryController(),
    );

class StoryController extends StateNotifier<StoryStatus> {
  StoryController() : super(StoryStatus.idle);

  void setLoading() {
    state = StoryStatus.loading;
  }

  void setPlaying() {
    state = StoryStatus.playing;
  }

  void setCompleted() {
    state = StoryStatus.completed;
  }

  void setError() {
    state = StoryStatus.error;
  }
}
