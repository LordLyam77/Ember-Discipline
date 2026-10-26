import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'widgets/streak_flame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style to dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: EmberColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: EmberApp(),
    ),
  );
}

class EmberApp extends StatelessWidget {
  const EmberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: EmberTheme.darkTheme,
      home: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreakFlame(size: 100),
                  SizedBox(height: 24),
                  Text(
                    AppConfig.appName,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    AppConfig.appTagline,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: EmberColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
