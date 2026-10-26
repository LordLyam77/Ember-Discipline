import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/app_config.dart';
import 'core/services/security_service.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/ember_repository.dart';
import 'features/checkin/checkin_screen.dart';
import 'features/home/home_screen.dart';
import 'features/insights/insights_screen.dart';
import 'features/journey/journey_screen.dart';
import 'features/missions/missions_screen.dart';
import 'features/navigation/main_scaffold.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/slip/slip_screen.dart';
import 'features/sos/sos_screen.dart';
import 'widgets/streak_flame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dark system overlays
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: EmberColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const EmberApp(),
    ),
  );
}

final _routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final hasOnboarded = prefs.getBool('onboarding_done') ?? false;

  return GoRouter(
    initialLocation: hasOnboarded ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/missions',
                builder: (context, state) => const MissionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/journey',
                builder: (context, state) => const JourneyScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insights',
                builder: (context, state) => const InsightsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/sos',
        builder: (context, state) {
          final habitId = state.extra as String? ?? '';
          return SosScreen(habitId: habitId);
        },
      ),
      GoRoute(
        path: '/slip',
        builder: (context, state) {
          final habitId = state.extra as String? ?? '';
          return SlipScreen(habitId: habitId);
        },
      ),
      GoRoute(
        path: '/checkin',
        builder: (context, state) => const CheckinScreen(),
      ),
    ],
  );
});

class EmberApp extends ConsumerWidget {
  const EmberApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: EmberTheme.darkTheme,
      routerConfig: router,
      builder: (context, child) {
        return AppSecurityGate(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

/// Security Gate: Handles app switcher privacy blur & PIN/Biometric lock on background resume
class AppSecurityGate extends ConsumerStatefulWidget {
  final Widget child;

  const AppSecurityGate({super.key, required this.child});

  @override
  ConsumerState<AppSecurityGate> createState() => _AppSecurityGateState();
}

class _AppSecurityGateState extends ConsumerState<AppSecurityGate>
    with WidgetsBindingObserver {
  bool _isLocked = false;
  bool _isBlurred = false;
  DateTime? _pausedAt;
  String _enteredPin = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initial check: if PIN lock enabled, start locked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = ref.read(settingsProvider);
      if (settings.hasCompletedOnboarding && settings.pinLockEnabled) {
        setState(() => _isLocked = true);
        if (settings.biometricsEnabled) {
          _tryBiometrics();
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final settings = ref.read(settingsProvider);

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _pausedAt = DateTime.now();
      if (settings.privacyBlurEnabled) {
        setState(() => _isBlurred = true);
      }
    } else if (state == AppLifecycleState.resumed) {
      if (settings.privacyBlurEnabled) {
        setState(() => _isBlurred = false);
      }

      if (settings.hasCompletedOnboarding && settings.pinLockEnabled) {
        final elapsed = _pausedAt != null
            ? DateTime.now().difference(_pausedAt!).inSeconds
            : 0;
        if (elapsed >= settings.autoLockSeconds) {
          setState(() {
            _isLocked = true;
            _enteredPin = '';
            _errorMessage = null;
          });
          if (settings.biometricsEnabled) {
            _tryBiometrics();
          }
        }
      }
    }
  }

  Future<void> _tryBiometrics() async {
    final ok = await SecurityService.authenticateBiometrics(reason: 'Unlock Ember');
    if (ok && mounted) {
      setState(() {
        _isLocked = false;
        _enteredPin = '';
        _errorMessage = null;
      });
    }
  }

  void _onDigitPressed(String digit) async {
    if (_enteredPin.length < 4) {
      HapticFeedback.lightImpact();
      final newPin = _enteredPin + digit;
      setState(() {
        _enteredPin = newPin;
        _errorMessage = null;
      });

      if (newPin.length == 4) {
        final ok = await SecurityService.verifyPin(newPin);
        if (ok) {
          HapticFeedback.selectionClick();
          if (mounted) {
            setState(() {
              _isLocked = false;
              _enteredPin = '';
            });
          }
        } else {
          HapticFeedback.heavyImpact();
          if (mounted) {
            setState(() {
              _enteredPin = '';
              _errorMessage = 'Incorrect PIN. Try again.';
            });
          }
        }
      }
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isNotEmpty) {
      HapticFeedback.lightImpact();
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // App Switcher Privacy Blur
        if (_isBlurred && !_isLocked)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                color: EmberColors.background.withAlpha(220),
                child: const Center(
                  child: StreakFlame(size: 80),
                ),
              ),
            ),
          ),

        // Full Screen Lock Screen
        if (_isLocked)
          Positioned.fill(
            child: Material(
              color: EmberColors.background,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const StreakFlame(size: 72),
                      const SizedBox(height: 20),
                      const Text(
                        AppConfig.appName,
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: EmberColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Enter 4-Digit Passcode',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: EmberColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // PIN Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          final filled = index < _enteredPin.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: filled
                                  ? EmberColors.primaryOrange
                                  : EmberColors.cardElevated,
                              border: Border.all(
                                color: filled
                                    ? EmberColors.brightOrange
                                    : EmberColors.border,
                                width: 1.5,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),

                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: EmberColors.slipWarning,
                          ),
                        ),

                      const Spacer(),

                      // Numeric Keypad (1 to 9, Biometrics, 0, Backspace)
                      Column(
                        children: [
                          _buildKeypadRow(['1', '2', '3']),
                          const SizedBox(height: 16),
                          _buildKeypadRow(['4', '5', '6']),
                          const SizedBox(height: 16),
                          _buildKeypadRow(['7', '8', '9']),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionKey(
                                icon: Icons.fingerprint,
                                onTap: _tryBiometrics,
                              ),
                              _buildDigitKey('0'),
                              _buildActionKey(
                                icon: Icons.backspace_outlined,
                                onTap: _onBackspacePressed,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((d) => _buildDigitKey(d)).toList(),
    );
  }

  Widget _buildDigitKey(String digit) {
    return GestureDetector(
      onTap: () => _onDigitPressed(digit),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: EmberColors.card,
          border: Border.all(color: EmberColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          digit,
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildActionKey({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: EmberColors.textSecondary, size: 28),
      ),
    );
  }
}
