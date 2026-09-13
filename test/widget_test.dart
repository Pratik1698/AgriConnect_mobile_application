import 'package:flutter_test/flutter_test.dart';

import 'package:agri_connect/app.dart';

void main() {
  testWidgets('AgriConnect splash screen shows app name', (tester) async {
    await tester.pumpWidget(const AgriConnectApp());

    expect(find.text('AgriConnect'), findsOneWidget);
    expect(
      find.text('Connecting Farmers to Agricultural Services'),
      findsOneWidget,
    );
  });
}
