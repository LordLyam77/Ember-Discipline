import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/streak_flame.dart';
import '../../data/repositories/ember_repository.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentStep = 0;
  final int _totalSteps = 5;

  // Selected Habits
  final List<String> _availableHabits = [
    'Porn / Lust',
    'Social Media',
    'Smoking',
    'Vaping',
    'Alcohol',
    'Junk Food',
    'Gaming',
    'Gambling',
    'Procrastination',
  ];
  final Set<String> _selectedHabits = {};
  final TextEditingController _customHabitController = TextEditingController();

  // Habit configuration data
  String _selectedGoal = 'quit_fully'; // 'quit_fully' or 'reduce'
  final TextEditingController _whyController = TextEditingController();
  final DateTime _startDate = DateTime.now();

  // Danger times
  final List<String> _availableDangerTimes = [
    'Morning Wake-up',
    'Afternoon Slump',
    'Commute Home',
    'Late Evening (9-11 PM)',
    'Late Night (11 PM - 2 AM)',
    'Unstructured Weekends',
    'When Lonely or Bored',
    'When Stressed or Exhausted',
  ];
  final Set<String> _selectedDangerTimes = {};

  // Security & Notification
  bool _enablePin = false;
  final TextEditingController _pinController = TextEditingController();
  TimeOfDay? _notificationTime = const TimeOfDay(hour: 20, minute: 30);

  @override
  void dispose() {
    _customHabitController.dispose();
    _whyController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  bool get _hasChemicalWithdrawalRisk {
    return _selectedHabits.contains('Alcohol') ||
        _selectedHabits.any((h) => h.toLowerCase().contains('drug') || h.toLowerCase().contains('substance'));
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    } else {
      _finishOnboarding();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _finishOnboarding() async {
    final manager = ref.read(emberManagerProvider);

    // Save habit(s)
    final habitList = _selectedHabits.toList();
    if (habitList.isEmpty) {
      habitList.add('Discipline');
    }

    for (final habitName in habitList) {
      String type = 'custom';
      if (habitName.contains('Porn')) type = 'porn';
      if (habitName.contains('Social')) type = 'social_media';
      if (habitName.contains('Smoking')) type = 'smoking';
      if (habitName.contains('Vaping')) type = 'vaping';
      if (habitName.contains('Alcohol')) type = 'alcohol';
      if (habitName.contains('Junk')) type = 'junk_food';
      if (habitName.contains('Gaming')) type = 'gaming';
      if (habitName.contains('Gambling')) type = 'gambling';
      if (habitName.contains('Procrastination')) type = 'procrastination';

      await manager.addHabit(
        name: habitName,
        type: type,
        goal: _selectedGoal,
        startAt: _startDate,
        why: _whyController.text.trim().isEmpty
            ? 'I am taking control of my mind and life.'
            : _whyController.text.trim(),
        dangerTimes: _selectedDangerTimes.toList(),
      );
    }

    // Save settings
    final settingsNotifier = ref.read(settingsProvider.notifier);
    if (_enablePin && _pinController.text.isNotEmpty) {
      await settingsNotifier.setPinLockEnabled(true);
    }
    if (_notificationTime != null) {
      final formatted =
          '${_notificationTime!.hour.toString().padLeft(2, '0')}:${_notificationTime!.minute.toString().padLeft(2, '0')}';
      await settingsNotifier.setNotificationTime(formatted);
    }
    await settingsNotifier.setOnboardingCompleted(true);

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: _prevStep,
              )
            : null,
        title: Text(
          'Step ${_currentStep + 1} of $_totalSteps',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: EmberColors.textSecondary,
          ),
        ),
        actions: [
          if (_currentStep == 0 || _currentStep == 4)
            TextButton(
              onPressed: _finishOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(color: EmberColors.textSecondary),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Progress Line
              LinearProgressIndicator(
                value: (_currentStep + 1) / _totalSteps,
                backgroundColor: EmberColors.cardElevated,
                valueColor: const AlwaysStoppedAnimation<Color>(EmberColors.primaryOrange),
                minHeight: 3,
              ),
              const SizedBox(height: 24),

              // Step Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _buildCurrentStep(),
                ),
              ),

              // Bottom Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GlowButton(
                  text: _currentStep == _totalSteps - 1 ? 'Ignite My Ember' : 'Continue',
                  width: double.infinity,
                  onPressed: _canProceed ? _nextStep : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _canProceed {
    if (_currentStep == 1) {
      return _selectedHabits.isNotEmpty || _customHabitController.text.trim().isNotEmpty;
    }
    return true;
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildHabitsStep();
      case 2:
        return _buildGoalAndWhyStep();
      case 3:
        return _buildDangerTimesStep();
      case 4:
        return _buildSecurityStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildWelcomeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        const StreakFlame(size: 110),
        const SizedBox(height: 32),
        const Text(
          'Welcome to Ember',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'This is not a 30-day challenge.\nThis is a 12-month journey to master your impulses and build real self-worth.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            color: EmberColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        EmberCard(
          backgroundColor: EmberColors.cardElevated,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.favorite_outline, color: EmberColors.primaryOrange, size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kind, Calm, Resilient',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'We never shame you. A slip is data, not failure. All your records stay 100% offline on your phone.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EmberColors.textSecondary.withAlpha(220),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        EmberCard(
          backgroundColor: EmberColors.card,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.health_and_safety_outlined, color: EmberColors.infoBlue, size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Medical Notice',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConfig.disclaimer,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: EmberColors.textSecondary.withAlpha(200),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHabitsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What habits or addictions do you want to beat?',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select one or more. You can track multiple habits simultaneously.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: EmberColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _availableHabits.map((habit) {
            final isSelected = _selectedHabits.contains(habit);
            return FilterChip(
              label: Text(habit),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedHabits.add(habit);
                  } else {
                    _selectedHabits.remove(habit);
                  }
                });
              },
              backgroundColor: EmberColors.cardElevated,
              selectedColor: EmberColors.primaryOrange.withAlpha(50),
              checkmarkColor: EmberColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? EmberColors.primaryOrange : EmberColors.border,
                ),
              ),
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? EmberColors.textPrimary : EmberColors.textSecondary,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),
        TextField(
          controller: _customHabitController,
          decoration: InputDecoration(
            hintText: 'Add custom habit (optional)',
            hintStyle: const TextStyle(color: EmberColors.textTertiary),
            filled: true,
            fillColor: EmberColors.cardElevated,
            suffixIcon: IconButton(
              icon: const Icon(Icons.add, color: EmberColors.primaryOrange),
              onPressed: () {
                final text = _customHabitController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    _selectedHabits.add(text);
                    _customHabitController.clear();
                  });
                }
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: EmberColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: EmberColors.border),
            ),
          ),
        ),

        if (_hasChemicalWithdrawalRisk) ...[
          const SizedBox(height: 20),
          EmberCard(
            backgroundColor: EmberColors.slipWarning.withAlpha(20),
            customBorder: Border.all(color: EmberColors.slipWarning.withAlpha(120)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: EmberColors.slipWarning, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Safety Warning: Stopping alcohol or heavy substances suddenly can cause severe physical withdrawal symptoms. Please consult a medical doctor before quitting cold turkey.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EmberColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGoalAndWhyStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Goal & The "Why"',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose your target and write down the deep reason you want to break free.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: EmberColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),

        // Goal selector
        Row(
          children: [
            Expanded(
              child: EmberCard(
                onTap: () => setState(() => _selectedGoal = 'quit_fully'),
                hasGlow: _selectedGoal == 'quit_fully',
                backgroundColor: _selectedGoal == 'quit_fully'
                    ? EmberColors.cardElevated
                    : EmberColors.card,
                child: Column(
                  children: [
                    Icon(
                      Icons.shield,
                      color: _selectedGoal == 'quit_fully'
                          ? EmberColors.primaryOrange
                          : EmberColors.textSecondary,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Quit Fully',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Zero tolerance',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: EmberColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: EmberCard(
                onTap: () => setState(() => _selectedGoal = 'reduce'),
                hasGlow: _selectedGoal == 'reduce',
                backgroundColor: _selectedGoal == 'reduce'
                    ? EmberColors.cardElevated
                    : EmberColors.card,
                child: Column(
                  children: [
                    Icon(
                      Icons.trending_down,
                      color: _selectedGoal == 'reduce'
                          ? EmberColors.primaryOrange
                          : EmberColors.textSecondary,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Reduce & Control',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Gradual taper',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: EmberColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),
        const Text(
          'My Why (Personal Anchor)',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _whyController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText:
                'e.g. "I want to be fully present with my family, reclaim my clarity, and wake up proud of myself every morning."',
            hintStyle: const TextStyle(color: EmberColors.textTertiary, fontSize: 13),
            filled: true,
            fillColor: EmberColors.cardElevated,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: EmberColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: EmberColors.border),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerTimesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Identify Your Danger Times',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'When are you most vulnerable? Knowing your danger hours lets Ember prepare proactive defenses.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: EmberColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _availableDangerTimes.map((time) {
            final isSelected = _selectedDangerTimes.contains(time);
            return FilterChip(
              label: Text(time),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedDangerTimes.add(time);
                  } else {
                    _selectedDangerTimes.remove(time);
                  }
                });
              },
              backgroundColor: EmberColors.cardElevated,
              selectedColor: EmberColors.primaryOrange.withAlpha(50),
              checkmarkColor: EmberColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? EmberColors.primaryOrange : EmberColors.border,
                ),
              ),
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: isSelected ? EmberColors.textPrimary : EmberColors.textSecondary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSecurityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Privacy & Routine',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Optional security lock and daily check-in time. You can change these anytime in Settings.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: EmberColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),

        EmberCard(
          backgroundColor: EmberColors.cardElevated,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text(
                  'Enable Passcode Lock',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: EmberColors.textPrimary,
                  ),
                ),
                subtitle: const Text(
                  'Locks app when closed for 30+ seconds',
                  style: TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                ),
                value: _enablePin,
                activeTrackColor: EmberColors.primaryOrange,
                onChanged: (val) => setState(() => _enablePin = val),
              ),
              if (_enablePin) ...[
                const Divider(color: EmberColors.border),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter 4-digit PIN',
                      hintStyle: const TextStyle(color: EmberColors.textTertiary),
                      filled: true,
                      fillColor: EmberColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: EmberColors.border),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 20),
        EmberCard(
          backgroundColor: EmberColors.cardElevated,
          child: ListTile(
            leading: const Icon(Icons.notifications_active_outlined, color: EmberColors.primaryOrange),
            title: const Text(
              'Daily Check-In Reminder',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: EmberColors.textPrimary,
              ),
            ),
            subtitle: Text(
              _notificationTime != null
                  ? 'Remind me daily at ${_notificationTime!.format(context)}'
                  : 'No notification set',
              style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
            ),
            trailing: const Icon(Icons.edit, size: 18, color: EmberColors.textSecondary),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _notificationTime ?? const TimeOfDay(hour: 20, minute: 30),
              );
              if (picked != null) {
                setState(() => _notificationTime = picked);
              }
            },
          ),
        ),
      ],
    );
  }
}
