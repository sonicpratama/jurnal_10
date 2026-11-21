import 'package:flutter_test/flutter_test.dart';
import 'package:template_pekan_10/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(AplikasiPuskesmasBandung());
    expect(find.byType(AplikasiPuskesmasBandung), findsOneWidget);
  });
}
