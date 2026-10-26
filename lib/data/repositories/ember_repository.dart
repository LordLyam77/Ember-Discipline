import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../local/database/app_database.dart';
import '../../core/utils/gamification_calculator.dart';

// Singletons & basic providers
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main');
});

// App settings state
class AppSettings {
  final bool hasCompletedOnboarding;
  final bool pinLockEnabled;
  final bool biometricsEnabled;
  final bool reduceMotion;
  final bool privacyBlurEnabled;
  final int autoLockSeconds;
  final String? notificationTime; // e.g. "20:00"

  const AppSettings({
    this.hasCompletedOnboarding = false,
    this.pinLockEnabled = false,
    this.biometricsEnabled = false,
    this.reduceMotion = false,
    this.privacyBlurEnabled = true,
    this.autoLockSeconds = 30,
    this.notificationTime,
  });

  AppSettings copyWith({
    bool? hasCompletedOnboarding,
    bool? pinLockEnabled,
    bool? biometricsEnabled,
    bool? reduceMotion,
    bool? privacyBlurEnabled,
    int? autoLockSeconds,
    String? notificationTime,
  }) {
    return AppSettings(
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      pinLockEnabled: pinLockEnabled ?? this.pinLockEnabled,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      reduceMotion: reduceMotion ?? this.reduceMotion,
      privacyBlurEnabled: privacyBlurEnabled ?? this.privacyBlurEnabled,
      autoLockSeconds: autoLockSeconds ?? this.autoLockSeconds,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs)
      : super(
          AppSettings(
            hasCompletedOnboarding: _prefs.getBool('onboarding_done') ?? false,
            pinLockEnabled: _prefs.getBool('pin_enabled') ?? false,
            biometricsEnabled: _prefs.getBool('biometrics_enabled') ?? false,
            reduceMotion: _prefs.getBool('reduce_motion') ?? false,
            privacyBlurEnabled: _prefs.getBool('privacy_blur') ?? true,
            autoLockSeconds: _prefs.getInt('auto_lock_seconds') ?? 30,
            notificationTime: _prefs.getString('notification_time'),
          ),
        );

  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool('onboarding_done', value);
    state = state.copyWith(hasCompletedOnboarding: value);
  }

  Future<void> setPinLockEnabled(bool value) async {
    await _prefs.setBool('pin_enabled', value);
    state = state.copyWith(pinLockEnabled: value);
  }

  Future<void> setBiometricsEnabled(bool value) async {
    await _prefs.setBool('biometrics_enabled', value);
    state = state.copyWith(biometricsEnabled: value);
  }

  Future<void> setReduceMotion(bool value) async {
    await _prefs.setBool('reduce_motion', value);
    state = state.copyWith(reduceMotion: value);
  }

  Future<void> setPrivacyBlur(bool value) async {
    await _prefs.setBool('privacy_blur', value);
    state = state.copyWith(privacyBlurEnabled: value);
  }

  Future<void> setAutoLockSeconds(int seconds) async {
    await _prefs.setInt('auto_lock_seconds', seconds);
    state = state.copyWith(autoLockSeconds: seconds);
  }

  Future<void> setNotificationTime(String? time) async {
    if (time != null) {
      await _prefs.setString('notification_time', time);
    } else {
      await _prefs.remove('notification_time');
    }
    state = state.copyWith(notificationTime: time);
  }

  Future<void> clearAllSettings() async {
    await _prefs.clear();
    state = const AppSettings();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});

// Habits Stream & Repository
final habitsStreamProvider = StreamProvider<List<Habit>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllHabits();
});

final activeHabitIdProvider = StateProvider<String?>((ref) => null);

// User State Stream & Controller
final userStateStreamProvider = StreamProvider<UserStateData?>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchUserState();
});

// All Skills Stream
final skillsStreamProvider = StreamProvider<List<Skill>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllSkills();
});

// All Badges Stream
final badgesStreamProvider = StreamProvider<List<Badge>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchEarnedBadges();
});

// Playbook Stream
final playbookStreamProvider = StreamProvider<List<PlaybookData>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchPlaybook();
});

// Check-ins Stream
final checkinsStreamProvider = StreamProvider<List<Checkin>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchCheckins();
});

// Urges Stream
final urgesStreamProvider = StreamProvider<List<Urge>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllUrges();
});

// Slips Stream
final slipsStreamProvider = StreamProvider<List<Slip>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllSlips();
});

// Mission Progress Stream
final missionProgressStreamProvider = StreamProvider<List<MissionProgressData>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchMissionProgress();
});

// Letters Stream
final lettersStreamProvider = StreamProvider<List<Letter>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchLetters();
});

// Life Wheel Stream
final lifeWheelStreamProvider = StreamProvider<List<LifeWheelData>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchLifeWheel();
});

// App Manager Service for actions
class EmberManager {
  final AppDatabase _db;
  final Ref _ref;

  EmberManager(this._db, this._ref);

  Future<void> ensureUserStateInitialized() async {
    final current = await _db.getUserState();
    if (current == null) {
      await _db.saveUserState(
        UserStateCompanion(
          id: const Value('default'),
          xp: const Value(0),
          level: const Value(1),
          currentStage: const Value(1),
          currentWeek: const Value(1),
          weekStartAt: Value(DateTime.now()),
          shields: const Value(1), // start with 1 courtesy shield
        ),
      );
    }
  }

  Future<void> addHabit({
    required String name,
    required String type,
    required String goal,
    required DateTime startAt,
    required String why,
    String? whyPhotoPath,
    List<String> dangerTimes = const [],
  }) async {
    final id = const Uuid().v4();
    await _db.insertHabit(
      HabitsCompanion(
        id: Value(id),
        name: Value(name),
        type: Value(type),
        goal: Value(goal),
        startAt: Value(startAt),
        why: Value(why),
        whyPhotoPath: Value(whyPhotoPath),
        dangerTimes: Value(dangerTimes.join(',')),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> addXp(int amount) async {
    await ensureUserStateInitialized();
    final current = await _db.getUserState();
    if (current == null) return;

    final newXp = current.xp + amount;
    final newLevel = GamificationCalculator.calculateLevel(newXp);

    await _db.saveUserState(
      current.toCompanion(true).copyWith(
            xp: Value(newXp),
            level: Value(newLevel),
          ),
    );

    // If level increased, check level badges
    if (newLevel > current.level) {
      if (newLevel >= 5) await _db.awardBadge('level_5');
      if (newLevel >= 10) await _db.awardBadge('level_10');
      if (newLevel >= 20) await _db.awardBadge('level_20');
      if (newLevel >= 30) await _db.awardBadge('level_30');
    }
  }

  Future<void> awardShield() async {
    await ensureUserStateInitialized();
    final current = await _db.getUserState();
    if (current == null) return;
    if (current.shields < GamificationCalculator.maxShields) {
      await _db.saveUserState(
        current.toCompanion(true).copyWith(
              shields: Value(current.shields + 1),
            ),
      );
    }
  }

  Future<bool> useShield() async {
    await ensureUserStateInitialized();
    final current = await _db.getUserState();
    if (current == null || current.shields <= 0) return false;

    await _db.saveUserState(
      current.toCompanion(true).copyWith(
            shields: Value(current.shields - 1),
          ),
    );
    return true;
  }

  Future<void> recordSlip({
    required String habitId,
    required String trigger,
    required String? note,
    required String? changePlan,
    required bool shieldUsed,
  }) async {
    final now = DateTime.now();
    final slipId = const Uuid().v4();

    await _db.insertSlip(
      SlipsCompanion(
        id: Value(slipId),
        habitId: Value(habitId),
        at: Value(now),
        trigger: Value(trigger),
        note: Value(note),
        changePlan: Value(changePlan),
        shieldUsed: Value(shieldUsed),
      ),
    );

    if (shieldUsed) {
      await useShield();
      // Shield used: Streak is preserved!
    } else {
      // End previous streak segment and record in streak events
      final habit = await _db.getHabitById(habitId);
      if (habit != null) {
        // Calculate segment start
        final allSlips = await _db.getAllSlips();
        final habitSlips = allSlips.where((s) => s.habitId == habitId && !s.shieldUsed && s.at.isBefore(now)).toList();
        final segmentStart = habitSlips.isEmpty ? habit.startAt : habitSlips.first.at;

        await _db.insertStreakEvent(
          StreakEventsCompanion(
            id: Value(const Uuid().v4()),
            habitId: Value(habitId),
            startAt: Value(segmentStart),
            endAt: Value(now),
            endReason: const Value('slip'),
          ),
        );
      }
      // Restart badge: "First comeback"
      await _db.awardBadge('first_comeback');
    }
  }

  Future<void> recordUrgeSurvived({
    required String habitId,
    required int strengthBefore,
    required int strengthAfter,
    required String? triggerTag,
    required bool usedSos,
  }) async {
    final urgeId = const Uuid().v4();
    await _db.insertUrge(
      UrgesCompanion(
        id: Value(urgeId),
        habitId: Value(habitId),
        at: Value(DateTime.now()),
        strengthBefore: Value(strengthBefore),
        strengthAfter: Value(strengthAfter),
        triggerTag: Value(triggerTag),
        usedSos: Value(usedSos),
        outcome: const Value('survived'),
      ),
    );

    // Award +25 XP
    await addXp(GamificationCalculator.xpUrgeSurvived);
    await _db.addSkillPoints('urge_surfing', 15);

    // Check badges
    final allUrges = await _db.getAllUrges();
    final survived = allUrges.where((u) => u.outcome == 'survived').length;
    if (survived >= 1) {
      await _db.awardBadge('first_urge_survived');
    }
    if (survived >= 10) {
      await _db.awardBadge('10_urges_survived');
    }
  }

  Future<void> recordCheckin({
    required int mood,
    required int stress,
    required double sleepHours,
    required int urgeLevel,
    required String? note,
  }) async {
    final checkinId = const Uuid().v4();
    await _db.insertCheckin(
      CheckinsCompanion(
        id: Value(checkinId),
        date: Value(DateTime.now()),
        mood: Value(mood),
        stress: Value(stress),
        sleepHours: Value(sleepHours),
        urgeLevel: Value(urgeLevel),
        note: Value(note),
      ),
    );

    await addXp(GamificationCalculator.xpCheckIn);
    await _db.addSkillPoints('awareness', 10);
  }

  Future<void> completeMission({
    required String missionId,
    required int xp,
    required String skillId,
    required String tier,
  }) async {
    final progressId = const Uuid().v4();
    await _db.setMissionStatus(
      MissionProgressCompanion(
        id: Value(progressId),
        missionId: Value(missionId),
        date: Value(DateTime.now()),
        status: const Value('completed'),
        xpAwarded: Value(xp),
      ),
    );

    await addXp(xp);
    await _db.addSkillPoints(skillId, xp ~/ 2);

    if (tier == 'weekly') {
      await awardShield();
      await _db.awardBadge('week_completed');
    } else if (tier == 'boss') {
      await _db.awardBadge('stage_1_boss');
    }
  }

  Future<void> wipeEverything() async {
    await _db.wipeAllData();
    await _ref.read(settingsProvider.notifier).clearAllSettings();
  }
}

final emberManagerProvider = Provider<EmberManager>((ref) {
  final db = ref.watch(databaseProvider);
  return EmberManager(db, ref);
});
