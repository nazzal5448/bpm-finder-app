import 'package:flutter_test/flutter_test.dart';
import 'package:bpm_finder/main.dart';

void main() {
  testWidgets('App renders splash screen cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(const BpmFinderApp());
    expect(find.text('BPM Finder'), findsOneWidget);
  });
}
