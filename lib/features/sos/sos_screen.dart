import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/breathing_circle.dart';
import '../../widgets/ember_burst.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/glow_button.dart';

class SosScreen extends ConsumerStatefulWidget {
  final String habitId;

  const SosScreen({super.key, required this.habitId});

  @override
  ConsumerState<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends ConsumerState<SosScreen> {
  int _step = 1;
  int _strengthBefore = 3;
  int _strengthAfter = 1;
  String? _selectedTriggerTag;
  String? _selectedQuickAction;

  // 10-minute timer = 600 seconds
  int _remainingSeconds = 600;
  Timer? _countdownTimer;
  bool _showEmberBurst = false;

  final List<String> _quickActions = [
    '20 Quick Pushups',
    'Walk Outside in Fresh Air',
    'Splash Cold Water on Face',
    'Call or Message a Friend',
    'Drink a Large Glass of Water',
    '5 Minutes of Stretching',
  ];

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => _step = 4);
      }
    });
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> _handleSuccess() async {
    HapticFeedback.heavyImpact();
    setState(() => _showEmberBurst = true);

    final manager = ref.read(emberManagerProvider);
    await manager.recordUrgeSurvived(
      habitId: widget.habitId,
      strengthBefore: _strengthBefore,
      strengthAfter: _strengthAfter,
      triggerTag: _selectedTriggerTag,
      usedSos: true,
    );

    // Give time for ember burst animation
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      context.pop();
    }
  }

  void _handleSlipped() {
    context.pushReplacement('/slip', extra: widget.habitId);
  }

  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitsStreamProvider).value ?? [];
    final habit = habits.firstWhere(
      (h) => h.id == widget.habitId,
      orElse: () => habits.isNotEmpty ? habits.first : throw StateError('No habits found'),
    );

    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: const Text('Urge Surf Protocol'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: _buildCurrentStep(habit),
            ),
          ),
          if (_showEmberBurst)
            Positioned.fill(
              child: EmberBurst(
                onFinished: () {},
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(dynamic habit) {
    switch (_step) {
      case 1:
        return _buildStep1StrengthAudit();
      case 2:
        return _buildStep2WhyAnchor(habit);
      case 3:
        return _buildStep3BreathingCountdown();
      case 4:
        return _buildStep4ActionOffer();
      case 5:
        return _buildStep5FinalAudit();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1StrengthAudit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'Acknowledge the Wave',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Urges are temporary neurological waves. How strong is the impulse right now?',
          style: TextStyle(fontSize: 14, color: EmberColors.textSecondary),
        ),
        const SizedBox(height: 36),

        Center(
          child: Text(
            '$_strengthBefore',
            style: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: EmberColors.primaryOrange,
            ),
          ),
        ),
        const Center(
          child: Text(
            'URGE INTENSITY (1-5)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: EmberColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 24),

        Slider(
          value: _strengthBefore.toDouble(),
          min: 1,
          max: 5,
          divisions: 4,
          activeColor: EmberColors.primaryOrange,
          inactiveColor: EmberColors.cardElevated,
          onChanged: (val) {
            HapticFeedback.selectionClick();
            setState(() => _strengthBefore = val.round());
          },
        ),

        const Spacer(),
        GlowButton(
          text: 'Next: Re-anchor Mind',
          width: double.infinity,
          onPressed: () => setState(() => _step = 2),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStep2WhyAnchor(dynamic habit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'Remember Your Why',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Urges rise, peak, and pass. You only need to wait.',
          style: TextStyle(
            fontSize: 14,
            color: EmberColors.brightOrange,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),

        EmberCard(
          padding: const EdgeInsets.all(24),
          backgroundColor: EmberColors.cardElevated,
          hasGlow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield, color: EmberColors.primaryOrange, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'MY COMMITMENT',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: EmberColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                habit.why.isNotEmpty
                    ? '"${habit.why}"'
                    : '"I deserve clarity, dignity, and self-mastery."',
                style: const TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  color: EmberColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),
        GlowButton(
          text: 'Begin 10-Minute Breath Delay',
          width: double.infinity,
          onPressed: () {
            _startTimer();
            setState(() => _step = 3);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStep3BreathingCountdown() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          _formatTime(_remainingSeconds),
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
            letterSpacing: -1,
          ),
        ),
        const Text(
          '10-MINUTE DELAY WINDOW',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: EmberColors.textSecondary,
          ),
        ),
        const Spacer(),

        // Calming Breathing Circle (4s Inhale, 4s Hold, 6s Exhale)
        const BreathingCircle(size: 260),

        const Spacer(),
        Row(
          children: [
            Expanded(
              child: GlowButton(
                text: 'Physical Reset',
                variant: GlowButtonVariant.secondary,
                onPressed: () => setState(() => _step = 4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlowButton(
                text: 'Finished Early',
                onPressed: () {
                  _countdownTimer?.cancel();
                  setState(() => _step = 5);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStep4ActionOffer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'Physical Reset Action',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Break the dopamine loop with a constructive physical interruption.',
          style: TextStyle(fontSize: 14, color: EmberColors.textSecondary),
        ),
        const SizedBox(height: 20),

        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: _quickActions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final action = _quickActions[index];
              final isSelected = _selectedQuickAction == action;

              return EmberCard(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedQuickAction = action);
                },
                backgroundColor: isSelected ? EmberColors.cardElevated : EmberColors.card,
                hasGlow: isSelected,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isSelected ? EmberColors.primaryOrange : EmberColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      action,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        GlowButton(
          text: 'Record Outcome',
          width: double.infinity,
          onPressed: () => setState(() => _step = 5),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStep5FinalAudit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'How do you feel now?',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Audit your state after the delay. Urges diminish with time.',
          style: TextStyle(fontSize: 14, color: EmberColors.textSecondary),
        ),
        const SizedBox(height: 32),

        Center(
          child: Text(
            '$_strengthAfter',
            style: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: EmberColors.brightOrange,
            ),
          ),
        ),
        const Center(
          child: Text(
            'CURRENT INTENSITY (1-5)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: EmberColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 20),

        Slider(
          value: _strengthAfter.toDouble(),
          min: 1,
          max: 5,
          divisions: 4,
          activeColor: EmberColors.primaryOrange,
          inactiveColor: EmberColors.cardElevated,
          onChanged: (val) {
            HapticFeedback.selectionClick();
            setState(() => _strengthAfter = val.round());
          },
        ),

        const Spacer(),
        GlowButton(
          text: 'I got through it (+25 XP)',
          width: double.infinity,
          onPressed: _handleSuccess,
        ),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: _handleSlipped,
            child: const Text(
              'I gave in (Log slip & learn)',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: EmberColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
