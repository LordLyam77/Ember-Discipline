import 'dart:math' as math;

class GamificationCalculator {
  // XP Rewards
  static const int xpCore = 30;
  static const int xpGrowth = 20;
  static const int xpBonus = 10;
  static const int xpWeeklyChallenge = 100;
  static const int xpUrgeSurvived = 25;
  static const int xpStageBoss = 300;
  static const int xpCheckIn = 10;

  // Maximum shields held at one time
  static const int maxShields = 2;

  /// Required total cumulative XP to attain [level].
  /// Formula: 100 * (n ^ 1.5).
  static int requiredTotalXpForLevel(int level) {
    if (level <= 1) return 0;
    return (100 * math.pow(level, 1.5)).round();
  }

  /// Calculates the player level from [totalXp].
  static int calculateLevel(int totalXp) {
    if (totalXp <= 0) return 1;
    int level = 1;
    while (totalXp >= requiredTotalXpForLevel(level + 1)) {
      level++;
    }
    return level;
  }

  /// Calculates progress within the current level (0.0 to 1.0) and points needed for next level.
  static ({double progress, int currentLevelXp, int nextLevelRequiredXp}) levelProgress(int totalXp) {
    final currentLevel = calculateLevel(totalXp);
    final baseForCurrent = requiredTotalXpForLevel(currentLevel);
    final baseForNext = requiredTotalXpForLevel(currentLevel + 1);

    final span = baseForNext - baseForCurrent;
    if (span <= 0) return (progress: 1.0, currentLevelXp: 0, nextLevelRequiredXp: 0);

    final earnedInLevel = (totalXp - baseForCurrent).clamp(0, span);
    final progress = (earnedInLevel / span).clamp(0.0, 1.0);

    return (
      progress: progress,
      currentLevelXp: earnedInLevel,
      nextLevelRequiredXp: span,
    );
  }

  /// Returns the title corresponding to [level].
  /// Lv1–4 Rookie, 5–9 Fighter, 10–19 Warrior, 20–29 Guardian, 30+ Master.
  static String titleForLevel(int level) {
    if (level < 5) return 'Rookie';
    if (level < 10) return 'Fighter';
    if (level < 20) return 'Warrior';
    if (level < 30) return 'Guardian';
    return 'Master';
  }

  /// Skill display metadata
  static const Map<String, String> skillNames = {
    'awareness': 'Self-Awareness',
    'sleep': 'Sleep Control',
    'urge_surfing': 'Urge Surfing',
    'energy': 'Energy',
    'trigger_control': 'Trigger Control',
    'replacement': 'Replacement Habits',
    'stress': 'Stress Handling',
    'connection': 'Connection',
    'identity': 'Identity',
  };

  /// Calculates skill level from skill points (e.g. 50 points per skill level)
  static int calculateSkillLevel(int points) {
    return math.max(1, (points / 50).floor() + 1);
  }

  /// Evaluates week advancement:
  /// - A week lasts 7 days from [weekStartAt].
  /// - User must have completed Core on >= 4 days to auto-advance.
  static ({bool weekEnded, bool canAutoAdvance, int completedCoreDays}) evaluateWeekAdvance({
    required DateTime weekStartAt,
    required DateTime now,
    required int completedCoreDaysInWeek,
  }) {
    final daysElapsed = now.difference(weekStartAt).inDays;
    final weekEnded = daysElapsed >= 7;
    final canAutoAdvance = completedCoreDaysInWeek >= 4;

    return (
      weekEnded: weekEnded,
      canAutoAdvance: canAutoAdvance,
      completedCoreDays: completedCoreDaysInWeek,
    );
  }

  /// Determines if user missed Core mission 3 days in a row to offer easier version.
  static bool shouldOfferEasyVersion({
    required List<bool> lastThreeDaysCoreCompleted,
  }) {
    if (lastThreeDaysCoreCompleted.length < 3) return false;
    final last3 = lastThreeDaysCoreCompleted.sublist(lastThreeDaysCoreCompleted.length - 3);
    // All 3 were not completed (false)
    return last3.every((completed) => !completed);
  }
}
