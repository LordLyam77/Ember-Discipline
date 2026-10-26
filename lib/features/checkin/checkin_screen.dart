import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/glow_button.dart';

class CheckinScreen extends ConsumerStatefulWidget {
  const CheckinScreen({super.key});

  @override
  ConsumerState<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends ConsumerState<CheckinScreen> {
  int _mood = 3; // 1-5
  int _stress = 2; // 1-5
  double _sleepHours = 7.5;
  int _urgeLevel = 1; // 1-5
  final TextEditingController _noteController = TextEditingController();
  bool _detectedCrisisKeywords = false;

  final List<String> _crisisKeywords = [
    'kill myself',
    'suicide',
    'end my life',
    'want to die',
    'self harm',
    'cut myself',
    'no reason to live',
  ];

  @override
  void initState() {
    super.initState();
    _noteController.addListener(_checkForCrisisContent);
  }

  @override
  void dispose() {
    _noteController.removeListener(_checkForCrisisContent);
    _noteController.dispose();
    super.dispose();
  }

  void _checkForCrisisContent() {
    final text = _noteController.text.toLowerCase();
    final hasCrisis = _crisisKeywords.any((kw) => text.contains(kw));
    if (hasCrisis != _detectedCrisisKeywords) {
      setState(() => _detectedCrisisKeywords = hasCrisis);
    }
  }

  Future<void> _submitCheckin() async {
    final manager = ref.read(emberManagerProvider);
    await manager.recordCheckin(
      mood: _mood,
      stress: _stress,
      sleepHours: _sleepHours,
      urgeLevel: _urgeLevel,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    HapticFeedback.lightImpact();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✨ Check-in logged! +10 XP awarded.'),
          backgroundColor: EmberColors.cardElevated,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: const Text('Daily Check-in (30s)'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Crisis Support Card if keyword detected
              if (_detectedCrisisKeywords) ...[
                EmberCard(
                  backgroundColor: EmberColors.cardElevated,
                  customBorder: Border.all(color: EmberColors.primaryOrange),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.support_agent, color: EmberColors.primaryOrange, size: 24),
                          SizedBox(width: 10),
                          Text(
                            'Support is Here for You',
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: EmberColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You are going through a heavy moment, but you do not have to carry it alone. Professional, free, and confidential help is available 24/7.',
                        style: TextStyle(fontSize: 13, color: EmberColors.textSecondary, height: 1.4),
                      ),
                      const SizedBox(height: 12),
                      GlowButton(
                        text: 'Open Get Help Directory',
                        height: 42,
                        onPressed: () => context.push('/help'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // 1. Mood
              _buildRatingSection(
                title: 'Overall Mood',
                subtitle: 'How is your emotional temperature today?',
                value: _mood,
                labels: ['Low', 'Struggling', 'Neutral', 'Good', 'Radiant'],
                onChanged: (val) => setState(() => _mood = val),
              ),
              const SizedBox(height: 24),

              // 2. Stress
              _buildRatingSection(
                title: 'Stress Level',
                subtitle: 'How much tension or cognitive overload do you feel?',
                value: _stress,
                labels: ['Calm', 'Mild', 'Moderate', 'High', 'Severe'],
                onChanged: (val) => setState(() => _stress = val),
              ),
              const SizedBox(height: 24),

              // 3. Sleep
              const Text(
                'Sleep Duration',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hours of restorative sleep', style: TextStyle(color: EmberColors.textSecondary, fontSize: 13)),
                  Text(
                    '${_sleepHours.toStringAsFixed(1)} hrs',
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.primaryOrange,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _sleepHours,
                min: 3.0,
                max: 12.0,
                divisions: 18,
                activeColor: EmberColors.primaryOrange,
                inactiveColor: EmberColors.cardElevated,
                onChanged: (val) => setState(() => _sleepHours = val),
              ),
              const SizedBox(height: 24),

              // 4. Urge Intensity
              _buildRatingSection(
                title: 'Urge Intensity Today',
                subtitle: 'How strong were cravings or temptations today?',
                value: _urgeLevel,
                labels: ['None', 'Mild', 'Manageable', 'Intense', 'Extreme'],
                onChanged: (val) => setState(() => _urgeLevel = val),
              ),
              const SizedBox(height: 24),

              // 5. Notes
              const Text(
                'Reflections or Notes (Optional)',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'One win, one trigger, or how your mind feels...',
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
                text: 'Save Check-in (+10 XP)',
                width: double.infinity,
                onPressed: _submitCheckin,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSection({
    required String title,
    required String subtitle,
    required int value,
    required List<String> labels,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: EmberColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            final rating = index + 1;
            final isSelected = rating == value;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < 4 ? 8 : 0),
                child: EmberCard(
                  onTap: () => onChanged(rating),
                  backgroundColor: isSelected ? EmberColors.cardElevated : EmberColors.card,
                  hasGlow: isSelected,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Text(
                        '$rating',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? EmberColors.primaryOrange : EmberColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        labels[index],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? EmberColors.textPrimary : EmberColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
