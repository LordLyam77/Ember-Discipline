import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/mission.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_burst.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/glow_button.dart';

class MissionsScreen extends ConsumerStatefulWidget {
  const MissionsScreen({super.key});

  @override
  ConsumerState<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends ConsumerState<MissionsScreen> {
  List<Mission> _stageMissions = [];
  bool _isLoading = true;
  bool _showBurst = false;

  @override
  void initState() {
    super.initState();
    _loadMissions();
  }

  Future<void> _loadMissions() async {
    final missions = await Mission.loadStageMissions(1);
    if (mounted) {
      setState(() {
        _stageMissions = missions;
        _isLoading = false;
      });
    }
  }

  Future<void> _completeMission(Mission mission) async {
    HapticFeedback.lightImpact();
    setState(() => _showBurst = true);

    final manager = ref.read(emberManagerProvider);
    await manager.completeMission(
      missionId: mission.id,
      xp: mission.xp,
      skillId: mission.skillId,
      tier: mission.tier,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🔥 Mission Complete! +${mission.xp} XP & Skill Points!'),
          backgroundColor: EmberColors.cardElevated,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateStreamProvider).value;
    final progressList = ref.watch(missionProgressStreamProvider).value ?? [];
    final currentWeek = userState?.currentWeek ?? 1;

    final weekMissions = _stageMissions.where((m) => m.week == currentWeek).toList();
    final coreMission = weekMissions.where((m) => m.tier == 'core').firstOrNull;
    final growthMissions = weekMissions.where((m) => m.tier == 'growth').toList();
    final bonusMission = weekMissions.where((m) => m.tier == 'bonus').firstOrNull;
    final weeklyChallenge = weekMissions.where((m) => m.tier == 'weekly').firstOrNull;
    final bossMission = weekMissions.where((m) => m.tier == 'boss').firstOrNull;

    final completedMissionIds = progressList
        .where((p) => p.status == 'completed')
        .map((p) => p.missionId)
        .toSet();

    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: Text('Week $currentWeek Missions'),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: EmberColors.cardElevated,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: EmberColors.border),
            ),
            child: Text(
              'Stage 1',
              style: const TextStyle(
                fontFamily: 'Sora',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: EmberColors.primaryOrange,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: EmberColors.primaryOrange))
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weekly Focus Banner
                      EmberCard(
                        backgroundColor: EmberColors.cardElevated,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.explore_outlined, color: EmberColors.primaryOrange, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Week $currentWeek Focus',
                                    style: const TextStyle(
                                      fontFamily: 'Sora',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: EmberColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'Complete Core on ≥4 days to advance your journey.',
                                    style: TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 1. CORE MISSION (Same all week)
                      if (coreMission != null) ...[
                        _buildSectionHeader('DAILY CORE MISSION', 'Anchor habit for this week'),
                        const SizedBox(height: 10),
                        _buildMissionCard(
                          mission: coreMission,
                          isCompleted: completedMissionIds.contains(coreMission.id),
                          badgeColor: EmberColors.primaryOrange,
                          badgeText: 'CORE',
                        ),
                        const SizedBox(height: 24),
                      ],

                      // 2. GROWTH MISSIONS (Pick 1 per day)
                      if (growthMissions.isNotEmpty) ...[
                        _buildSectionHeader('GROWTH MISSIONS', 'Choose one challenge to practice today'),
                        const SizedBox(height: 10),
                        ...growthMissions.map(
                          (m) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildMissionCard(
                              mission: m,
                              isCompleted: completedMissionIds.contains(m.id),
                              badgeColor: EmberColors.brightOrange,
                              badgeText: 'GROWTH',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // 3. BONUS MISSION
                      if (bonusMission != null) ...[
                        _buildSectionHeader('BONUS MISSION', 'Quick extra discipline win'),
                        const SizedBox(height: 10),
                        _buildMissionCard(
                          mission: bonusMission,
                          isCompleted: completedMissionIds.contains(bonusMission.id),
                          badgeColor: const Color(0xFFFFD166),
                          badgeText: 'BONUS',
                        ),
                        const SizedBox(height: 24),
                      ],

                      // 4. WEEKLY CHALLENGE
                      if (weeklyChallenge != null) ...[
                        _buildSectionHeader('WEEKLY CHALLENGE', 'Earns a Streak Shield & 100 XP'),
                        const SizedBox(height: 10),
                        _buildMissionCard(
                          mission: weeklyChallenge,
                          isCompleted: completedMissionIds.contains(weeklyChallenge.id),
                          badgeColor: EmberColors.success,
                          badgeText: 'SHIELD REWARD',
                          isWeekly: true,
                        ),
                        const SizedBox(height: 24),
                      ],

                      // 5. STAGE BOSS (Week 8)
                      if (bossMission != null) ...[
                        _buildSectionHeader('STAGE 1 BOSS BATTLE', 'Defeat the Gauntlet to unlock Stage 1 Master Badge'),
                        const SizedBox(height: 10),
                        _buildMissionCard(
                          mission: bossMission,
                          isCompleted: completedMissionIds.contains(bossMission.id),
                          badgeColor: EmberColors.slipWarning,
                          badgeText: 'BOSS BATTLE',
                          isBoss: true,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
                if (_showBurst)
                  Positioned.fill(
                    child: EmberBurst(
                      onFinished: () => setState(() => _showBurst = false),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: EmberColors.primaryOrange,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: EmberColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard({
    required Mission mission,
    required bool isCompleted,
    required Color badgeColor,
    required String badgeText,
    bool isWeekly = false,
    bool isBoss = false,
  }) {
    return EmberCard(
      backgroundColor: isBoss
          ? EmberColors.cardElevated
          : (isCompleted ? EmberColors.card.withAlpha(140) : EmberColors.card),
      hasGlow: isBoss || (isWeekly && !isCompleted),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                  ),
                ),
              ),
              Row(
                children: [
                  if (mission.durationMin > 0) ...[
                    Icon(Icons.schedule, size: 14, color: EmberColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${mission.durationMin}m',
                      style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    '+${mission.xp} XP',
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.primaryOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            mission.title,
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCompleted ? EmberColors.textSecondary : EmberColors.textPrimary,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            mission.description,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: EmberColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),

          // Completion or Action button
          if (isCompleted)
            const Row(
              children: [
                Icon(Icons.check_circle, size: 18, color: EmberColors.success),
                SizedBox(width: 6),
                Text(
                  'Completed for today',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: EmberColors.success,
                  ),
                ),
              ],
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: GlowButton(
                text: isBoss ? 'Engage Boss' : 'Complete',
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                variant: isBoss ? GlowButtonVariant.primary : GlowButtonVariant.secondary,
                onPressed: () => _completeMission(mission),
              ),
            ),
        ],
      ),
    );
  }
}
