import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/streak_calculator.dart';
import '../../core/utils/gamification_calculator.dart';
import '../../data/local/database/app_database.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/progress_bar_shine.dart';
import '../../widgets/stat_chip.dart';
import '../../widgets/streak_flame.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentHabitIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitsAsync = ref.watch(habitsStreamProvider);
    final userStateAsync = ref.watch(userStateStreamProvider);
    final slipsAsync = ref.watch(slipsStreamProvider);
    final checkinsAsync = ref.watch(checkinsStreamProvider);
    final reduceMotion = ref.watch(settingsProvider).reduceMotion;

    final userState = userStateAsync.value ??
        UserStateData(
          id: 'default',
          xp: 0,
          level: 1,
          currentStage: 1,
          currentWeek: 1,
          weekStartAt: DateTime(2026, 1, 1),
          shields: 1,
        );

    final progress = GamificationCalculator.levelProgress(userState.xp);
    final levelTitle = GamificationCalculator.titleForLevel(userState.level);

    return Scaffold(
      backgroundColor: EmberColors.background,
      body: SafeArea(
        child: habitsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: EmberColors.primaryOrange),
          ),
          error: (err, _) => Center(
            child: Text('Error loading habits: $err', style: const TextStyle(color: Colors.white)),
          ),
          data: (habits) {
            if (habits.isEmpty) {
              return _buildEmptyState();
            }

            final activeHabit = habits[_currentHabitIndex.clamp(0, habits.length - 1)];
            final habitSlips = slipsAsync.value
                    ?.where((s) => s.habitId == activeHabit.id && !s.shieldUsed)
                    .toList() ??
                [];
            final lastSlip = habitSlips.isEmpty ? null : habitSlips.first.at;

            final currentStreak = StreakCalculator.calculateCurrentStreakDays(
              startAt: activeHabit.startAt,
              lastSlipAt: lastSlip,
            );

            // Compute past streaks from finished segments
            final pastStreaks = <int>[];
            final totalCleanDays = StreakCalculator.calculateTotalCleanDays(
              pastFinishedStreakDays: pastStreaks,
              currentStreakDays: currentStreak,
            );
            final bestStreak = StreakCalculator.calculateBestStreakDays(
              pastFinishedStreakDays: pastStreaks,
              currentStreakDays: currentStreak,
            );

            final todayCheckinDone = checkinsAsync.value?.any((c) {
                  final now = DateTime.now();
                  return c.date.year == now.year &&
                      c.date.month == now.month &&
                      c.date.day == now.day;
                }) ??
                false;

            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: XP Bar & Level
                      _buildHeader(userState, levelTitle, progress),
                      const SizedBox(height: 20),

                      // Habits Carousel
                      _buildHabitStreakCard(
                        habits,
                        activeHabit,
                        currentStreak,
                        bestStreak,
                        totalCleanDays,
                        reduceMotion,
                      ),
                      const SizedBox(height: 24),

                      // Check-in Banner (if not done today)
                      if (!todayCheckinDone) ...[
                        _buildCheckinPrompt(),
                        const SizedBox(height: 20),
                      ],

                      // Today's Missions Preview
                      _buildTodayMissionsSection(),
                      const SizedBox(height: 24),

                      // Gentle Slip button
                      Center(
                        child: TextButton.icon(
                          onPressed: () => context.push('/slip', extra: activeHabit.id),
                          icon: const Icon(Icons.refresh, size: 16, color: EmberColors.textSecondary),
                          label: const Text(
                            'Logged a slip? Learn from it',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: EmberColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating SOS Button (red-orange breathing button)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: _buildFloatingSosButton(activeHabit.id, reduceMotion),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(
    UserStateData userState,
    String levelTitle,
    ({double progress, int currentLevelXp, int nextLevelRequiredXp}) progress,
  ) {
    return EmberCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      backgroundColor: EmberColors.card,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: EmberColors.primaryOrange.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: EmberColors.primaryOrange.withAlpha(100)),
                    ),
                    child: Text(
                      'LV ${userState.level}',
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.primaryOrange,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    levelTitle,
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.shield, size: 16, color: EmberColors.brightOrange),
                  const SizedBox(width: 4),
                  Text(
                    '${userState.shields} Shield${userState.shields == 1 ? '' : 's'}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: EmberColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${userState.xp} XP',
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: EmberColors.primaryOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ProgressBarShine(
            progress: progress.progress,
            height: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildHabitStreakCard(
    List<Habit> habits,
    Habit activeHabit,
    int currentStreak,
    int bestStreak,
    int totalCleanDays,
    bool reduceMotion,
  ) {
    return Column(
      children: [
        if (habits.length > 1) ...[
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(habits.length, (index) {
                final isSelected = index == _currentHabitIndex;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _currentHabitIndex = index);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    width: isSelected ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isSelected ? EmberColors.primaryOrange : EmberColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 6),
        ],

        EmberCard(
          hasGlow: currentStreak > 0,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          child: Column(
            children: [
              // Habit selector or name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activeHabit.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: EmberColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: EmberColors.cardElevated,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      activeHabit.goal == 'quit_fully' ? 'QUIT' : 'REDUCE',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.primaryOrange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Animated Flame Icon
              const StreakFlame(size: 85),
              const SizedBox(height: 14),

              // Large Animated Streak Number
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: currentStreak),
                duration: reduceMotion
                    ? Duration.zero
                    : const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    '$value',
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 76,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.textPrimary,
                      letterSpacing: -2,
                      height: 1.0,
                    ),
                  );
                },
              ),
              const Text(
                'DAYS CLEAN',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: EmberColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Lifetime Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatChip(
                    label: 'Best Streak',
                    value: '$bestStreak days',
                    icon: Icons.emoji_events_outlined,
                  ),
                  StatChip(
                    label: 'Total Clean',
                    value: '$totalCleanDays days',
                    icon: Icons.all_inclusive,
                    valueColor: EmberColors.success,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // "My Why" reminder
              if (activeHabit.why.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: EmberColors.cardElevated,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.format_quote, size: 16, color: EmberColors.primaryOrange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          activeHabit.why,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: EmberColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckinPrompt() {
    return EmberCard(
      onTap: () => context.push('/checkin'),
      backgroundColor: EmberColors.cardElevated,
      child: const Row(
        children: [
          Icon(Icons.bolt, color: EmberColors.primaryOrange, size: 28),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Check-in Ready',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: EmberColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '30 seconds to lock in your daily state & earn +10 XP',
                  style: TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: EmberColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildTodayMissionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Missions",
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: EmberColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/missions'),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: EmberColors.primaryOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Core Mission Quick Card
        EmberCard(
          onTap: () => context.go('/missions'),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: EmberColors.primaryOrange.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.star_rounded, color: EmberColors.primaryOrange, size: 24),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CORE MISSION',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: EmberColors.primaryOrange,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Daily Check-In & Awareness',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '+30 XP',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: EmberColors.primaryOrange,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingSosButton(String habitId, bool reduceMotion) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: EmberColors.primaryOrange.withAlpha(120),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.heavyImpact();
            context.push('/sos', extra: habitId);
          },
          backgroundColor: EmberColors.primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          highlightElevation: 0,
          icon: const Icon(Icons.crisis_alert, size: 22),
          label: const Text(
            'URGE SOS',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StreakFlame(size: 90, isLit: false),
            const SizedBox(height: 24),
            const Text(
              'No Habit Selected Yet',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: EmberColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete onboarding to light your first ember.',
              textAlign: TextAlign.center,
              style: TextStyle(color: EmberColors.textSecondary),
            ),
            const SizedBox(height: 24),
            GlowButton(
              text: 'Start Onboarding',
              onPressed: () => context.go('/onboarding'),
            ),
          ],
        ),
      ),
    );
  }
}
