// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _whyMeta = const VerificationMeta('why');
  @override
  late final GeneratedColumn<String> why = GeneratedColumn<String>(
    'why',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _whyPhotoPathMeta = const VerificationMeta(
    'whyPhotoPath',
  );
  @override
  late final GeneratedColumn<String> whyPhotoPath = GeneratedColumn<String>(
    'why_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dangerTimesMeta = const VerificationMeta(
    'dangerTimes',
  );
  @override
  late final GeneratedColumn<String> dangerTimes = GeneratedColumn<String>(
    'danger_times',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    goal,
    startAt,
    why,
    whyPhotoPath,
    dangerTimes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('why')) {
      context.handle(
        _whyMeta,
        why.isAcceptableOrUnknown(data['why']!, _whyMeta),
      );
    } else if (isInserting) {
      context.missing(_whyMeta);
    }
    if (data.containsKey('why_photo_path')) {
      context.handle(
        _whyPhotoPathMeta,
        whyPhotoPath.isAcceptableOrUnknown(
          data['why_photo_path']!,
          _whyPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('danger_times')) {
      context.handle(
        _dangerTimesMeta,
        dangerTimes.isAcceptableOrUnknown(
          data['danger_times']!,
          _dangerTimesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      goal:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}goal'],
          )!,
      startAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_at'],
          )!,
      why:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}why'],
          )!,
      whyPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}why_photo_path'],
      ),
      dangerTimes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}danger_times'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String name;
  final String type;
  final String goal;
  final DateTime startAt;
  final String why;
  final String? whyPhotoPath;
  final String dangerTimes;
  final DateTime createdAt;
  const Habit({
    required this.id,
    required this.name,
    required this.type,
    required this.goal,
    required this.startAt,
    required this.why,
    this.whyPhotoPath,
    required this.dangerTimes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['goal'] = Variable<String>(goal);
    map['start_at'] = Variable<DateTime>(startAt);
    map['why'] = Variable<String>(why);
    if (!nullToAbsent || whyPhotoPath != null) {
      map['why_photo_path'] = Variable<String>(whyPhotoPath);
    }
    map['danger_times'] = Variable<String>(dangerTimes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      goal: Value(goal),
      startAt: Value(startAt),
      why: Value(why),
      whyPhotoPath:
          whyPhotoPath == null && nullToAbsent
              ? const Value.absent()
              : Value(whyPhotoPath),
      dangerTimes: Value(dangerTimes),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      goal: serializer.fromJson<String>(json['goal']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      why: serializer.fromJson<String>(json['why']),
      whyPhotoPath: serializer.fromJson<String?>(json['whyPhotoPath']),
      dangerTimes: serializer.fromJson<String>(json['dangerTimes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'goal': serializer.toJson<String>(goal),
      'startAt': serializer.toJson<DateTime>(startAt),
      'why': serializer.toJson<String>(why),
      'whyPhotoPath': serializer.toJson<String?>(whyPhotoPath),
      'dangerTimes': serializer.toJson<String>(dangerTimes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith({
    String? id,
    String? name,
    String? type,
    String? goal,
    DateTime? startAt,
    String? why,
    Value<String?> whyPhotoPath = const Value.absent(),
    String? dangerTimes,
    DateTime? createdAt,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    goal: goal ?? this.goal,
    startAt: startAt ?? this.startAt,
    why: why ?? this.why,
    whyPhotoPath: whyPhotoPath.present ? whyPhotoPath.value : this.whyPhotoPath,
    dangerTimes: dangerTimes ?? this.dangerTimes,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      goal: data.goal.present ? data.goal.value : this.goal,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      why: data.why.present ? data.why.value : this.why,
      whyPhotoPath:
          data.whyPhotoPath.present
              ? data.whyPhotoPath.value
              : this.whyPhotoPath,
      dangerTimes:
          data.dangerTimes.present ? data.dangerTimes.value : this.dangerTimes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('goal: $goal, ')
          ..write('startAt: $startAt, ')
          ..write('why: $why, ')
          ..write('whyPhotoPath: $whyPhotoPath, ')
          ..write('dangerTimes: $dangerTimes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    goal,
    startAt,
    why,
    whyPhotoPath,
    dangerTimes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.goal == this.goal &&
          other.startAt == this.startAt &&
          other.why == this.why &&
          other.whyPhotoPath == this.whyPhotoPath &&
          other.dangerTimes == this.dangerTimes &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> goal;
  final Value<DateTime> startAt;
  final Value<String> why;
  final Value<String?> whyPhotoPath;
  final Value<String> dangerTimes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.goal = const Value.absent(),
    this.startAt = const Value.absent(),
    this.why = const Value.absent(),
    this.whyPhotoPath = const Value.absent(),
    this.dangerTimes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String goal,
    required DateTime startAt,
    required String why,
    this.whyPhotoPath = const Value.absent(),
    this.dangerTimes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       goal = Value(goal),
       startAt = Value(startAt),
       why = Value(why),
       createdAt = Value(createdAt);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? goal,
    Expression<DateTime>? startAt,
    Expression<String>? why,
    Expression<String>? whyPhotoPath,
    Expression<String>? dangerTimes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (goal != null) 'goal': goal,
      if (startAt != null) 'start_at': startAt,
      if (why != null) 'why': why,
      if (whyPhotoPath != null) 'why_photo_path': whyPhotoPath,
      if (dangerTimes != null) 'danger_times': dangerTimes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? goal,
    Value<DateTime>? startAt,
    Value<String>? why,
    Value<String?>? whyPhotoPath,
    Value<String>? dangerTimes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      goal: goal ?? this.goal,
      startAt: startAt ?? this.startAt,
      why: why ?? this.why,
      whyPhotoPath: whyPhotoPath ?? this.whyPhotoPath,
      dangerTimes: dangerTimes ?? this.dangerTimes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (why.present) {
      map['why'] = Variable<String>(why.value);
    }
    if (whyPhotoPath.present) {
      map['why_photo_path'] = Variable<String>(whyPhotoPath.value);
    }
    if (dangerTimes.present) {
      map['danger_times'] = Variable<String>(dangerTimes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('goal: $goal, ')
          ..write('startAt: $startAt, ')
          ..write('why: $why, ')
          ..write('whyPhotoPath: $whyPhotoPath, ')
          ..write('dangerTimes: $dangerTimes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StreakEventsTable extends StreakEvents
    with TableInfo<$StreakEventsTable, StreakEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreakEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endReasonMeta = const VerificationMeta(
    'endReason',
  );
  @override
  late final GeneratedColumn<String> endReason = GeneratedColumn<String>(
    'end_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    startAt,
    endAt,
    endReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streak_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<StreakEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('end_reason')) {
      context.handle(
        _endReasonMeta,
        endReason.isAcceptableOrUnknown(data['end_reason']!, _endReasonMeta),
      );
    } else if (isInserting) {
      context.missing(_endReasonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StreakEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StreakEvent(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      habitId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}habit_id'],
          )!,
      startAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_at'],
          )!,
      endAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_at'],
          )!,
      endReason:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}end_reason'],
          )!,
    );
  }

  @override
  $StreakEventsTable createAlias(String alias) {
    return $StreakEventsTable(attachedDatabase, alias);
  }
}

class StreakEvent extends DataClass implements Insertable<StreakEvent> {
  final String id;
  final String habitId;
  final DateTime startAt;
  final DateTime endAt;
  final String endReason;
  const StreakEvent({
    required this.id,
    required this.habitId,
    required this.startAt,
    required this.endAt,
    required this.endReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    map['end_reason'] = Variable<String>(endReason);
    return map;
  }

  StreakEventsCompanion toCompanion(bool nullToAbsent) {
    return StreakEventsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      startAt: Value(startAt),
      endAt: Value(endAt),
      endReason: Value(endReason),
    );
  }

  factory StreakEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StreakEvent(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      endReason: serializer.fromJson<String>(json['endReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'endReason': serializer.toJson<String>(endReason),
    };
  }

  StreakEvent copyWith({
    String? id,
    String? habitId,
    DateTime? startAt,
    DateTime? endAt,
    String? endReason,
  }) => StreakEvent(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    endReason: endReason ?? this.endReason,
  );
  StreakEvent copyWithCompanion(StreakEventsCompanion data) {
    return StreakEvent(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      endReason: data.endReason.present ? data.endReason.value : this.endReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StreakEvent(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('endReason: $endReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, startAt, endAt, endReason);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StreakEvent &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.endReason == this.endReason);
}

class StreakEventsCompanion extends UpdateCompanion<StreakEvent> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<String> endReason;
  final Value<int> rowid;
  const StreakEventsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.endReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StreakEventsCompanion.insert({
    required String id,
    required String habitId,
    required DateTime startAt,
    required DateTime endAt,
    required String endReason,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       startAt = Value(startAt),
       endAt = Value(endAt),
       endReason = Value(endReason);
  static Insertable<StreakEvent> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<String>? endReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (endReason != null) 'end_reason': endReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StreakEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? startAt,
    Value<DateTime>? endAt,
    Value<String>? endReason,
    Value<int>? rowid,
  }) {
    return StreakEventsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      endReason: endReason ?? this.endReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (endReason.present) {
      map['end_reason'] = Variable<String>(endReason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreakEventsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('endReason: $endReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UrgesTable extends Urges with TableInfo<$UrgesTable, Urge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UrgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strengthBeforeMeta = const VerificationMeta(
    'strengthBefore',
  );
  @override
  late final GeneratedColumn<int> strengthBefore = GeneratedColumn<int>(
    'strength_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strengthAfterMeta = const VerificationMeta(
    'strengthAfter',
  );
  @override
  late final GeneratedColumn<int> strengthAfter = GeneratedColumn<int>(
    'strength_after',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _triggerTagMeta = const VerificationMeta(
    'triggerTag',
  );
  @override
  late final GeneratedColumn<String> triggerTag = GeneratedColumn<String>(
    'trigger_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usedSosMeta = const VerificationMeta(
    'usedSos',
  );
  @override
  late final GeneratedColumn<bool> usedSos = GeneratedColumn<bool>(
    'used_sos',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("used_sos" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    at,
    strengthBefore,
    strengthAfter,
    triggerTag,
    usedSos,
    outcome,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'urges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Urge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('strength_before')) {
      context.handle(
        _strengthBeforeMeta,
        strengthBefore.isAcceptableOrUnknown(
          data['strength_before']!,
          _strengthBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strengthBeforeMeta);
    }
    if (data.containsKey('strength_after')) {
      context.handle(
        _strengthAfterMeta,
        strengthAfter.isAcceptableOrUnknown(
          data['strength_after']!,
          _strengthAfterMeta,
        ),
      );
    }
    if (data.containsKey('trigger_tag')) {
      context.handle(
        _triggerTagMeta,
        triggerTag.isAcceptableOrUnknown(data['trigger_tag']!, _triggerTagMeta),
      );
    }
    if (data.containsKey('used_sos')) {
      context.handle(
        _usedSosMeta,
        usedSos.isAcceptableOrUnknown(data['used_sos']!, _usedSosMeta),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Urge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Urge(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      habitId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}habit_id'],
          )!,
      at:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}at'],
          )!,
      strengthBefore:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}strength_before'],
          )!,
      strengthAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strength_after'],
      ),
      triggerTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_tag'],
      ),
      usedSos:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}used_sos'],
          )!,
      outcome:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}outcome'],
          )!,
    );
  }

  @override
  $UrgesTable createAlias(String alias) {
    return $UrgesTable(attachedDatabase, alias);
  }
}

class Urge extends DataClass implements Insertable<Urge> {
  final String id;
  final String habitId;
  final DateTime at;
  final int strengthBefore;
  final int? strengthAfter;
  final String? triggerTag;
  final bool usedSos;
  final String outcome;
  const Urge({
    required this.id,
    required this.habitId,
    required this.at,
    required this.strengthBefore,
    this.strengthAfter,
    this.triggerTag,
    required this.usedSos,
    required this.outcome,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['at'] = Variable<DateTime>(at);
    map['strength_before'] = Variable<int>(strengthBefore);
    if (!nullToAbsent || strengthAfter != null) {
      map['strength_after'] = Variable<int>(strengthAfter);
    }
    if (!nullToAbsent || triggerTag != null) {
      map['trigger_tag'] = Variable<String>(triggerTag);
    }
    map['used_sos'] = Variable<bool>(usedSos);
    map['outcome'] = Variable<String>(outcome);
    return map;
  }

  UrgesCompanion toCompanion(bool nullToAbsent) {
    return UrgesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      at: Value(at),
      strengthBefore: Value(strengthBefore),
      strengthAfter:
          strengthAfter == null && nullToAbsent
              ? const Value.absent()
              : Value(strengthAfter),
      triggerTag:
          triggerTag == null && nullToAbsent
              ? const Value.absent()
              : Value(triggerTag),
      usedSos: Value(usedSos),
      outcome: Value(outcome),
    );
  }

  factory Urge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Urge(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      at: serializer.fromJson<DateTime>(json['at']),
      strengthBefore: serializer.fromJson<int>(json['strengthBefore']),
      strengthAfter: serializer.fromJson<int?>(json['strengthAfter']),
      triggerTag: serializer.fromJson<String?>(json['triggerTag']),
      usedSos: serializer.fromJson<bool>(json['usedSos']),
      outcome: serializer.fromJson<String>(json['outcome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'at': serializer.toJson<DateTime>(at),
      'strengthBefore': serializer.toJson<int>(strengthBefore),
      'strengthAfter': serializer.toJson<int?>(strengthAfter),
      'triggerTag': serializer.toJson<String?>(triggerTag),
      'usedSos': serializer.toJson<bool>(usedSos),
      'outcome': serializer.toJson<String>(outcome),
    };
  }

  Urge copyWith({
    String? id,
    String? habitId,
    DateTime? at,
    int? strengthBefore,
    Value<int?> strengthAfter = const Value.absent(),
    Value<String?> triggerTag = const Value.absent(),
    bool? usedSos,
    String? outcome,
  }) => Urge(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    at: at ?? this.at,
    strengthBefore: strengthBefore ?? this.strengthBefore,
    strengthAfter:
        strengthAfter.present ? strengthAfter.value : this.strengthAfter,
    triggerTag: triggerTag.present ? triggerTag.value : this.triggerTag,
    usedSos: usedSos ?? this.usedSos,
    outcome: outcome ?? this.outcome,
  );
  Urge copyWithCompanion(UrgesCompanion data) {
    return Urge(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      at: data.at.present ? data.at.value : this.at,
      strengthBefore:
          data.strengthBefore.present
              ? data.strengthBefore.value
              : this.strengthBefore,
      strengthAfter:
          data.strengthAfter.present
              ? data.strengthAfter.value
              : this.strengthAfter,
      triggerTag:
          data.triggerTag.present ? data.triggerTag.value : this.triggerTag,
      usedSos: data.usedSos.present ? data.usedSos.value : this.usedSos,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Urge(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('at: $at, ')
          ..write('strengthBefore: $strengthBefore, ')
          ..write('strengthAfter: $strengthAfter, ')
          ..write('triggerTag: $triggerTag, ')
          ..write('usedSos: $usedSos, ')
          ..write('outcome: $outcome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    at,
    strengthBefore,
    strengthAfter,
    triggerTag,
    usedSos,
    outcome,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Urge &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.at == this.at &&
          other.strengthBefore == this.strengthBefore &&
          other.strengthAfter == this.strengthAfter &&
          other.triggerTag == this.triggerTag &&
          other.usedSos == this.usedSos &&
          other.outcome == this.outcome);
}

class UrgesCompanion extends UpdateCompanion<Urge> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> at;
  final Value<int> strengthBefore;
  final Value<int?> strengthAfter;
  final Value<String?> triggerTag;
  final Value<bool> usedSos;
  final Value<String> outcome;
  final Value<int> rowid;
  const UrgesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.at = const Value.absent(),
    this.strengthBefore = const Value.absent(),
    this.strengthAfter = const Value.absent(),
    this.triggerTag = const Value.absent(),
    this.usedSos = const Value.absent(),
    this.outcome = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UrgesCompanion.insert({
    required String id,
    required String habitId,
    required DateTime at,
    required int strengthBefore,
    this.strengthAfter = const Value.absent(),
    this.triggerTag = const Value.absent(),
    this.usedSos = const Value.absent(),
    required String outcome,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       at = Value(at),
       strengthBefore = Value(strengthBefore),
       outcome = Value(outcome);
  static Insertable<Urge> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? at,
    Expression<int>? strengthBefore,
    Expression<int>? strengthAfter,
    Expression<String>? triggerTag,
    Expression<bool>? usedSos,
    Expression<String>? outcome,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (at != null) 'at': at,
      if (strengthBefore != null) 'strength_before': strengthBefore,
      if (strengthAfter != null) 'strength_after': strengthAfter,
      if (triggerTag != null) 'trigger_tag': triggerTag,
      if (usedSos != null) 'used_sos': usedSos,
      if (outcome != null) 'outcome': outcome,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UrgesCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? at,
    Value<int>? strengthBefore,
    Value<int?>? strengthAfter,
    Value<String?>? triggerTag,
    Value<bool>? usedSos,
    Value<String>? outcome,
    Value<int>? rowid,
  }) {
    return UrgesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      at: at ?? this.at,
      strengthBefore: strengthBefore ?? this.strengthBefore,
      strengthAfter: strengthAfter ?? this.strengthAfter,
      triggerTag: triggerTag ?? this.triggerTag,
      usedSos: usedSos ?? this.usedSos,
      outcome: outcome ?? this.outcome,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (strengthBefore.present) {
      map['strength_before'] = Variable<int>(strengthBefore.value);
    }
    if (strengthAfter.present) {
      map['strength_after'] = Variable<int>(strengthAfter.value);
    }
    if (triggerTag.present) {
      map['trigger_tag'] = Variable<String>(triggerTag.value);
    }
    if (usedSos.present) {
      map['used_sos'] = Variable<bool>(usedSos.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UrgesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('at: $at, ')
          ..write('strengthBefore: $strengthBefore, ')
          ..write('strengthAfter: $strengthAfter, ')
          ..write('triggerTag: $triggerTag, ')
          ..write('usedSos: $usedSos, ')
          ..write('outcome: $outcome, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SlipsTable extends Slips with TableInfo<$SlipsTable, Slip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SlipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changePlanMeta = const VerificationMeta(
    'changePlan',
  );
  @override
  late final GeneratedColumn<String> changePlan = GeneratedColumn<String>(
    'change_plan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shieldUsedMeta = const VerificationMeta(
    'shieldUsed',
  );
  @override
  late final GeneratedColumn<bool> shieldUsed = GeneratedColumn<bool>(
    'shield_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("shield_used" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    at,
    trigger,
    note,
    changePlan,
    shieldUsed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'slips';
  @override
  VerificationContext validateIntegrity(
    Insertable<Slip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('change_plan')) {
      context.handle(
        _changePlanMeta,
        changePlan.isAcceptableOrUnknown(data['change_plan']!, _changePlanMeta),
      );
    }
    if (data.containsKey('shield_used')) {
      context.handle(
        _shieldUsedMeta,
        shieldUsed.isAcceptableOrUnknown(data['shield_used']!, _shieldUsedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Slip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Slip(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      habitId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}habit_id'],
          )!,
      at:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}at'],
          )!,
      trigger:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trigger'],
          )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      changePlan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_plan'],
      ),
      shieldUsed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}shield_used'],
          )!,
    );
  }

  @override
  $SlipsTable createAlias(String alias) {
    return $SlipsTable(attachedDatabase, alias);
  }
}

class Slip extends DataClass implements Insertable<Slip> {
  final String id;
  final String habitId;
  final DateTime at;
  final String trigger;
  final String? note;
  final String? changePlan;
  final bool shieldUsed;
  const Slip({
    required this.id,
    required this.habitId,
    required this.at,
    required this.trigger,
    this.note,
    this.changePlan,
    required this.shieldUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['at'] = Variable<DateTime>(at);
    map['trigger'] = Variable<String>(trigger);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || changePlan != null) {
      map['change_plan'] = Variable<String>(changePlan);
    }
    map['shield_used'] = Variable<bool>(shieldUsed);
    return map;
  }

  SlipsCompanion toCompanion(bool nullToAbsent) {
    return SlipsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      at: Value(at),
      trigger: Value(trigger),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      changePlan:
          changePlan == null && nullToAbsent
              ? const Value.absent()
              : Value(changePlan),
      shieldUsed: Value(shieldUsed),
    );
  }

  factory Slip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Slip(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      at: serializer.fromJson<DateTime>(json['at']),
      trigger: serializer.fromJson<String>(json['trigger']),
      note: serializer.fromJson<String?>(json['note']),
      changePlan: serializer.fromJson<String?>(json['changePlan']),
      shieldUsed: serializer.fromJson<bool>(json['shieldUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'at': serializer.toJson<DateTime>(at),
      'trigger': serializer.toJson<String>(trigger),
      'note': serializer.toJson<String?>(note),
      'changePlan': serializer.toJson<String?>(changePlan),
      'shieldUsed': serializer.toJson<bool>(shieldUsed),
    };
  }

  Slip copyWith({
    String? id,
    String? habitId,
    DateTime? at,
    String? trigger,
    Value<String?> note = const Value.absent(),
    Value<String?> changePlan = const Value.absent(),
    bool? shieldUsed,
  }) => Slip(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    at: at ?? this.at,
    trigger: trigger ?? this.trigger,
    note: note.present ? note.value : this.note,
    changePlan: changePlan.present ? changePlan.value : this.changePlan,
    shieldUsed: shieldUsed ?? this.shieldUsed,
  );
  Slip copyWithCompanion(SlipsCompanion data) {
    return Slip(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      at: data.at.present ? data.at.value : this.at,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      note: data.note.present ? data.note.value : this.note,
      changePlan:
          data.changePlan.present ? data.changePlan.value : this.changePlan,
      shieldUsed:
          data.shieldUsed.present ? data.shieldUsed.value : this.shieldUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Slip(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('at: $at, ')
          ..write('trigger: $trigger, ')
          ..write('note: $note, ')
          ..write('changePlan: $changePlan, ')
          ..write('shieldUsed: $shieldUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, at, trigger, note, changePlan, shieldUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Slip &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.at == this.at &&
          other.trigger == this.trigger &&
          other.note == this.note &&
          other.changePlan == this.changePlan &&
          other.shieldUsed == this.shieldUsed);
}

class SlipsCompanion extends UpdateCompanion<Slip> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> at;
  final Value<String> trigger;
  final Value<String?> note;
  final Value<String?> changePlan;
  final Value<bool> shieldUsed;
  final Value<int> rowid;
  const SlipsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.at = const Value.absent(),
    this.trigger = const Value.absent(),
    this.note = const Value.absent(),
    this.changePlan = const Value.absent(),
    this.shieldUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SlipsCompanion.insert({
    required String id,
    required String habitId,
    required DateTime at,
    required String trigger,
    this.note = const Value.absent(),
    this.changePlan = const Value.absent(),
    this.shieldUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       at = Value(at),
       trigger = Value(trigger);
  static Insertable<Slip> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? at,
    Expression<String>? trigger,
    Expression<String>? note,
    Expression<String>? changePlan,
    Expression<bool>? shieldUsed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (at != null) 'at': at,
      if (trigger != null) 'trigger': trigger,
      if (note != null) 'note': note,
      if (changePlan != null) 'change_plan': changePlan,
      if (shieldUsed != null) 'shield_used': shieldUsed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SlipsCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? at,
    Value<String>? trigger,
    Value<String?>? note,
    Value<String?>? changePlan,
    Value<bool>? shieldUsed,
    Value<int>? rowid,
  }) {
    return SlipsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      at: at ?? this.at,
      trigger: trigger ?? this.trigger,
      note: note ?? this.note,
      changePlan: changePlan ?? this.changePlan,
      shieldUsed: shieldUsed ?? this.shieldUsed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (changePlan.present) {
      map['change_plan'] = Variable<String>(changePlan.value);
    }
    if (shieldUsed.present) {
      map['shield_used'] = Variable<bool>(shieldUsed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SlipsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('at: $at, ')
          ..write('trigger: $trigger, ')
          ..write('note: $note, ')
          ..write('changePlan: $changePlan, ')
          ..write('shieldUsed: $shieldUsed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CheckinsTable extends Checkins with TableInfo<$CheckinsTable, Checkin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stressMeta = const VerificationMeta('stress');
  @override
  late final GeneratedColumn<int> stress = GeneratedColumn<int>(
    'stress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepHoursMeta = const VerificationMeta(
    'sleepHours',
  );
  @override
  late final GeneratedColumn<double> sleepHours = GeneratedColumn<double>(
    'sleep_hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgeLevelMeta = const VerificationMeta(
    'urgeLevel',
  );
  @override
  late final GeneratedColumn<int> urgeLevel = GeneratedColumn<int>(
    'urge_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    mood,
    stress,
    sleepHours,
    urgeLevel,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checkins';
  @override
  VerificationContext validateIntegrity(
    Insertable<Checkin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('stress')) {
      context.handle(
        _stressMeta,
        stress.isAcceptableOrUnknown(data['stress']!, _stressMeta),
      );
    } else if (isInserting) {
      context.missing(_stressMeta);
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
        _sleepHoursMeta,
        sleepHours.isAcceptableOrUnknown(data['sleep_hours']!, _sleepHoursMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepHoursMeta);
    }
    if (data.containsKey('urge_level')) {
      context.handle(
        _urgeLevelMeta,
        urgeLevel.isAcceptableOrUnknown(data['urge_level']!, _urgeLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_urgeLevelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Checkin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Checkin(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      mood:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}mood'],
          )!,
      stress:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}stress'],
          )!,
      sleepHours:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}sleep_hours'],
          )!,
      urgeLevel:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}urge_level'],
          )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $CheckinsTable createAlias(String alias) {
    return $CheckinsTable(attachedDatabase, alias);
  }
}

class Checkin extends DataClass implements Insertable<Checkin> {
  final String id;
  final DateTime date;
  final int mood;
  final int stress;
  final double sleepHours;
  final int urgeLevel;
  final String? note;
  const Checkin({
    required this.id,
    required this.date,
    required this.mood,
    required this.stress,
    required this.sleepHours,
    required this.urgeLevel,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['mood'] = Variable<int>(mood);
    map['stress'] = Variable<int>(stress);
    map['sleep_hours'] = Variable<double>(sleepHours);
    map['urge_level'] = Variable<int>(urgeLevel);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  CheckinsCompanion toCompanion(bool nullToAbsent) {
    return CheckinsCompanion(
      id: Value(id),
      date: Value(date),
      mood: Value(mood),
      stress: Value(stress),
      sleepHours: Value(sleepHours),
      urgeLevel: Value(urgeLevel),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Checkin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Checkin(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      mood: serializer.fromJson<int>(json['mood']),
      stress: serializer.fromJson<int>(json['stress']),
      sleepHours: serializer.fromJson<double>(json['sleepHours']),
      urgeLevel: serializer.fromJson<int>(json['urgeLevel']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'mood': serializer.toJson<int>(mood),
      'stress': serializer.toJson<int>(stress),
      'sleepHours': serializer.toJson<double>(sleepHours),
      'urgeLevel': serializer.toJson<int>(urgeLevel),
      'note': serializer.toJson<String?>(note),
    };
  }

  Checkin copyWith({
    String? id,
    DateTime? date,
    int? mood,
    int? stress,
    double? sleepHours,
    int? urgeLevel,
    Value<String?> note = const Value.absent(),
  }) => Checkin(
    id: id ?? this.id,
    date: date ?? this.date,
    mood: mood ?? this.mood,
    stress: stress ?? this.stress,
    sleepHours: sleepHours ?? this.sleepHours,
    urgeLevel: urgeLevel ?? this.urgeLevel,
    note: note.present ? note.value : this.note,
  );
  Checkin copyWithCompanion(CheckinsCompanion data) {
    return Checkin(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      mood: data.mood.present ? data.mood.value : this.mood,
      stress: data.stress.present ? data.stress.value : this.stress,
      sleepHours:
          data.sleepHours.present ? data.sleepHours.value : this.sleepHours,
      urgeLevel: data.urgeLevel.present ? data.urgeLevel.value : this.urgeLevel,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Checkin(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mood: $mood, ')
          ..write('stress: $stress, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('urgeLevel: $urgeLevel, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, mood, stress, sleepHours, urgeLevel, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Checkin &&
          other.id == this.id &&
          other.date == this.date &&
          other.mood == this.mood &&
          other.stress == this.stress &&
          other.sleepHours == this.sleepHours &&
          other.urgeLevel == this.urgeLevel &&
          other.note == this.note);
}

class CheckinsCompanion extends UpdateCompanion<Checkin> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> mood;
  final Value<int> stress;
  final Value<double> sleepHours;
  final Value<int> urgeLevel;
  final Value<String?> note;
  final Value<int> rowid;
  const CheckinsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.mood = const Value.absent(),
    this.stress = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.urgeLevel = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckinsCompanion.insert({
    required String id,
    required DateTime date,
    required int mood,
    required int stress,
    required double sleepHours,
    required int urgeLevel,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       mood = Value(mood),
       stress = Value(stress),
       sleepHours = Value(sleepHours),
       urgeLevel = Value(urgeLevel);
  static Insertable<Checkin> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? mood,
    Expression<int>? stress,
    Expression<double>? sleepHours,
    Expression<int>? urgeLevel,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (mood != null) 'mood': mood,
      if (stress != null) 'stress': stress,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (urgeLevel != null) 'urge_level': urgeLevel,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckinsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<int>? mood,
    Value<int>? stress,
    Value<double>? sleepHours,
    Value<int>? urgeLevel,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return CheckinsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      stress: stress ?? this.stress,
      sleepHours: sleepHours ?? this.sleepHours,
      urgeLevel: urgeLevel ?? this.urgeLevel,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (stress.present) {
      map['stress'] = Variable<int>(stress.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<double>(sleepHours.value);
    }
    if (urgeLevel.present) {
      map['urge_level'] = Variable<int>(urgeLevel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckinsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mood: $mood, ')
          ..write('stress: $stress, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('urgeLevel: $urgeLevel, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MissionProgressTable extends MissionProgress
    with TableInfo<$MissionProgressTable, MissionProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MissionProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _missionIdMeta = const VerificationMeta(
    'missionId',
  );
  @override
  late final GeneratedColumn<String> missionId = GeneratedColumn<String>(
    'mission_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpAwardedMeta = const VerificationMeta(
    'xpAwarded',
  );
  @override
  late final GeneratedColumn<int> xpAwarded = GeneratedColumn<int>(
    'xp_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    missionId,
    date,
    status,
    xpAwarded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mission_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<MissionProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mission_id')) {
      context.handle(
        _missionIdMeta,
        missionId.isAcceptableOrUnknown(data['mission_id']!, _missionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_missionIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('xp_awarded')) {
      context.handle(
        _xpAwardedMeta,
        xpAwarded.isAcceptableOrUnknown(data['xp_awarded']!, _xpAwardedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MissionProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MissionProgressData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      missionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}mission_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      xpAwarded:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp_awarded'],
          )!,
    );
  }

  @override
  $MissionProgressTable createAlias(String alias) {
    return $MissionProgressTable(attachedDatabase, alias);
  }
}

class MissionProgressData extends DataClass
    implements Insertable<MissionProgressData> {
  final String id;
  final String missionId;
  final DateTime date;
  final String status;
  final int xpAwarded;
  const MissionProgressData({
    required this.id,
    required this.missionId,
    required this.date,
    required this.status,
    required this.xpAwarded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mission_id'] = Variable<String>(missionId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    map['xp_awarded'] = Variable<int>(xpAwarded);
    return map;
  }

  MissionProgressCompanion toCompanion(bool nullToAbsent) {
    return MissionProgressCompanion(
      id: Value(id),
      missionId: Value(missionId),
      date: Value(date),
      status: Value(status),
      xpAwarded: Value(xpAwarded),
    );
  }

  factory MissionProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MissionProgressData(
      id: serializer.fromJson<String>(json['id']),
      missionId: serializer.fromJson<String>(json['missionId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      xpAwarded: serializer.fromJson<int>(json['xpAwarded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'missionId': serializer.toJson<String>(missionId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'xpAwarded': serializer.toJson<int>(xpAwarded),
    };
  }

  MissionProgressData copyWith({
    String? id,
    String? missionId,
    DateTime? date,
    String? status,
    int? xpAwarded,
  }) => MissionProgressData(
    id: id ?? this.id,
    missionId: missionId ?? this.missionId,
    date: date ?? this.date,
    status: status ?? this.status,
    xpAwarded: xpAwarded ?? this.xpAwarded,
  );
  MissionProgressData copyWithCompanion(MissionProgressCompanion data) {
    return MissionProgressData(
      id: data.id.present ? data.id.value : this.id,
      missionId: data.missionId.present ? data.missionId.value : this.missionId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      xpAwarded: data.xpAwarded.present ? data.xpAwarded.value : this.xpAwarded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MissionProgressData(')
          ..write('id: $id, ')
          ..write('missionId: $missionId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('xpAwarded: $xpAwarded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, missionId, date, status, xpAwarded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MissionProgressData &&
          other.id == this.id &&
          other.missionId == this.missionId &&
          other.date == this.date &&
          other.status == this.status &&
          other.xpAwarded == this.xpAwarded);
}

class MissionProgressCompanion extends UpdateCompanion<MissionProgressData> {
  final Value<String> id;
  final Value<String> missionId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<int> xpAwarded;
  final Value<int> rowid;
  const MissionProgressCompanion({
    this.id = const Value.absent(),
    this.missionId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MissionProgressCompanion.insert({
    required String id,
    required String missionId,
    required DateTime date,
    required String status,
    this.xpAwarded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       missionId = Value(missionId),
       date = Value(date),
       status = Value(status);
  static Insertable<MissionProgressData> custom({
    Expression<String>? id,
    Expression<String>? missionId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<int>? xpAwarded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (missionId != null) 'mission_id': missionId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (xpAwarded != null) 'xp_awarded': xpAwarded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MissionProgressCompanion copyWith({
    Value<String>? id,
    Value<String>? missionId,
    Value<DateTime>? date,
    Value<String>? status,
    Value<int>? xpAwarded,
    Value<int>? rowid,
  }) {
    return MissionProgressCompanion(
      id: id ?? this.id,
      missionId: missionId ?? this.missionId,
      date: date ?? this.date,
      status: status ?? this.status,
      xpAwarded: xpAwarded ?? this.xpAwarded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (missionId.present) {
      map['mission_id'] = Variable<String>(missionId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (xpAwarded.present) {
      map['xp_awarded'] = Variable<int>(xpAwarded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MissionProgressCompanion(')
          ..write('id: $id, ')
          ..write('missionId: $missionId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserStateTable extends UserState
    with TableInfo<$UserStateTable, UserStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentStageMeta = const VerificationMeta(
    'currentStage',
  );
  @override
  late final GeneratedColumn<int> currentStage = GeneratedColumn<int>(
    'current_stage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentWeekMeta = const VerificationMeta(
    'currentWeek',
  );
  @override
  late final GeneratedColumn<int> currentWeek = GeneratedColumn<int>(
    'current_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _weekStartAtMeta = const VerificationMeta(
    'weekStartAt',
  );
  @override
  late final GeneratedColumn<DateTime> weekStartAt = GeneratedColumn<DateTime>(
    'week_start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shieldsMeta = const VerificationMeta(
    'shields',
  );
  @override
  late final GeneratedColumn<int> shields = GeneratedColumn<int>(
    'shields',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    xp,
    level,
    currentStage,
    currentWeek,
    weekStartAt,
    shields,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('current_stage')) {
      context.handle(
        _currentStageMeta,
        currentStage.isAcceptableOrUnknown(
          data['current_stage']!,
          _currentStageMeta,
        ),
      );
    }
    if (data.containsKey('current_week')) {
      context.handle(
        _currentWeekMeta,
        currentWeek.isAcceptableOrUnknown(
          data['current_week']!,
          _currentWeekMeta,
        ),
      );
    }
    if (data.containsKey('week_start_at')) {
      context.handle(
        _weekStartAtMeta,
        weekStartAt.isAcceptableOrUnknown(
          data['week_start_at']!,
          _weekStartAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartAtMeta);
    }
    if (data.containsKey('shields')) {
      context.handle(
        _shieldsMeta,
        shields.isAcceptableOrUnknown(data['shields']!, _shieldsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStateData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      xp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp'],
          )!,
      level:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}level'],
          )!,
      currentStage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}current_stage'],
          )!,
      currentWeek:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}current_week'],
          )!,
      weekStartAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}week_start_at'],
          )!,
      shields:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}shields'],
          )!,
    );
  }

  @override
  $UserStateTable createAlias(String alias) {
    return $UserStateTable(attachedDatabase, alias);
  }
}

class UserStateData extends DataClass implements Insertable<UserStateData> {
  final String id;
  final int xp;
  final int level;
  final int currentStage;
  final int currentWeek;
  final DateTime weekStartAt;
  final int shields;
  const UserStateData({
    required this.id,
    required this.xp,
    required this.level,
    required this.currentStage,
    required this.currentWeek,
    required this.weekStartAt,
    required this.shields,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['xp'] = Variable<int>(xp);
    map['level'] = Variable<int>(level);
    map['current_stage'] = Variable<int>(currentStage);
    map['current_week'] = Variable<int>(currentWeek);
    map['week_start_at'] = Variable<DateTime>(weekStartAt);
    map['shields'] = Variable<int>(shields);
    return map;
  }

  UserStateCompanion toCompanion(bool nullToAbsent) {
    return UserStateCompanion(
      id: Value(id),
      xp: Value(xp),
      level: Value(level),
      currentStage: Value(currentStage),
      currentWeek: Value(currentWeek),
      weekStartAt: Value(weekStartAt),
      shields: Value(shields),
    );
  }

  factory UserStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStateData(
      id: serializer.fromJson<String>(json['id']),
      xp: serializer.fromJson<int>(json['xp']),
      level: serializer.fromJson<int>(json['level']),
      currentStage: serializer.fromJson<int>(json['currentStage']),
      currentWeek: serializer.fromJson<int>(json['currentWeek']),
      weekStartAt: serializer.fromJson<DateTime>(json['weekStartAt']),
      shields: serializer.fromJson<int>(json['shields']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'xp': serializer.toJson<int>(xp),
      'level': serializer.toJson<int>(level),
      'currentStage': serializer.toJson<int>(currentStage),
      'currentWeek': serializer.toJson<int>(currentWeek),
      'weekStartAt': serializer.toJson<DateTime>(weekStartAt),
      'shields': serializer.toJson<int>(shields),
    };
  }

  UserStateData copyWith({
    String? id,
    int? xp,
    int? level,
    int? currentStage,
    int? currentWeek,
    DateTime? weekStartAt,
    int? shields,
  }) => UserStateData(
    id: id ?? this.id,
    xp: xp ?? this.xp,
    level: level ?? this.level,
    currentStage: currentStage ?? this.currentStage,
    currentWeek: currentWeek ?? this.currentWeek,
    weekStartAt: weekStartAt ?? this.weekStartAt,
    shields: shields ?? this.shields,
  );
  UserStateData copyWithCompanion(UserStateCompanion data) {
    return UserStateData(
      id: data.id.present ? data.id.value : this.id,
      xp: data.xp.present ? data.xp.value : this.xp,
      level: data.level.present ? data.level.value : this.level,
      currentStage:
          data.currentStage.present
              ? data.currentStage.value
              : this.currentStage,
      currentWeek:
          data.currentWeek.present ? data.currentWeek.value : this.currentWeek,
      weekStartAt:
          data.weekStartAt.present ? data.weekStartAt.value : this.weekStartAt,
      shields: data.shields.present ? data.shields.value : this.shields,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStateData(')
          ..write('id: $id, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('currentStage: $currentStage, ')
          ..write('currentWeek: $currentWeek, ')
          ..write('weekStartAt: $weekStartAt, ')
          ..write('shields: $shields')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    xp,
    level,
    currentStage,
    currentWeek,
    weekStartAt,
    shields,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStateData &&
          other.id == this.id &&
          other.xp == this.xp &&
          other.level == this.level &&
          other.currentStage == this.currentStage &&
          other.currentWeek == this.currentWeek &&
          other.weekStartAt == this.weekStartAt &&
          other.shields == this.shields);
}

class UserStateCompanion extends UpdateCompanion<UserStateData> {
  final Value<String> id;
  final Value<int> xp;
  final Value<int> level;
  final Value<int> currentStage;
  final Value<int> currentWeek;
  final Value<DateTime> weekStartAt;
  final Value<int> shields;
  final Value<int> rowid;
  const UserStateCompanion({
    this.id = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.currentWeek = const Value.absent(),
    this.weekStartAt = const Value.absent(),
    this.shields = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserStateCompanion.insert({
    required String id,
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.currentWeek = const Value.absent(),
    required DateTime weekStartAt,
    this.shields = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       weekStartAt = Value(weekStartAt);
  static Insertable<UserStateData> custom({
    Expression<String>? id,
    Expression<int>? xp,
    Expression<int>? level,
    Expression<int>? currentStage,
    Expression<int>? currentWeek,
    Expression<DateTime>? weekStartAt,
    Expression<int>? shields,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (xp != null) 'xp': xp,
      if (level != null) 'level': level,
      if (currentStage != null) 'current_stage': currentStage,
      if (currentWeek != null) 'current_week': currentWeek,
      if (weekStartAt != null) 'week_start_at': weekStartAt,
      if (shields != null) 'shields': shields,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserStateCompanion copyWith({
    Value<String>? id,
    Value<int>? xp,
    Value<int>? level,
    Value<int>? currentStage,
    Value<int>? currentWeek,
    Value<DateTime>? weekStartAt,
    Value<int>? shields,
    Value<int>? rowid,
  }) {
    return UserStateCompanion(
      id: id ?? this.id,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      currentStage: currentStage ?? this.currentStage,
      currentWeek: currentWeek ?? this.currentWeek,
      weekStartAt: weekStartAt ?? this.weekStartAt,
      shields: shields ?? this.shields,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentStage.present) {
      map['current_stage'] = Variable<int>(currentStage.value);
    }
    if (currentWeek.present) {
      map['current_week'] = Variable<int>(currentWeek.value);
    }
    if (weekStartAt.present) {
      map['week_start_at'] = Variable<DateTime>(weekStartAt.value);
    }
    if (shields.present) {
      map['shields'] = Variable<int>(shields.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStateCompanion(')
          ..write('id: $id, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('currentStage: $currentStage, ')
          ..write('currentWeek: $currentWeek, ')
          ..write('weekStartAt: $weekStartAt, ')
          ..write('shields: $shields, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkillsTable extends Skills with TableInfo<$SkillsTable, Skill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<String> skillId = GeneratedColumn<String>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [skillId, points];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<Skill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {skillId};
  @override
  Skill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Skill(
      skillId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}skill_id'],
          )!,
      points:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}points'],
          )!,
    );
  }

  @override
  $SkillsTable createAlias(String alias) {
    return $SkillsTable(attachedDatabase, alias);
  }
}

class Skill extends DataClass implements Insertable<Skill> {
  final String skillId;
  final int points;
  const Skill({required this.skillId, required this.points});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['skill_id'] = Variable<String>(skillId);
    map['points'] = Variable<int>(points);
    return map;
  }

  SkillsCompanion toCompanion(bool nullToAbsent) {
    return SkillsCompanion(skillId: Value(skillId), points: Value(points));
  }

  factory Skill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Skill(
      skillId: serializer.fromJson<String>(json['skillId']),
      points: serializer.fromJson<int>(json['points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'skillId': serializer.toJson<String>(skillId),
      'points': serializer.toJson<int>(points),
    };
  }

  Skill copyWith({String? skillId, int? points}) =>
      Skill(skillId: skillId ?? this.skillId, points: points ?? this.points);
  Skill copyWithCompanion(SkillsCompanion data) {
    return Skill(
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      points: data.points.present ? data.points.value : this.points,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Skill(')
          ..write('skillId: $skillId, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(skillId, points);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Skill &&
          other.skillId == this.skillId &&
          other.points == this.points);
}

class SkillsCompanion extends UpdateCompanion<Skill> {
  final Value<String> skillId;
  final Value<int> points;
  final Value<int> rowid;
  const SkillsCompanion({
    this.skillId = const Value.absent(),
    this.points = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillsCompanion.insert({
    required String skillId,
    this.points = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : skillId = Value(skillId);
  static Insertable<Skill> custom({
    Expression<String>? skillId,
    Expression<int>? points,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (skillId != null) 'skill_id': skillId,
      if (points != null) 'points': points,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillsCompanion copyWith({
    Value<String>? skillId,
    Value<int>? points,
    Value<int>? rowid,
  }) {
    return SkillsCompanion(
      skillId: skillId ?? this.skillId,
      points: points ?? this.points,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (skillId.present) {
      map['skill_id'] = Variable<String>(skillId.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillsCompanion(')
          ..write('skillId: $skillId, ')
          ..write('points: $points, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _badgeIdMeta = const VerificationMeta(
    'badgeId',
  );
  @override
  late final GeneratedColumn<String> badgeId = GeneratedColumn<String>(
    'badge_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _earnedAtMeta = const VerificationMeta(
    'earnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> earnedAt = GeneratedColumn<DateTime>(
    'earned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [badgeId, earnedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Badge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('badge_id')) {
      context.handle(
        _badgeIdMeta,
        badgeId.isAcceptableOrUnknown(data['badge_id']!, _badgeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_badgeIdMeta);
    }
    if (data.containsKey('earned_at')) {
      context.handle(
        _earnedAtMeta,
        earnedAt.isAcceptableOrUnknown(data['earned_at']!, _earnedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_earnedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {badgeId};
  @override
  Badge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Badge(
      badgeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}badge_id'],
          )!,
      earnedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}earned_at'],
          )!,
    );
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(attachedDatabase, alias);
  }
}

class Badge extends DataClass implements Insertable<Badge> {
  final String badgeId;
  final DateTime earnedAt;
  const Badge({required this.badgeId, required this.earnedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['badge_id'] = Variable<String>(badgeId);
    map['earned_at'] = Variable<DateTime>(earnedAt);
    return map;
  }

  BadgesCompanion toCompanion(bool nullToAbsent) {
    return BadgesCompanion(badgeId: Value(badgeId), earnedAt: Value(earnedAt));
  }

  factory Badge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Badge(
      badgeId: serializer.fromJson<String>(json['badgeId']),
      earnedAt: serializer.fromJson<DateTime>(json['earnedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'badgeId': serializer.toJson<String>(badgeId),
      'earnedAt': serializer.toJson<DateTime>(earnedAt),
    };
  }

  Badge copyWith({String? badgeId, DateTime? earnedAt}) => Badge(
    badgeId: badgeId ?? this.badgeId,
    earnedAt: earnedAt ?? this.earnedAt,
  );
  Badge copyWithCompanion(BadgesCompanion data) {
    return Badge(
      badgeId: data.badgeId.present ? data.badgeId.value : this.badgeId,
      earnedAt: data.earnedAt.present ? data.earnedAt.value : this.earnedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Badge(')
          ..write('badgeId: $badgeId, ')
          ..write('earnedAt: $earnedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(badgeId, earnedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Badge &&
          other.badgeId == this.badgeId &&
          other.earnedAt == this.earnedAt);
}

class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<String> badgeId;
  final Value<DateTime> earnedAt;
  final Value<int> rowid;
  const BadgesCompanion({
    this.badgeId = const Value.absent(),
    this.earnedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BadgesCompanion.insert({
    required String badgeId,
    required DateTime earnedAt,
    this.rowid = const Value.absent(),
  }) : badgeId = Value(badgeId),
       earnedAt = Value(earnedAt);
  static Insertable<Badge> custom({
    Expression<String>? badgeId,
    Expression<DateTime>? earnedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (badgeId != null) 'badge_id': badgeId,
      if (earnedAt != null) 'earned_at': earnedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BadgesCompanion copyWith({
    Value<String>? badgeId,
    Value<DateTime>? earnedAt,
    Value<int>? rowid,
  }) {
    return BadgesCompanion(
      badgeId: badgeId ?? this.badgeId,
      earnedAt: earnedAt ?? this.earnedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (badgeId.present) {
      map['badge_id'] = Variable<String>(badgeId.value);
    }
    if (earnedAt.present) {
      map['earned_at'] = Variable<DateTime>(earnedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgesCompanion(')
          ..write('badgeId: $badgeId, ')
          ..write('earnedAt: $earnedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaybookTable extends Playbook
    with TableInfo<$PlaybookTable, PlaybookData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaybookTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerTagMeta = const VerificationMeta(
    'triggerTag',
  );
  @override
  late final GeneratedColumn<String> triggerTag = GeneratedColumn<String>(
    'trigger_tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ifTextMeta = const VerificationMeta('ifText');
  @override
  late final GeneratedColumn<String> ifText = GeneratedColumn<String>(
    'if_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thenTextMeta = const VerificationMeta(
    'thenText',
  );
  @override
  late final GeneratedColumn<String> thenText = GeneratedColumn<String>(
    'then_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, triggerTag, ifText, thenText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playbook';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaybookData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trigger_tag')) {
      context.handle(
        _triggerTagMeta,
        triggerTag.isAcceptableOrUnknown(data['trigger_tag']!, _triggerTagMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerTagMeta);
    }
    if (data.containsKey('if_text')) {
      context.handle(
        _ifTextMeta,
        ifText.isAcceptableOrUnknown(data['if_text']!, _ifTextMeta),
      );
    } else if (isInserting) {
      context.missing(_ifTextMeta);
    }
    if (data.containsKey('then_text')) {
      context.handle(
        _thenTextMeta,
        thenText.isAcceptableOrUnknown(data['then_text']!, _thenTextMeta),
      );
    } else if (isInserting) {
      context.missing(_thenTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaybookData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaybookData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      triggerTag:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trigger_tag'],
          )!,
      ifText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}if_text'],
          )!,
      thenText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}then_text'],
          )!,
    );
  }

  @override
  $PlaybookTable createAlias(String alias) {
    return $PlaybookTable(attachedDatabase, alias);
  }
}

class PlaybookData extends DataClass implements Insertable<PlaybookData> {
  final String id;
  final String triggerTag;
  final String ifText;
  final String thenText;
  const PlaybookData({
    required this.id,
    required this.triggerTag,
    required this.ifText,
    required this.thenText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trigger_tag'] = Variable<String>(triggerTag);
    map['if_text'] = Variable<String>(ifText);
    map['then_text'] = Variable<String>(thenText);
    return map;
  }

  PlaybookCompanion toCompanion(bool nullToAbsent) {
    return PlaybookCompanion(
      id: Value(id),
      triggerTag: Value(triggerTag),
      ifText: Value(ifText),
      thenText: Value(thenText),
    );
  }

  factory PlaybookData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaybookData(
      id: serializer.fromJson<String>(json['id']),
      triggerTag: serializer.fromJson<String>(json['triggerTag']),
      ifText: serializer.fromJson<String>(json['ifText']),
      thenText: serializer.fromJson<String>(json['thenText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'triggerTag': serializer.toJson<String>(triggerTag),
      'ifText': serializer.toJson<String>(ifText),
      'thenText': serializer.toJson<String>(thenText),
    };
  }

  PlaybookData copyWith({
    String? id,
    String? triggerTag,
    String? ifText,
    String? thenText,
  }) => PlaybookData(
    id: id ?? this.id,
    triggerTag: triggerTag ?? this.triggerTag,
    ifText: ifText ?? this.ifText,
    thenText: thenText ?? this.thenText,
  );
  PlaybookData copyWithCompanion(PlaybookCompanion data) {
    return PlaybookData(
      id: data.id.present ? data.id.value : this.id,
      triggerTag:
          data.triggerTag.present ? data.triggerTag.value : this.triggerTag,
      ifText: data.ifText.present ? data.ifText.value : this.ifText,
      thenText: data.thenText.present ? data.thenText.value : this.thenText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaybookData(')
          ..write('id: $id, ')
          ..write('triggerTag: $triggerTag, ')
          ..write('ifText: $ifText, ')
          ..write('thenText: $thenText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, triggerTag, ifText, thenText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaybookData &&
          other.id == this.id &&
          other.triggerTag == this.triggerTag &&
          other.ifText == this.ifText &&
          other.thenText == this.thenText);
}

class PlaybookCompanion extends UpdateCompanion<PlaybookData> {
  final Value<String> id;
  final Value<String> triggerTag;
  final Value<String> ifText;
  final Value<String> thenText;
  final Value<int> rowid;
  const PlaybookCompanion({
    this.id = const Value.absent(),
    this.triggerTag = const Value.absent(),
    this.ifText = const Value.absent(),
    this.thenText = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaybookCompanion.insert({
    required String id,
    required String triggerTag,
    required String ifText,
    required String thenText,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       triggerTag = Value(triggerTag),
       ifText = Value(ifText),
       thenText = Value(thenText);
  static Insertable<PlaybookData> custom({
    Expression<String>? id,
    Expression<String>? triggerTag,
    Expression<String>? ifText,
    Expression<String>? thenText,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (triggerTag != null) 'trigger_tag': triggerTag,
      if (ifText != null) 'if_text': ifText,
      if (thenText != null) 'then_text': thenText,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaybookCompanion copyWith({
    Value<String>? id,
    Value<String>? triggerTag,
    Value<String>? ifText,
    Value<String>? thenText,
    Value<int>? rowid,
  }) {
    return PlaybookCompanion(
      id: id ?? this.id,
      triggerTag: triggerTag ?? this.triggerTag,
      ifText: ifText ?? this.ifText,
      thenText: thenText ?? this.thenText,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (triggerTag.present) {
      map['trigger_tag'] = Variable<String>(triggerTag.value);
    }
    if (ifText.present) {
      map['if_text'] = Variable<String>(ifText.value);
    }
    if (thenText.present) {
      map['then_text'] = Variable<String>(thenText.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaybookCompanion(')
          ..write('id: $id, ')
          ..write('triggerTag: $triggerTag, ')
          ..write('ifText: $ifText, ')
          ..write('thenText: $thenText, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LettersTable extends Letters with TableInfo<$LettersTable, Letter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LettersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, title, body];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'letters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Letter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Letter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Letter(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      body:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}body'],
          )!,
    );
  }

  @override
  $LettersTable createAlias(String alias) {
    return $LettersTable(attachedDatabase, alias);
  }
}

class Letter extends DataClass implements Insertable<Letter> {
  final String id;
  final DateTime createdAt;
  final String title;
  final String body;
  const Letter({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    return map;
  }

  LettersCompanion toCompanion(bool nullToAbsent) {
    return LettersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      title: Value(title),
      body: Value(body),
    );
  }

  factory Letter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Letter(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
    };
  }

  Letter copyWith({
    String? id,
    DateTime? createdAt,
    String? title,
    String? body,
  }) => Letter(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    title: title ?? this.title,
    body: body ?? this.body,
  );
  Letter copyWithCompanion(LettersCompanion data) {
    return Letter(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Letter(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, title, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Letter &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.title == this.title &&
          other.body == this.body);
}

class LettersCompanion extends UpdateCompanion<Letter> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> title;
  final Value<String> body;
  final Value<int> rowid;
  const LettersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LettersCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String title,
    required String body,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       title = Value(title),
       body = Value(body);
  static Insertable<Letter> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? title,
    Expression<String>? body,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LettersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? title,
    Value<String>? body,
    Value<int>? rowid,
  }) {
    return LettersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      body: body ?? this.body,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LettersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LifeWheelTable extends LifeWheel
    with TableInfo<$LifeWheelTable, LifeWheelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LifeWheelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, area, score];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'life_wheel';
  @override
  VerificationContext validateIntegrity(
    Insertable<LifeWheelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LifeWheelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LifeWheelData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      area:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}area'],
          )!,
      score:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}score'],
          )!,
    );
  }

  @override
  $LifeWheelTable createAlias(String alias) {
    return $LifeWheelTable(attachedDatabase, alias);
  }
}

class LifeWheelData extends DataClass implements Insertable<LifeWheelData> {
  final String id;
  final DateTime date;
  final String area;
  final int score;
  const LifeWheelData({
    required this.id,
    required this.date,
    required this.area,
    required this.score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['area'] = Variable<String>(area);
    map['score'] = Variable<int>(score);
    return map;
  }

  LifeWheelCompanion toCompanion(bool nullToAbsent) {
    return LifeWheelCompanion(
      id: Value(id),
      date: Value(date),
      area: Value(area),
      score: Value(score),
    );
  }

  factory LifeWheelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LifeWheelData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      area: serializer.fromJson<String>(json['area']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'area': serializer.toJson<String>(area),
      'score': serializer.toJson<int>(score),
    };
  }

  LifeWheelData copyWith({
    String? id,
    DateTime? date,
    String? area,
    int? score,
  }) => LifeWheelData(
    id: id ?? this.id,
    date: date ?? this.date,
    area: area ?? this.area,
    score: score ?? this.score,
  );
  LifeWheelData copyWithCompanion(LifeWheelCompanion data) {
    return LifeWheelData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      area: data.area.present ? data.area.value : this.area,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LifeWheelData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('area: $area, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, area, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LifeWheelData &&
          other.id == this.id &&
          other.date == this.date &&
          other.area == this.area &&
          other.score == this.score);
}

class LifeWheelCompanion extends UpdateCompanion<LifeWheelData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> area;
  final Value<int> score;
  final Value<int> rowid;
  const LifeWheelCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.area = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LifeWheelCompanion.insert({
    required String id,
    required DateTime date,
    required String area,
    required int score,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       area = Value(area),
       score = Value(score);
  static Insertable<LifeWheelData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? area,
    Expression<int>? score,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (area != null) 'area': area,
      if (score != null) 'score': score,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LifeWheelCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? area,
    Value<int>? score,
    Value<int>? rowid,
  }) {
    return LifeWheelCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      area: area ?? this.area,
      score: score ?? this.score,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LifeWheelCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('area: $area, ')
          ..write('score: $score, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $StreakEventsTable streakEvents = $StreakEventsTable(this);
  late final $UrgesTable urges = $UrgesTable(this);
  late final $SlipsTable slips = $SlipsTable(this);
  late final $CheckinsTable checkins = $CheckinsTable(this);
  late final $MissionProgressTable missionProgress = $MissionProgressTable(
    this,
  );
  late final $UserStateTable userState = $UserStateTable(this);
  late final $SkillsTable skills = $SkillsTable(this);
  late final $BadgesTable badges = $BadgesTable(this);
  late final $PlaybookTable playbook = $PlaybookTable(this);
  late final $LettersTable letters = $LettersTable(this);
  late final $LifeWheelTable lifeWheel = $LifeWheelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    streakEvents,
    urges,
    slips,
    checkins,
    missionProgress,
    userState,
    skills,
    badges,
    playbook,
    letters,
    lifeWheel,
  ];
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      required String name,
      required String type,
      required String goal,
      required DateTime startAt,
      required String why,
      Value<String?> whyPhotoPath,
      Value<String> dangerTimes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String> goal,
      Value<DateTime> startAt,
      Value<String> why,
      Value<String?> whyPhotoPath,
      Value<String> dangerTimes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whyPhotoPath => $composableBuilder(
    column: $table.whyPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dangerTimes => $composableBuilder(
    column: $table.dangerTimes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whyPhotoPath => $composableBuilder(
    column: $table.whyPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dangerTimes => $composableBuilder(
    column: $table.dangerTimes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<String> get why =>
      $composableBuilder(column: $table.why, builder: (column) => column);

  GeneratedColumn<String> get whyPhotoPath => $composableBuilder(
    column: $table.whyPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dangerTimes => $composableBuilder(
    column: $table.dangerTimes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
          Habit,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<String> why = const Value.absent(),
                Value<String?> whyPhotoPath = const Value.absent(),
                Value<String> dangerTimes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                type: type,
                goal: goal,
                startAt: startAt,
                why: why,
                whyPhotoPath: whyPhotoPath,
                dangerTimes: dangerTimes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required String goal,
                required DateTime startAt,
                required String why,
                Value<String?> whyPhotoPath = const Value.absent(),
                Value<String> dangerTimes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                type: type,
                goal: goal,
                startAt: startAt,
                why: why,
                whyPhotoPath: whyPhotoPath,
                dangerTimes: dangerTimes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
      Habit,
      PrefetchHooks Function()
    >;
typedef $$StreakEventsTableCreateCompanionBuilder =
    StreakEventsCompanion Function({
      required String id,
      required String habitId,
      required DateTime startAt,
      required DateTime endAt,
      required String endReason,
      Value<int> rowid,
    });
typedef $$StreakEventsTableUpdateCompanionBuilder =
    StreakEventsCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> startAt,
      Value<DateTime> endAt,
      Value<String> endReason,
      Value<int> rowid,
    });

class $$StreakEventsTableFilterComposer
    extends Composer<_$AppDatabase, $StreakEventsTable> {
  $$StreakEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StreakEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $StreakEventsTable> {
  $$StreakEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StreakEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StreakEventsTable> {
  $$StreakEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<String> get endReason =>
      $composableBuilder(column: $table.endReason, builder: (column) => column);
}

class $$StreakEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StreakEventsTable,
          StreakEvent,
          $$StreakEventsTableFilterComposer,
          $$StreakEventsTableOrderingComposer,
          $$StreakEventsTableAnnotationComposer,
          $$StreakEventsTableCreateCompanionBuilder,
          $$StreakEventsTableUpdateCompanionBuilder,
          (
            StreakEvent,
            BaseReferences<_$AppDatabase, $StreakEventsTable, StreakEvent>,
          ),
          StreakEvent,
          PrefetchHooks Function()
        > {
  $$StreakEventsTableTableManager(_$AppDatabase db, $StreakEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StreakEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$StreakEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$StreakEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime> endAt = const Value.absent(),
                Value<String> endReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StreakEventsCompanion(
                id: id,
                habitId: habitId,
                startAt: startAt,
                endAt: endAt,
                endReason: endReason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime startAt,
                required DateTime endAt,
                required String endReason,
                Value<int> rowid = const Value.absent(),
              }) => StreakEventsCompanion.insert(
                id: id,
                habitId: habitId,
                startAt: startAt,
                endAt: endAt,
                endReason: endReason,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StreakEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StreakEventsTable,
      StreakEvent,
      $$StreakEventsTableFilterComposer,
      $$StreakEventsTableOrderingComposer,
      $$StreakEventsTableAnnotationComposer,
      $$StreakEventsTableCreateCompanionBuilder,
      $$StreakEventsTableUpdateCompanionBuilder,
      (
        StreakEvent,
        BaseReferences<_$AppDatabase, $StreakEventsTable, StreakEvent>,
      ),
      StreakEvent,
      PrefetchHooks Function()
    >;
typedef $$UrgesTableCreateCompanionBuilder =
    UrgesCompanion Function({
      required String id,
      required String habitId,
      required DateTime at,
      required int strengthBefore,
      Value<int?> strengthAfter,
      Value<String?> triggerTag,
      Value<bool> usedSos,
      required String outcome,
      Value<int> rowid,
    });
typedef $$UrgesTableUpdateCompanionBuilder =
    UrgesCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> at,
      Value<int> strengthBefore,
      Value<int?> strengthAfter,
      Value<String?> triggerTag,
      Value<bool> usedSos,
      Value<String> outcome,
      Value<int> rowid,
    });

class $$UrgesTableFilterComposer extends Composer<_$AppDatabase, $UrgesTable> {
  $$UrgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strengthBefore => $composableBuilder(
    column: $table.strengthBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strengthAfter => $composableBuilder(
    column: $table.strengthAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerTag => $composableBuilder(
    column: $table.triggerTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get usedSos => $composableBuilder(
    column: $table.usedSos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UrgesTableOrderingComposer
    extends Composer<_$AppDatabase, $UrgesTable> {
  $$UrgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strengthBefore => $composableBuilder(
    column: $table.strengthBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strengthAfter => $composableBuilder(
    column: $table.strengthAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerTag => $composableBuilder(
    column: $table.triggerTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get usedSos => $composableBuilder(
    column: $table.usedSos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UrgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UrgesTable> {
  $$UrgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<int> get strengthBefore => $composableBuilder(
    column: $table.strengthBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get strengthAfter => $composableBuilder(
    column: $table.strengthAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get triggerTag => $composableBuilder(
    column: $table.triggerTag,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get usedSos =>
      $composableBuilder(column: $table.usedSos, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);
}

class $$UrgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UrgesTable,
          Urge,
          $$UrgesTableFilterComposer,
          $$UrgesTableOrderingComposer,
          $$UrgesTableAnnotationComposer,
          $$UrgesTableCreateCompanionBuilder,
          $$UrgesTableUpdateCompanionBuilder,
          (Urge, BaseReferences<_$AppDatabase, $UrgesTable, Urge>),
          Urge,
          PrefetchHooks Function()
        > {
  $$UrgesTableTableManager(_$AppDatabase db, $UrgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UrgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UrgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UrgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<int> strengthBefore = const Value.absent(),
                Value<int?> strengthAfter = const Value.absent(),
                Value<String?> triggerTag = const Value.absent(),
                Value<bool> usedSos = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UrgesCompanion(
                id: id,
                habitId: habitId,
                at: at,
                strengthBefore: strengthBefore,
                strengthAfter: strengthAfter,
                triggerTag: triggerTag,
                usedSos: usedSos,
                outcome: outcome,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime at,
                required int strengthBefore,
                Value<int?> strengthAfter = const Value.absent(),
                Value<String?> triggerTag = const Value.absent(),
                Value<bool> usedSos = const Value.absent(),
                required String outcome,
                Value<int> rowid = const Value.absent(),
              }) => UrgesCompanion.insert(
                id: id,
                habitId: habitId,
                at: at,
                strengthBefore: strengthBefore,
                strengthAfter: strengthAfter,
                triggerTag: triggerTag,
                usedSos: usedSos,
                outcome: outcome,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UrgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UrgesTable,
      Urge,
      $$UrgesTableFilterComposer,
      $$UrgesTableOrderingComposer,
      $$UrgesTableAnnotationComposer,
      $$UrgesTableCreateCompanionBuilder,
      $$UrgesTableUpdateCompanionBuilder,
      (Urge, BaseReferences<_$AppDatabase, $UrgesTable, Urge>),
      Urge,
      PrefetchHooks Function()
    >;
typedef $$SlipsTableCreateCompanionBuilder =
    SlipsCompanion Function({
      required String id,
      required String habitId,
      required DateTime at,
      required String trigger,
      Value<String?> note,
      Value<String?> changePlan,
      Value<bool> shieldUsed,
      Value<int> rowid,
    });
typedef $$SlipsTableUpdateCompanionBuilder =
    SlipsCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> at,
      Value<String> trigger,
      Value<String?> note,
      Value<String?> changePlan,
      Value<bool> shieldUsed,
      Value<int> rowid,
    });

class $$SlipsTableFilterComposer extends Composer<_$AppDatabase, $SlipsTable> {
  $$SlipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changePlan => $composableBuilder(
    column: $table.changePlan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get shieldUsed => $composableBuilder(
    column: $table.shieldUsed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SlipsTableOrderingComposer
    extends Composer<_$AppDatabase, $SlipsTable> {
  $$SlipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changePlan => $composableBuilder(
    column: $table.changePlan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get shieldUsed => $composableBuilder(
    column: $table.shieldUsed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SlipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SlipsTable> {
  $$SlipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get changePlan => $composableBuilder(
    column: $table.changePlan,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get shieldUsed => $composableBuilder(
    column: $table.shieldUsed,
    builder: (column) => column,
  );
}

class $$SlipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SlipsTable,
          Slip,
          $$SlipsTableFilterComposer,
          $$SlipsTableOrderingComposer,
          $$SlipsTableAnnotationComposer,
          $$SlipsTableCreateCompanionBuilder,
          $$SlipsTableUpdateCompanionBuilder,
          (Slip, BaseReferences<_$AppDatabase, $SlipsTable, Slip>),
          Slip,
          PrefetchHooks Function()
        > {
  $$SlipsTableTableManager(_$AppDatabase db, $SlipsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SlipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SlipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SlipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> changePlan = const Value.absent(),
                Value<bool> shieldUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SlipsCompanion(
                id: id,
                habitId: habitId,
                at: at,
                trigger: trigger,
                note: note,
                changePlan: changePlan,
                shieldUsed: shieldUsed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime at,
                required String trigger,
                Value<String?> note = const Value.absent(),
                Value<String?> changePlan = const Value.absent(),
                Value<bool> shieldUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SlipsCompanion.insert(
                id: id,
                habitId: habitId,
                at: at,
                trigger: trigger,
                note: note,
                changePlan: changePlan,
                shieldUsed: shieldUsed,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SlipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SlipsTable,
      Slip,
      $$SlipsTableFilterComposer,
      $$SlipsTableOrderingComposer,
      $$SlipsTableAnnotationComposer,
      $$SlipsTableCreateCompanionBuilder,
      $$SlipsTableUpdateCompanionBuilder,
      (Slip, BaseReferences<_$AppDatabase, $SlipsTable, Slip>),
      Slip,
      PrefetchHooks Function()
    >;
typedef $$CheckinsTableCreateCompanionBuilder =
    CheckinsCompanion Function({
      required String id,
      required DateTime date,
      required int mood,
      required int stress,
      required double sleepHours,
      required int urgeLevel,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$CheckinsTableUpdateCompanionBuilder =
    CheckinsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<int> mood,
      Value<int> stress,
      Value<double> sleepHours,
      Value<int> urgeLevel,
      Value<String?> note,
      Value<int> rowid,
    });

class $$CheckinsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckinsTable> {
  $$CheckinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stress => $composableBuilder(
    column: $table.stress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urgeLevel => $composableBuilder(
    column: $table.urgeLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheckinsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckinsTable> {
  $$CheckinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stress => $composableBuilder(
    column: $table.stress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urgeLevel => $composableBuilder(
    column: $table.urgeLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckinsTable> {
  $$CheckinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<int> get stress =>
      $composableBuilder(column: $table.stress, builder: (column) => column);

  GeneratedColumn<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get urgeLevel =>
      $composableBuilder(column: $table.urgeLevel, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$CheckinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckinsTable,
          Checkin,
          $$CheckinsTableFilterComposer,
          $$CheckinsTableOrderingComposer,
          $$CheckinsTableAnnotationComposer,
          $$CheckinsTableCreateCompanionBuilder,
          $$CheckinsTableUpdateCompanionBuilder,
          (Checkin, BaseReferences<_$AppDatabase, $CheckinsTable, Checkin>),
          Checkin,
          PrefetchHooks Function()
        > {
  $$CheckinsTableTableManager(_$AppDatabase db, $CheckinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CheckinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CheckinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CheckinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mood = const Value.absent(),
                Value<int> stress = const Value.absent(),
                Value<double> sleepHours = const Value.absent(),
                Value<int> urgeLevel = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckinsCompanion(
                id: id,
                date: date,
                mood: mood,
                stress: stress,
                sleepHours: sleepHours,
                urgeLevel: urgeLevel,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required int mood,
                required int stress,
                required double sleepHours,
                required int urgeLevel,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckinsCompanion.insert(
                id: id,
                date: date,
                mood: mood,
                stress: stress,
                sleepHours: sleepHours,
                urgeLevel: urgeLevel,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheckinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckinsTable,
      Checkin,
      $$CheckinsTableFilterComposer,
      $$CheckinsTableOrderingComposer,
      $$CheckinsTableAnnotationComposer,
      $$CheckinsTableCreateCompanionBuilder,
      $$CheckinsTableUpdateCompanionBuilder,
      (Checkin, BaseReferences<_$AppDatabase, $CheckinsTable, Checkin>),
      Checkin,
      PrefetchHooks Function()
    >;
typedef $$MissionProgressTableCreateCompanionBuilder =
    MissionProgressCompanion Function({
      required String id,
      required String missionId,
      required DateTime date,
      required String status,
      Value<int> xpAwarded,
      Value<int> rowid,
    });
typedef $$MissionProgressTableUpdateCompanionBuilder =
    MissionProgressCompanion Function({
      Value<String> id,
      Value<String> missionId,
      Value<DateTime> date,
      Value<String> status,
      Value<int> xpAwarded,
      Value<int> rowid,
    });

class $$MissionProgressTableFilterComposer
    extends Composer<_$AppDatabase, $MissionProgressTable> {
  $$MissionProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get missionId => $composableBuilder(
    column: $table.missionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MissionProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $MissionProgressTable> {
  $$MissionProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get missionId => $composableBuilder(
    column: $table.missionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MissionProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $MissionProgressTable> {
  $$MissionProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get missionId =>
      $composableBuilder(column: $table.missionId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get xpAwarded =>
      $composableBuilder(column: $table.xpAwarded, builder: (column) => column);
}

class $$MissionProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MissionProgressTable,
          MissionProgressData,
          $$MissionProgressTableFilterComposer,
          $$MissionProgressTableOrderingComposer,
          $$MissionProgressTableAnnotationComposer,
          $$MissionProgressTableCreateCompanionBuilder,
          $$MissionProgressTableUpdateCompanionBuilder,
          (
            MissionProgressData,
            BaseReferences<
              _$AppDatabase,
              $MissionProgressTable,
              MissionProgressData
            >,
          ),
          MissionProgressData,
          PrefetchHooks Function()
        > {
  $$MissionProgressTableTableManager(
    _$AppDatabase db,
    $MissionProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$MissionProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MissionProgressTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$MissionProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> missionId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MissionProgressCompanion(
                id: id,
                missionId: missionId,
                date: date,
                status: status,
                xpAwarded: xpAwarded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String missionId,
                required DateTime date,
                required String status,
                Value<int> xpAwarded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MissionProgressCompanion.insert(
                id: id,
                missionId: missionId,
                date: date,
                status: status,
                xpAwarded: xpAwarded,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MissionProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MissionProgressTable,
      MissionProgressData,
      $$MissionProgressTableFilterComposer,
      $$MissionProgressTableOrderingComposer,
      $$MissionProgressTableAnnotationComposer,
      $$MissionProgressTableCreateCompanionBuilder,
      $$MissionProgressTableUpdateCompanionBuilder,
      (
        MissionProgressData,
        BaseReferences<
          _$AppDatabase,
          $MissionProgressTable,
          MissionProgressData
        >,
      ),
      MissionProgressData,
      PrefetchHooks Function()
    >;
typedef $$UserStateTableCreateCompanionBuilder =
    UserStateCompanion Function({
      required String id,
      Value<int> xp,
      Value<int> level,
      Value<int> currentStage,
      Value<int> currentWeek,
      required DateTime weekStartAt,
      Value<int> shields,
      Value<int> rowid,
    });
typedef $$UserStateTableUpdateCompanionBuilder =
    UserStateCompanion Function({
      Value<String> id,
      Value<int> xp,
      Value<int> level,
      Value<int> currentStage,
      Value<int> currentWeek,
      Value<DateTime> weekStartAt,
      Value<int> shields,
      Value<int> rowid,
    });

class $$UserStateTableFilterComposer
    extends Composer<_$AppDatabase, $UserStateTable> {
  $$UserStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentWeek => $composableBuilder(
    column: $table.currentWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStartAt => $composableBuilder(
    column: $table.weekStartAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shields => $composableBuilder(
    column: $table.shields,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserStateTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStateTable> {
  $$UserStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentWeek => $composableBuilder(
    column: $table.currentWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStartAt => $composableBuilder(
    column: $table.weekStartAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shields => $composableBuilder(
    column: $table.shields,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStateTable> {
  $$UserStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentWeek => $composableBuilder(
    column: $table.currentWeek,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get weekStartAt => $composableBuilder(
    column: $table.weekStartAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shields =>
      $composableBuilder(column: $table.shields, builder: (column) => column);
}

class $$UserStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserStateTable,
          UserStateData,
          $$UserStateTableFilterComposer,
          $$UserStateTableOrderingComposer,
          $$UserStateTableAnnotationComposer,
          $$UserStateTableCreateCompanionBuilder,
          $$UserStateTableUpdateCompanionBuilder,
          (
            UserStateData,
            BaseReferences<_$AppDatabase, $UserStateTable, UserStateData>,
          ),
          UserStateData,
          PrefetchHooks Function()
        > {
  $$UserStateTableTableManager(_$AppDatabase db, $UserStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UserStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentStage = const Value.absent(),
                Value<int> currentWeek = const Value.absent(),
                Value<DateTime> weekStartAt = const Value.absent(),
                Value<int> shields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserStateCompanion(
                id: id,
                xp: xp,
                level: level,
                currentStage: currentStage,
                currentWeek: currentWeek,
                weekStartAt: weekStartAt,
                shields: shields,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> xp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentStage = const Value.absent(),
                Value<int> currentWeek = const Value.absent(),
                required DateTime weekStartAt,
                Value<int> shields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserStateCompanion.insert(
                id: id,
                xp: xp,
                level: level,
                currentStage: currentStage,
                currentWeek: currentWeek,
                weekStartAt: weekStartAt,
                shields: shields,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserStateTable,
      UserStateData,
      $$UserStateTableFilterComposer,
      $$UserStateTableOrderingComposer,
      $$UserStateTableAnnotationComposer,
      $$UserStateTableCreateCompanionBuilder,
      $$UserStateTableUpdateCompanionBuilder,
      (
        UserStateData,
        BaseReferences<_$AppDatabase, $UserStateTable, UserStateData>,
      ),
      UserStateData,
      PrefetchHooks Function()
    >;
typedef $$SkillsTableCreateCompanionBuilder =
    SkillsCompanion Function({
      required String skillId,
      Value<int> points,
      Value<int> rowid,
    });
typedef $$SkillsTableUpdateCompanionBuilder =
    SkillsCompanion Function({
      Value<String> skillId,
      Value<int> points,
      Value<int> rowid,
    });

class $$SkillsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get skillId =>
      $composableBuilder(column: $table.skillId, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);
}

class $$SkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillsTable,
          Skill,
          $$SkillsTableFilterComposer,
          $$SkillsTableOrderingComposer,
          $$SkillsTableAnnotationComposer,
          $$SkillsTableCreateCompanionBuilder,
          $$SkillsTableUpdateCompanionBuilder,
          (Skill, BaseReferences<_$AppDatabase, $SkillsTable, Skill>),
          Skill,
          PrefetchHooks Function()
        > {
  $$SkillsTableTableManager(_$AppDatabase db, $SkillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> skillId = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillsCompanion(
                skillId: skillId,
                points: points,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String skillId,
                Value<int> points = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillsCompanion.insert(
                skillId: skillId,
                points: points,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillsTable,
      Skill,
      $$SkillsTableFilterComposer,
      $$SkillsTableOrderingComposer,
      $$SkillsTableAnnotationComposer,
      $$SkillsTableCreateCompanionBuilder,
      $$SkillsTableUpdateCompanionBuilder,
      (Skill, BaseReferences<_$AppDatabase, $SkillsTable, Skill>),
      Skill,
      PrefetchHooks Function()
    >;
typedef $$BadgesTableCreateCompanionBuilder =
    BadgesCompanion Function({
      required String badgeId,
      required DateTime earnedAt,
      Value<int> rowid,
    });
typedef $$BadgesTableUpdateCompanionBuilder =
    BadgesCompanion Function({
      Value<String> badgeId,
      Value<DateTime> earnedAt,
      Value<int> rowid,
    });

class $$BadgesTableFilterComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BadgesTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BadgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get badgeId =>
      $composableBuilder(column: $table.badgeId, builder: (column) => column);

  GeneratedColumn<DateTime> get earnedAt =>
      $composableBuilder(column: $table.earnedAt, builder: (column) => column);
}

class $$BadgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BadgesTable,
          Badge,
          $$BadgesTableFilterComposer,
          $$BadgesTableOrderingComposer,
          $$BadgesTableAnnotationComposer,
          $$BadgesTableCreateCompanionBuilder,
          $$BadgesTableUpdateCompanionBuilder,
          (Badge, BaseReferences<_$AppDatabase, $BadgesTable, Badge>),
          Badge,
          PrefetchHooks Function()
        > {
  $$BadgesTableTableManager(_$AppDatabase db, $BadgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BadgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BadgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BadgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> badgeId = const Value.absent(),
                Value<DateTime> earnedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BadgesCompanion(
                badgeId: badgeId,
                earnedAt: earnedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String badgeId,
                required DateTime earnedAt,
                Value<int> rowid = const Value.absent(),
              }) => BadgesCompanion.insert(
                badgeId: badgeId,
                earnedAt: earnedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BadgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BadgesTable,
      Badge,
      $$BadgesTableFilterComposer,
      $$BadgesTableOrderingComposer,
      $$BadgesTableAnnotationComposer,
      $$BadgesTableCreateCompanionBuilder,
      $$BadgesTableUpdateCompanionBuilder,
      (Badge, BaseReferences<_$AppDatabase, $BadgesTable, Badge>),
      Badge,
      PrefetchHooks Function()
    >;
typedef $$PlaybookTableCreateCompanionBuilder =
    PlaybookCompanion Function({
      required String id,
      required String triggerTag,
      required String ifText,
      required String thenText,
      Value<int> rowid,
    });
typedef $$PlaybookTableUpdateCompanionBuilder =
    PlaybookCompanion Function({
      Value<String> id,
      Value<String> triggerTag,
      Value<String> ifText,
      Value<String> thenText,
      Value<int> rowid,
    });

class $$PlaybookTableFilterComposer
    extends Composer<_$AppDatabase, $PlaybookTable> {
  $$PlaybookTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerTag => $composableBuilder(
    column: $table.triggerTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ifText => $composableBuilder(
    column: $table.ifText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thenText => $composableBuilder(
    column: $table.thenText,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaybookTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaybookTable> {
  $$PlaybookTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerTag => $composableBuilder(
    column: $table.triggerTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ifText => $composableBuilder(
    column: $table.ifText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thenText => $composableBuilder(
    column: $table.thenText,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaybookTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaybookTable> {
  $$PlaybookTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get triggerTag => $composableBuilder(
    column: $table.triggerTag,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ifText =>
      $composableBuilder(column: $table.ifText, builder: (column) => column);

  GeneratedColumn<String> get thenText =>
      $composableBuilder(column: $table.thenText, builder: (column) => column);
}

class $$PlaybookTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaybookTable,
          PlaybookData,
          $$PlaybookTableFilterComposer,
          $$PlaybookTableOrderingComposer,
          $$PlaybookTableAnnotationComposer,
          $$PlaybookTableCreateCompanionBuilder,
          $$PlaybookTableUpdateCompanionBuilder,
          (
            PlaybookData,
            BaseReferences<_$AppDatabase, $PlaybookTable, PlaybookData>,
          ),
          PlaybookData,
          PrefetchHooks Function()
        > {
  $$PlaybookTableTableManager(_$AppDatabase db, $PlaybookTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PlaybookTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PlaybookTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PlaybookTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> triggerTag = const Value.absent(),
                Value<String> ifText = const Value.absent(),
                Value<String> thenText = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaybookCompanion(
                id: id,
                triggerTag: triggerTag,
                ifText: ifText,
                thenText: thenText,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String triggerTag,
                required String ifText,
                required String thenText,
                Value<int> rowid = const Value.absent(),
              }) => PlaybookCompanion.insert(
                id: id,
                triggerTag: triggerTag,
                ifText: ifText,
                thenText: thenText,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaybookTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaybookTable,
      PlaybookData,
      $$PlaybookTableFilterComposer,
      $$PlaybookTableOrderingComposer,
      $$PlaybookTableAnnotationComposer,
      $$PlaybookTableCreateCompanionBuilder,
      $$PlaybookTableUpdateCompanionBuilder,
      (
        PlaybookData,
        BaseReferences<_$AppDatabase, $PlaybookTable, PlaybookData>,
      ),
      PlaybookData,
      PrefetchHooks Function()
    >;
typedef $$LettersTableCreateCompanionBuilder =
    LettersCompanion Function({
      required String id,
      required DateTime createdAt,
      required String title,
      required String body,
      Value<int> rowid,
    });
typedef $$LettersTableUpdateCompanionBuilder =
    LettersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> title,
      Value<String> body,
      Value<int> rowid,
    });

class $$LettersTableFilterComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LettersTableOrderingComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LettersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);
}

class $$LettersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LettersTable,
          Letter,
          $$LettersTableFilterComposer,
          $$LettersTableOrderingComposer,
          $$LettersTableAnnotationComposer,
          $$LettersTableCreateCompanionBuilder,
          $$LettersTableUpdateCompanionBuilder,
          (Letter, BaseReferences<_$AppDatabase, $LettersTable, Letter>),
          Letter,
          PrefetchHooks Function()
        > {
  $$LettersTableTableManager(_$AppDatabase db, $LettersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LettersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LettersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LettersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LettersCompanion(
                id: id,
                createdAt: createdAt,
                title: title,
                body: body,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required String title,
                required String body,
                Value<int> rowid = const Value.absent(),
              }) => LettersCompanion.insert(
                id: id,
                createdAt: createdAt,
                title: title,
                body: body,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LettersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LettersTable,
      Letter,
      $$LettersTableFilterComposer,
      $$LettersTableOrderingComposer,
      $$LettersTableAnnotationComposer,
      $$LettersTableCreateCompanionBuilder,
      $$LettersTableUpdateCompanionBuilder,
      (Letter, BaseReferences<_$AppDatabase, $LettersTable, Letter>),
      Letter,
      PrefetchHooks Function()
    >;
typedef $$LifeWheelTableCreateCompanionBuilder =
    LifeWheelCompanion Function({
      required String id,
      required DateTime date,
      required String area,
      required int score,
      Value<int> rowid,
    });
typedef $$LifeWheelTableUpdateCompanionBuilder =
    LifeWheelCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> area,
      Value<int> score,
      Value<int> rowid,
    });

class $$LifeWheelTableFilterComposer
    extends Composer<_$AppDatabase, $LifeWheelTable> {
  $$LifeWheelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LifeWheelTableOrderingComposer
    extends Composer<_$AppDatabase, $LifeWheelTable> {
  $$LifeWheelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LifeWheelTableAnnotationComposer
    extends Composer<_$AppDatabase, $LifeWheelTable> {
  $$LifeWheelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);
}

class $$LifeWheelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LifeWheelTable,
          LifeWheelData,
          $$LifeWheelTableFilterComposer,
          $$LifeWheelTableOrderingComposer,
          $$LifeWheelTableAnnotationComposer,
          $$LifeWheelTableCreateCompanionBuilder,
          $$LifeWheelTableUpdateCompanionBuilder,
          (
            LifeWheelData,
            BaseReferences<_$AppDatabase, $LifeWheelTable, LifeWheelData>,
          ),
          LifeWheelData,
          PrefetchHooks Function()
        > {
  $$LifeWheelTableTableManager(_$AppDatabase db, $LifeWheelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LifeWheelTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LifeWheelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LifeWheelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> area = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LifeWheelCompanion(
                id: id,
                date: date,
                area: area,
                score: score,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String area,
                required int score,
                Value<int> rowid = const Value.absent(),
              }) => LifeWheelCompanion.insert(
                id: id,
                date: date,
                area: area,
                score: score,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LifeWheelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LifeWheelTable,
      LifeWheelData,
      $$LifeWheelTableFilterComposer,
      $$LifeWheelTableOrderingComposer,
      $$LifeWheelTableAnnotationComposer,
      $$LifeWheelTableCreateCompanionBuilder,
      $$LifeWheelTableUpdateCompanionBuilder,
      (
        LifeWheelData,
        BaseReferences<_$AppDatabase, $LifeWheelTable, LifeWheelData>,
      ),
      LifeWheelData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$StreakEventsTableTableManager get streakEvents =>
      $$StreakEventsTableTableManager(_db, _db.streakEvents);
  $$UrgesTableTableManager get urges =>
      $$UrgesTableTableManager(_db, _db.urges);
  $$SlipsTableTableManager get slips =>
      $$SlipsTableTableManager(_db, _db.slips);
  $$CheckinsTableTableManager get checkins =>
      $$CheckinsTableTableManager(_db, _db.checkins);
  $$MissionProgressTableTableManager get missionProgress =>
      $$MissionProgressTableTableManager(_db, _db.missionProgress);
  $$UserStateTableTableManager get userState =>
      $$UserStateTableTableManager(_db, _db.userState);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db, _db.skills);
  $$BadgesTableTableManager get badges =>
      $$BadgesTableTableManager(_db, _db.badges);
  $$PlaybookTableTableManager get playbook =>
      $$PlaybookTableTableManager(_db, _db.playbook);
  $$LettersTableTableManager get letters =>
      $$LettersTableTableManager(_db, _db.letters);
  $$LifeWheelTableTableManager get lifeWheel =>
      $$LifeWheelTableTableManager(_db, _db.lifeWheel);
}
