import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gestion_recursos/main.dart';

void main() {
  testWidgets('App creates smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
  });
}
