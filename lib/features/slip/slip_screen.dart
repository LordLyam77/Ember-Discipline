import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/glow_button.dart';

class SlipScreen extends ConsumerStatefulWidget {
  final String habitId;

  const SlipScreen({super.key, required this.habitId});

  @override
  ConsumerState<SlipScreen> createState() => _SlipScreenState();
}

class _SlipScreenState extends ConsumerState<SlipScreen> {
  final List<String> _commonTriggers = [
    'Stress / Anxiety',
    'Boredom / Aimless',
    'Loneliness / Isolation',
    'Exhaustion / Poor Sleep',
    'Social Pressure',
    'Late Night Scrolling',
    'Emotional Numbing',
  ];
  String? _selectedTrigger;
  final TextEditingController _customTriggerController = TextEditingController();
  final TextEditingController _beforeController = TextEditingController();
  final TextEditingController _changePlanController = TextEditingController();

  bool _useShieldIfAvailable = true;

  @override
  void dispose() {
    _customTriggerController.dispose();
    _beforeController.dispose();
    _changePlanController.dispose();
    super.dispose();
  }

  Future<void> _submitSlip() async {
    final trigger = _customTriggerController.text.trim().isNotEmpty
        ? _customTriggerController.text.trim()
        : (_selectedTrigger ?? 'Unspecified Trigger');

    final manager = ref.read(emberManagerProvider);
    final userState = await ref.read(databaseProvider).getUserState();
    final hasShield = (userState?.shields ?? 0) > 0;
    final shieldUsed = hasShield && _useShieldIfAvailable;

    await manager.recordSlip(
      habitId: widget.habitId,
      trigger: trigger,
      note: _beforeController.text.trim().isEmpty ? null : _beforeController.text.trim(),
      changePlan: _changePlanController.text.trim().isEmpty ? null : _changePlanController.text.trim(),
      shieldUsed: shieldUsed,
    );

    HapticFeedback.mediumImpact();

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            shieldUsed ? '🛡️ Streak Shield Activated!' : '🌱 Clean Slate, Forward Motion',
            style: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: EmberColors.textPrimary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shieldUsed
                    ? 'Your shield absorbed the hit. Your streak continues uninterrupted, and this slip has been logged as insight.'
                    : 'Your lifetime clean days and XP remain completely safe. You have not failed; you have gathered data.',
                style: const TextStyle(fontSize: 14, color: EmberColors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: EmberColors.cardElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: EmberColors.border),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOMORROW\'S COMEBACK MISSION',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.primaryOrange,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hydrate, get 10 minutes of morning sunlight, and read your "Why" anchor aloud.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            GlowButton(
              text: 'Return to Home',
              onPressed: () {
                Navigator.of(ctx).pop();
                context.go('/home');
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateStreamProvider).value;
    final availableShields = userState?.shields ?? 0;

    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: const Text('Log a Slip'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gentle Non-Shaming Banner
              EmberCard(
                backgroundColor: EmberColors.cardElevated,
                padding: const EdgeInsets.all(18),
                child: const Row(
                  children: [
                    Icon(Icons.spa_outlined, color: EmberColors.primaryOrange, size: 28),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'It happens. Let\'s learn from it.',
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: EmberColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'A slip does not erase your neurological progress. Your total clean days and XP are permanent.',
                            style: TextStyle(fontSize: 12, color: EmberColors.textSecondary, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Shield Offer if available
              if (availableShields > 0) ...[
                EmberCard(
                  backgroundColor: EmberColors.primaryOrange.withAlpha(20),
                  customBorder: Border.all(color: EmberColors.primaryOrange.withAlpha(100)),
                  child: SwitchListTile(
                    title: const Text(
                      'Use Streak Shield',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'You have $availableShields shield(s). Using one preserves your current streak number.',
                      style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                    ),
                    value: _useShieldIfAvailable,
                    activeTrackColor: EmberColors.primaryOrange,
                    onChanged: (val) => setState(() => _useShieldIfAvailable = val),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Trigger Question
              const Text(
                'What was the primary trigger?',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _commonTriggers.map((trigger) {
                  final isSelected = _selectedTrigger == trigger;
                  return FilterChip(
                    label: Text(trigger),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedTrigger = selected ? trigger : null);
                    },
                    backgroundColor: EmberColors.cardElevated,
                    selectedColor: EmberColors.primaryOrange.withAlpha(45),
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
              const SizedBox(height: 12),

              TextField(
                controller: _customTriggerController,
                decoration: InputDecoration(
                  hintText: 'Or specify custom trigger...',
                  hintStyle: const TextStyle(color: EmberColors.textTertiary, fontSize: 13),
                  filled: true,
                  fillColor: EmberColors.cardElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EmberColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EmberColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // What happened before?
              const Text(
                'What happened right before?',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _beforeController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'e.g. Scrolled on bed late at night while feeling lonely.',
                  hintStyle: const TextStyle(color: EmberColors.textTertiary, fontSize: 13),
                  filled: true,
                  fillColor: EmberColors.cardElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EmberColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EmberColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // What will you change?
              const Text(
                'What will you change next time?',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _changePlanController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'e.g. Charge phone in the living room after 10 PM.',
                  hintStyle: const TextStyle(color: EmberColors.textTertiary, fontSize: 13),
                  filled: true,
                  fillColor: EmberColors.cardElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EmberColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EmberColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              GlowButton(
                text: 'Save Insight & Reset Mind',
                width: double.infinity,
                onPressed: _submitSlip,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
