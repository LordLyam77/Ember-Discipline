import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/gamification_calculator.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_card.dart';

class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateStreamProvider).value;
    final skillsAsync = ref.watch(skillsStreamProvider);
    final currentWeek = userState?.currentWeek ?? 1;

    final skillsMap = <String, int>{};
    for (final s in skillsAsync.value ?? []) {
      skillsMap[s.skillId] = s.points;
    }

    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: const Text('The 12-Month Journey'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stage 1 Header
            _buildStageHeader(
              stageNum: 1,
              title: 'Stage 1: The Awakening (Weeks 1-8)',
              subtitle: 'Mindfulness, sleep hygiene, urge surfing, and recognizing triggers.',
              isActive: true,
            ),
            const SizedBox(height: 16),

            // Week Timeline Nodes for Stage 1
            _buildWeekTimeline(currentWeek),
            const SizedBox(height: 32),

            // Skill Tree Section
            _buildSkillTree(skillsMap),
            const SizedBox(height: 32),

            // Upcoming Stages
            _buildFutureStageCard(
              stageNum: 2,
              title: 'Stage 2: The Foundation (Weeks 9-16)',
              description: 'Deep dopamine reset, emotional endurance, and identity rewiring.',
            ),
            const SizedBox(height: 14),
            _buildFutureStageCard(
              stageNum: 3,
              title: 'Stage 3: The Sovereign (Weeks 17-26)',
              description: 'Stress inoculation, deep social connection, and purposeful creation.',
            ),
            const SizedBox(height: 14),
            _buildFutureStageCard(
              stageNum: 4,
              title: 'Stage 4: The Master (Weeks 27-52)',
              description: 'Lifelong autonomy, mentorship, and complete subconscious alignment.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageHeader({
    required int stageNum,
    required String title,
    required String subtitle,
    required bool isActive,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: EmberColors.primaryOrange.withAlpha(40),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: EmberColors.primaryOrange.withAlpha(120)),
              ),
              child: const Text(
                'ACTIVE STAGE',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.primaryOrange,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            color: EmberColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildWeekTimeline(int currentWeek) {
    final weekTitles = [
      'Week 1: Awareness',
      'Week 2: Sleep & Mornings',
      'Week 3: Urge Surfing',
      'Week 4: Move Your Body',
      'Week 5: Know Your Triggers',
      'Week 6: Fill the Gaps',
      'Week 7: Calm the Mind',
      'Week 8: Connect & Boss Battle',
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        final weekNum = index + 1;
        final isCurrent = weekNum == currentWeek;
        final isPast = weekNum < currentWeek;
        final isBoss = weekNum == 8;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vertical Path Line with Node Indicator
              Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCurrent
                          ? EmberColors.primaryOrange
                          : (isPast ? EmberColors.cardElevated : EmberColors.card),
                      border: Border.all(
                        color: isCurrent
                            ? EmberColors.brightOrange
                            : (isPast ? EmberColors.primaryOrange.withAlpha(120) : EmberColors.border),
                        width: isCurrent ? 2 : 1,
                      ),
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: EmberColors.primaryOrange.withAlpha(100),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: isPast
                          ? const Icon(Icons.check, size: 16, color: EmberColors.primaryOrange)
                          : isBoss
                              ? const Icon(Icons.shield, size: 16, color: Colors.white)
                              : Text(
                                  '$weekNum',
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isCurrent ? Colors.white : EmberColors.textSecondary,
                                  ),
                                ),
                    ),
                  ),
                  if (index < 7)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: isPast ? EmberColors.primaryOrange.withAlpha(120) : EmberColors.border,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Week Card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: EmberCard(
                    backgroundColor: isCurrent ? EmberColors.cardElevated : EmberColors.card,
                    hasGlow: isCurrent,
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weekTitles[index],
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 14,
                                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                                color: isCurrent ? EmberColors.textPrimary : EmberColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isBoss ? 'Gauntlet Challenge' : (isCurrent ? 'Current Focus' : (isPast ? 'Mastered' : 'Locked')),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11,
                                color: isCurrent ? EmberColors.primaryOrange : EmberColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                        if (isCurrent)
                          const Icon(Icons.arrow_forward_ios, size: 14, color: EmberColors.primaryOrange),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillTree(Map<String, int> skillsMap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Discipline Skill Tree',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each mission strengthens specific neurological muscle groups.',
          style: TextStyle(fontSize: 13, color: EmberColors.textSecondary),
        ),
        const SizedBox(height: 14),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: GamificationCalculator.skillNames.length,
          itemBuilder: (context, index) {
            final key = GamificationCalculator.skillNames.keys.elementAt(index);
            final name = GamificationCalculator.skillNames[key]!;
            final points = skillsMap[key] ?? 0;
            final level = GamificationCalculator.calculateSkillLevel(points);
            final isUnlocked = points > 0;

            return EmberCard(
              backgroundColor: isUnlocked ? EmberColors.cardElevated : EmberColors.card,
              hasGlow: isUnlocked,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getSkillIcon(key),
                    color: isUnlocked ? EmberColors.primaryOrange : EmberColors.textTertiary,
                    size: 24,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
                      color: isUnlocked ? EmberColors.textPrimary : EmberColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Lv $level ($points pt)',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 9,
                      color: isUnlocked ? EmberColors.brightOrange : EmberColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  IconData _getSkillIcon(String key) {
    switch (key) {
      case 'awareness':
        return Icons.visibility;
      case 'sleep':
        return Icons.bedtime;
      case 'urge_surfing':
        return Icons.surfing;
      case 'energy':
        return Icons.fitness_center;
      case 'trigger_control':
        return Icons.radar;
      case 'replacement':
        return Icons.swap_horiz;
      case 'stress':
        return Icons.self_improvement;
      case 'connection':
        return Icons.people;
      case 'identity':
        return Icons.fingerprint;
      default:
        return Icons.star;
    }
  }

  Widget _buildFutureStageCard({
    required int stageNum,
    required String title,
    required String description,
  }) {
    return EmberCard(
      backgroundColor: EmberColors.card.withAlpha(120),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: EmberColors.textTertiary, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textSecondary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: EmberColors.cardElevated,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'COMING SOON',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: EmberColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: EmberColors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
