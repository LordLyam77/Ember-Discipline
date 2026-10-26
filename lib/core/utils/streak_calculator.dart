import 'dart:math' as math;

class StreakMilestone {
  final int days;
  final String title;
  final String badgeId;

  const StreakMilestone({
    required this.days,
    required this.title,
    required this.badgeId,
  });
}

class StreakCalculator {
  static const List<int> standardMilestones = [
    1,
    3,
    7,
    14,
    30,
    60,
    90,
    180,
    365,
  ];

  /// Calculates the current continuous clean streak in full days.
  /// If [lastSlipAt] is null, streak is measured from [startAt].
  /// If [lastSlipAt] is present, streak is measured from [lastSlipAt].
  static int calculateCurrentStreakDays({
    required DateTime startAt,
    DateTime? lastSlipAt,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();
    final effectiveStart = lastSlipAt ?? startAt;

    if (currentTime.isBefore(effectiveStart)) {
      return 0;
    }

    final diff = currentTime.difference(effectiveStart);
    // 0 to 23 hours = day 0 (Day 1 starts after 24 hours, but for display 1st day clean is 0 or 1 depending on convention)
    // In Ember, starting today shows 0 full clean days completed, or in day 1.
    return diff.inDays;
  }

  /// Calculates the total clean days across all time.
  /// Total clean days = sum of all past finished streak days + current streak days.
  /// This number NEVER resets.
  static int calculateTotalCleanDays({
    required List<int> pastFinishedStreakDays,
    required int currentStreakDays,
  }) {
    final pastSum = pastFinishedStreakDays.fold<int>(0, (sum, days) => sum + math.max(0, days));
    return pastSum + math.max(0, currentStreakDays);
  }

  /// Calculates the all-time best streak.
  /// Never resets.
  static int calculateBestStreakDays({
    required List<int> pastFinishedStreakDays,
    required int currentStreakDays,
  }) {
    int best = math.max(0, currentStreakDays);
    for (final past in pastFinishedStreakDays) {
      if (past > best) {
        best = past;
      }
    }
    return best;
  }

  /// Returns the milestone earned if [streakDays] matches a milestone threshold.
  static StreakMilestone? getMilestoneForDays(int streakDays) {
    if (standardMilestones.contains(streakDays)) {
      return StreakMilestone(
        days: streakDays,
        title: '$streakDays-Day Flame',
        badgeId: 'milestone_$streakDays',
      );
    }

    // Every full year after 365 (e.g. 730, 1095, etc.)
    if (streakDays > 365 && streakDays % 365 == 0) {
      final years = streakDays ~/ 365;
      return StreakMilestone(
        days: streakDays,
        title: '$years-Year Sovereign',
        badgeId: 'milestone_${years}y',
      );
    }

    return null;
  }
}
