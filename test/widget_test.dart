import 'package:flutter_test/flutter_test.dart';
import 'package:proptrack/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    await tester.pumpWidget(const PropTrackApp());
  });
}
