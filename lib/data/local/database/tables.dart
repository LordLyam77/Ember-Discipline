import 'package:drift/drift.dart';

// Habits table
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // e.g. 'porn', 'smoking', 'social_media', 'custom'
  TextColumn get goal => text()(); // 'quit_fully' or 'reduce'
  DateTimeColumn get startAt => dateTime()();
  TextColumn get why => text()();
  TextColumn get whyPhotoPath => text().nullable()();
  TextColumn get dangerTimes => text().withDefault(const Constant(''))(); // comma-separated danger times
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Streak events table (records each completed or interrupted streak segment)
class StreakEvents extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime()();
  TextColumn get endReason => text()(); // 'slip', 'reset', etc.

  @override
  Set<Column> get primaryKey => {id};
}

// Urges table
class Urges extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get at => dateTime()();
  IntColumn get strengthBefore => integer()(); // 1 to 5
  IntColumn get strengthAfter => integer().nullable()(); // 1 to 5
  TextColumn get triggerTag => text().nullable()();
  BoolColumn get usedSos => boolean().withDefault(const Constant(false))();
  TextColumn get outcome => text()(); // 'survived', 'slipped'

  @override
  Set<Column> get primaryKey => {id};
}

// Slips table (honest learning, no shame)
class Slips extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get at => dateTime()();
  TextColumn get trigger => text()();
  TextColumn get note => text().nullable()();
  TextColumn get changePlan => text().nullable()();
  BoolColumn get shieldUsed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Daily check-ins table
class Checkins extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()(); // normalized to YYYY-MM-DD
  IntColumn get mood => integer()(); // 1 (low) to 5 (great)
  IntColumn get stress => integer()(); // 1 (calm) to 5 (high stress)
  RealColumn get sleepHours => real()();
  IntColumn get urgeLevel => integer()(); // 1 (none) to 5 (intense)
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Mission progress table
class MissionProgress extends Table {
  TextColumn get id => text()();
  TextColumn get missionId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text()(); // 'completed', 'skipped', 'pending'
  IntColumn get xpAwarded => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

// User state table
class UserState extends Table {
  TextColumn get id => text()();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get currentStage => integer().withDefault(const Constant(1))();
  IntColumn get currentWeek => integer().withDefault(const Constant(1))();
  DateTimeColumn get weekStartAt => dateTime()();
  IntColumn get shields => integer().withDefault(const Constant(0))(); // max 2

  @override
  Set<Column> get primaryKey => {id};
}

// Skills table
class Skills extends Table {
  TextColumn get skillId => text()(); // awareness, sleep, urge_surfing, energy, trigger_control, replacement, stress, connection, identity
  IntColumn get points => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {skillId};
}

// Badges table
class Badges extends Table {
  TextColumn get badgeId => text()();
  DateTimeColumn get earnedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {badgeId};
}

// Playbook (if-then plans)
class Playbook extends Table {
  TextColumn get id => text()();
  TextColumn get triggerTag => text()();
  TextColumn get ifText => text()();
  TextColumn get thenText => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Letters to future self
class Letters extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get title => text()();
  TextColumn get body => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Life wheel ratings (monthly balance)
class LifeWheel extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get area => text()(); // health, mind, relationships, work_study, money, purpose, fun
  IntColumn get score => integer()(); // 1 to 10

  @override
  Set<Column> get primaryKey => {id};
}
