import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ember/main.dart';
import 'package:ember/core/config/app_config.dart';

void main() {
  testWidgets('Ember app launches and displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: EmberApp(),
      ),
    );

    expect(find.text(AppConfig.appName), findsOneWidget);
  });
}
