import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Habits,
  StreakEvents,
  Urges,
  Slips,
  Checkins,
  MissionProgress,
  UserState,
  Skills,
  Badges,
  Playbook,
  Letters,
  LifeWheel,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'ember_discipline.db',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HABITS QUERIES
  // ---------------------------------------------------------------------------
  Future<List<Habit>> getAllHabits() => select(habits).get();
  Stream<List<Habit>> watchAllHabits() => select(habits).watch();
  Future<Habit?> getHabitById(String id) =>
      (select(habits)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  Future<int> insertHabit(HabitsCompanion habit) => into(habits).insert(habit);
  Future<bool> updateHabit(Habit habit) => update(habits).replace(habit);
  Future<int> deleteHabit(String id) =>
      (delete(habits)..where((tbl) => tbl.id.equals(id))).go();

  // ---------------------------------------------------------------------------
  // STREAK EVENTS QUERIES
  // ---------------------------------------------------------------------------
  Future<List<StreakEvent>> getEventsForHabit(String habitId) =>
      (select(streakEvents)..where((tbl) => tbl.habitId.equals(habitId))).get();
  Future<int> insertStreakEvent(StreakEventsCompanion event) =>
      into(streakEvents).insert(event);

  // ---------------------------------------------------------------------------
  // URGES & SLIPS QUERIES
  // ---------------------------------------------------------------------------
  Stream<List<Urge>> watchAllUrges() =>
      (select(urges)..orderBy([(t) => OrderingTerm.desc(t.at)])).watch();
  Future<List<Urge>> getAllUrges() =>
      (select(urges)..orderBy([(t) => OrderingTerm.desc(t.at)])).get();
  Future<int> insertUrge(UrgesCompanion urge) => into(urges).insert(urge);

  Stream<List<Slip>> watchAllSlips() =>
      (select(slips)..orderBy([(t) => OrderingTerm.desc(t.at)])).watch();
  Future<List<Slip>> getAllSlips() =>
      (select(slips)..orderBy([(t) => OrderingTerm.desc(t.at)])).get();
  Future<int> insertSlip(SlipsCompanion slip) => into(slips).insert(slip);

  // ---------------------------------------------------------------------------
  // CHECK-INS QUERIES
  // ---------------------------------------------------------------------------
  Stream<List<Checkin>> watchCheckins() =>
      (select(checkins)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
  Future<List<Checkin>> getAllCheckins() =>
      (select(checkins)..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
  Future<Checkin?> getTodayCheckin(DateTime today) {
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);
    return (select(checkins)
          ..where((t) => t.date.isBiggerOrEqualValue(startOfDay) & t.date.isSmallerOrEqualValue(endOfDay)))
        .getSingleOrNull();
  }
  Future<int> insertCheckin(CheckinsCompanion checkin) =>
      into(checkins).insert(checkin);

  // ---------------------------------------------------------------------------
  // MISSION PROGRESS QUERIES
  // ---------------------------------------------------------------------------
  Stream<List<MissionProgressData>> watchMissionProgress() =>
      select(missionProgress).watch();
  Future<List<MissionProgressData>> getProgressForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return (select(missionProgress)
          ..where((t) => t.date.isBiggerOrEqualValue(startOfDay) & t.date.isSmallerOrEqualValue(endOfDay)))
        .get();
  }
  Future<int> setMissionStatus(MissionProgressCompanion progress) =>
      into(missionProgress).insertOnConflictUpdate(progress);

  // ---------------------------------------------------------------------------
  // USER STATE & GAMIFICATION QUERIES
  // ---------------------------------------------------------------------------
  Future<UserStateData?> getUserState() =>
      (select(userState)..where((t) => t.id.equals('default'))).getSingleOrNull();
  Stream<UserStateData?> watchUserState() =>
      (select(userState)..where((t) => t.id.equals('default'))).watchSingleOrNull();
  Future<int> saveUserState(UserStateCompanion state) =>
      into(userState).insertOnConflictUpdate(state);

  // SKILLS
  Stream<List<Skill>> watchAllSkills() => select(skills).watch();
  Future<List<Skill>> getAllSkills() => select(skills).get();
  Future<int> addSkillPoints(String skillId, int pointsToAdd) async {
    final existing = await (select(skills)..where((t) => t.skillId.equals(skillId))).getSingleOrNull();
    final newPoints = (existing?.points ?? 0) + pointsToAdd;
    return into(skills).insertOnConflictUpdate(
      SkillsCompanion(
        skillId: Value(skillId),
        points: Value(newPoints),
      ),
    );
  }

  // BADGES
  Stream<List<Badge>> watchEarnedBadges() => select(badges).watch();
  Future<List<Badge>> getEarnedBadges() => select(badges).get();
  Future<int> awardBadge(String badgeId) =>
      into(badges).insertOnConflictUpdate(
        BadgesCompanion(
          badgeId: Value(badgeId),
          earnedAt: Value(DateTime.now()),
        ),
      );

  // PLAYBOOK
  Stream<List<PlaybookData>> watchPlaybook() => select(playbook).watch();
  Future<List<PlaybookData>> getAllPlaybook() => select(playbook).get();
  Future<int> insertPlaybook(PlaybookCompanion item) => into(playbook).insert(item);
  Future<int> deletePlaybook(String id) =>
      (delete(playbook)..where((t) => t.id.equals(id))).go();

  // LETTERS
  Stream<List<Letter>> watchLetters() =>
      (select(letters)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  Future<int> insertLetter(LettersCompanion letter) => into(letters).insert(letter);

  // LIFE WHEEL
  Stream<List<LifeWheelData>> watchLifeWheel() =>
      (select(lifeWheel)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
  Future<int> insertLifeWheel(LifeWheelCompanion item) =>
      into(lifeWheel).insert(item);

  // ---------------------------------------------------------------------------
  // COMPLETE DATA WIPE
  // ---------------------------------------------------------------------------
  Future<void> wipeAllData() async {
    await transaction(() async {
      await delete(habits).go();
      await delete(streakEvents).go();
      await delete(urges).go();
      await delete(slips).go();
      await delete(checkins).go();
      await delete(missionProgress).go();
      await delete(userState).go();
      await delete(skills).go();
      await delete(badges).go();
      await delete(playbook).go();
      await delete(letters).go();
      await delete(lifeWheel).go();
    });
  }
}
