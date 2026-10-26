import 'package:flutter_test/flutter_test.dart';
import 'package:ember/core/utils/streak_calculator.dart';
import 'package:ember/core/utils/gamification_calculator.dart';

void main() {
  group('StreakCalculator Tests', () {
    test('calculateCurrentStreakDays measures accurate days from start or slip', () {
      final start = DateTime(2026, 1, 1, 10, 0);
      final day3 = DateTime(2026, 1, 4, 11, 0);
      expect(
        StreakCalculator.calculateCurrentStreakDays(startAt: start, now: day3),
        3,
      );

      // With a slip on Day 2
      final slip = DateTime(2026, 1, 3, 10, 0);
      expect(
        StreakCalculator.calculateCurrentStreakDays(
          startAt: start,
          lastSlipAt: slip,
          now: day3,
        ),
        1,
      );
    });

    test('calculateTotalCleanDays sums all finished streaks and current streak', () {
      // 5 days clean, then slip, 10 days clean, then slip, currently 4 days clean
      final past = [5, 10];
      final current = 4;
      final total = StreakCalculator.calculateTotalCleanDays(
        pastFinishedStreakDays: past,
        currentStreakDays: current,
      );
      expect(total, 19);
    });

    test('calculateBestStreakDays captures highest lifetime streak and never resets', () {
      final past = [3, 14, 7];
      final current = 8;
      expect(
        StreakCalculator.calculateBestStreakDays(
          pastFinishedStreakDays: past,
          currentStreakDays: current,
        ),
        14,
      );

      // When current exceeds past best
      expect(
        StreakCalculator.calculateBestStreakDays(
          pastFinishedStreakDays: past,
          currentStreakDays: 20,
        ),
        20,
      );
    });

    test('getMilestoneForDays identifies standard and yearly milestones', () {
      expect(StreakCalculator.getMilestoneForDays(1)?.badgeId, 'milestone_1');
      expect(StreakCalculator.getMilestoneForDays(7)?.badgeId, 'milestone_7');
      expect(StreakCalculator.getMilestoneForDays(30)?.badgeId, 'milestone_30');
      expect(StreakCalculator.getMilestoneForDays(365)?.badgeId, 'milestone_365');
      expect(StreakCalculator.getMilestoneForDays(730)?.badgeId, 'milestone_2y');
      expect(StreakCalculator.getMilestoneForDays(15), isNull);
    });
  });

  group('GamificationCalculator Tests', () {
    test('XP to level scaling matches formula 100 * (n ^ 1.5)', () {
      expect(GamificationCalculator.calculateLevel(0), 1);
      expect(GamificationCalculator.calculateLevel(50), 1);

      // Level 2 requires 100 * (2^1.5) = 283 XP
      expect(GamificationCalculator.calculateLevel(285), 2);

      // Level 5 requires 100 * (5^1.5) = 1118 XP
      expect(GamificationCalculator.calculateLevel(1120), 5);
    });

    test('Player titles match designated tiers', () {
      expect(GamificationCalculator.titleForLevel(1), 'Rookie');
      expect(GamificationCalculator.titleForLevel(4), 'Rookie');
      expect(GamificationCalculator.titleForLevel(5), 'Fighter');
      expect(GamificationCalculator.titleForLevel(9), 'Fighter');
      expect(GamificationCalculator.titleForLevel(10), 'Warrior');
      expect(GamificationCalculator.titleForLevel(19), 'Warrior');
      expect(GamificationCalculator.titleForLevel(20), 'Guardian');
      expect(GamificationCalculator.titleForLevel(29), 'Guardian');
      expect(GamificationCalculator.titleForLevel(30), 'Master');
      expect(GamificationCalculator.titleForLevel(50), 'Master');
    });

    test('Week advancing evaluates 7-day period and 4-day core completion', () {
      final weekStart = DateTime(2026, 1, 1);
      final day6 = DateTime(2026, 1, 7); // 6 days elapsed (week not ended)
      final day7 = DateTime(2026, 1, 8); // 7 days elapsed (week ended)

      // Week still in progress
      final inProgress = GamificationCalculator.evaluateWeekAdvance(
        weekStartAt: weekStart,
        now: day6,
        completedCoreDaysInWeek: 4,
      );
      expect(inProgress.weekEnded, isFalse);
      expect(inProgress.canAutoAdvance, isTrue);

      // Week ended and user completed >= 4 days
      final advanced = GamificationCalculator.evaluateWeekAdvance(
        weekStartAt: weekStart,
        now: day7,
        completedCoreDaysInWeek: 5,
      );
      expect(advanced.weekEnded, isTrue);
      expect(advanced.canAutoAdvance, isTrue);

      // Week ended but user only completed 2 days
      final missed = GamificationCalculator.evaluateWeekAdvance(
        weekStartAt: weekStart,
        now: day7,
        completedCoreDaysInWeek: 2,
      );
      expect(missed.weekEnded, isTrue);
      expect(missed.canAutoAdvance, isFalse);
    });

    test('shouldOfferEasyVersion detects 3 consecutive missed core days', () {
      expect(
        GamificationCalculator.shouldOfferEasyVersion(
          lastThreeDaysCoreCompleted: [true, false, false],
        ),
        isFalse,
      );

      expect(
        GamificationCalculator.shouldOfferEasyVersion(
          lastThreeDaysCoreCompleted: [false, false, false],
        ),
        isTrue,
      );
    });
  });
}
