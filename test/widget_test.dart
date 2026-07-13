import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:joojo_chat/app/app.dart';

void main() {
  testWidgets('Joojo Chat app builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: JoojoChatApp(),
      ),
    );

    expect(find.byType(JoojoChatApp), findsOneWidget);
  });
}
