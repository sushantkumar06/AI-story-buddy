import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:peblo_story_buddy/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: StoryBuddyApp(),
      ),
    );

    expect(find.text('AI Story Buddy'), findsOneWidget);
  });
}