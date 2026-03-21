import 'package:flutter_test/flutter_test.dart';

import 'package:movie_app/main.dart';

void main() {
  testWidgets('Movie app renders first home page', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());

    expect(find.text('Movie App'), findsOneWidget);
    expect(find.text('Welcome to Movie App 1!'), findsOneWidget);
  });
}
