import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ember/main.dart';
import 'package:ember/core/config/app_config.dart';
import 'package:ember/data/repositories/ember_repository.dart';

void main() {
  testWidgets('Ember app launches and displays onboarding or title', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const EmberApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Welcome to Ember or Ember is displayed
    expect(find.textContaining(AppConfig.appName), findsWidgets);
  });
}
