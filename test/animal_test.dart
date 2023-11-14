import 'package:flutter_test/flutter_test.dart';

import 'package:quicket_ui_sample/citations/local/sections/animal.dart';
import 'material_mocker.dart';

void main() {
  testWidgets('Animal Section Test', (widgetTester) async {
    await widgetTester.pumpWidget(materialMocker(const Animal(), WidgetType.widget));
    final titleFinder = find.text("Animal");
    expect(titleFinder, findsOneWidget);
  });
}
