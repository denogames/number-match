// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GameSessionsTableTable extends GameSessionsTable
    with TableInfo<$GameSessionsTableTable, GameSessionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boardJsonMeta = const VerificationMeta(
    'boardJson',
  );
  @override
  late final GeneratedColumn<String> boardJson = GeneratedColumn<String>(
    'board_json',
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _comboMeta = const VerificationMeta('combo');
  @override
  late final GeneratedColumn<int> combo = GeneratedColumn<int>(
    'combo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _maxComboMeta = const VerificationMeta(
    'maxCombo',
  );
  @override
  late final GeneratedColumn<int> maxCombo = GeneratedColumn<int>(
    'max_combo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _matchesCountMeta = const VerificationMeta(
    'matchesCount',
  );
  @override
  late final GeneratedColumn<int> matchesCount = GeneratedColumn<int>(
    'matches_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _addsCountMeta = const VerificationMeta(
    'addsCount',
  );
  @override
  late final GeneratedColumn<int> addsCount = GeneratedColumn<int>(
    'adds_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _elapsedSecondsMeta = const VerificationMeta(
    'elapsedSeconds',
  );
  @override
  late final GeneratedColumn<int> elapsedSeconds = GeneratedColumn<int>(
    'elapsed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _selectedIndexMeta = const VerificationMeta(
    'selectedIndex',
  );
  @override
  late final GeneratedColumn<int> selectedIndex = GeneratedColumn<int>(
    'selected_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isWonMeta = const VerificationMeta('isWon');
  @override
  late final GeneratedColumn<bool> isWon = GeneratedColumn<bool>(
    'is_won',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_won" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _targetScoreMeta = const VerificationMeta(
    'targetScore',
  );
  @override
  late final GeneratedColumn<int> targetScore = GeneratedColumn<int>(
    'target_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetTimeSecondsMeta = const VerificationMeta(
    'targetTimeSeconds',
  );
  @override
  late final GeneratedColumn<int> targetTimeSeconds = GeneratedColumn<int>(
    'target_time_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seedMeta = const VerificationMeta('seed');
  @override
  late final GeneratedColumn<int> seed = GeneratedColumn<int>(
    'seed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _undoHistoryJsonMeta = const VerificationMeta(
    'undoHistoryJson',
  );
  @override
  late final GeneratedColumn<String> undoHistoryJson = GeneratedColumn<String>(
    'undo_history_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mode,
    boardJson,
    score,
    combo,
    maxCombo,
    matchesCount,
    addsCount,
    elapsedSeconds,
    selectedIndex,
    isCompleted,
    isWon,
    targetScore,
    targetTimeSeconds,
    seed,
    undoHistoryJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameSessionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('board_json')) {
      context.handle(
        _boardJsonMeta,
        boardJson.isAcceptableOrUnknown(data['board_json']!, _boardJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_boardJsonMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('combo')) {
      context.handle(
        _comboMeta,
        combo.isAcceptableOrUnknown(data['combo']!, _comboMeta),
      );
    }
    if (data.containsKey('max_combo')) {
      context.handle(
        _maxComboMeta,
        maxCombo.isAcceptableOrUnknown(data['max_combo']!, _maxComboMeta),
      );
    }
    if (data.containsKey('matches_count')) {
      context.handle(
        _matchesCountMeta,
        matchesCount.isAcceptableOrUnknown(
          data['matches_count']!,
          _matchesCountMeta,
        ),
      );
    }
    if (data.containsKey('adds_count')) {
      context.handle(
        _addsCountMeta,
        addsCount.isAcceptableOrUnknown(data['adds_count']!, _addsCountMeta),
      );
    }
    if (data.containsKey('elapsed_seconds')) {
      context.handle(
        _elapsedSecondsMeta,
        elapsedSeconds.isAcceptableOrUnknown(
          data['elapsed_seconds']!,
          _elapsedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('selected_index')) {
      context.handle(
        _selectedIndexMeta,
        selectedIndex.isAcceptableOrUnknown(
          data['selected_index']!,
          _selectedIndexMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('is_won')) {
      context.handle(
        _isWonMeta,
        isWon.isAcceptableOrUnknown(data['is_won']!, _isWonMeta),
      );
    }
    if (data.containsKey('target_score')) {
      context.handle(
        _targetScoreMeta,
        targetScore.isAcceptableOrUnknown(
          data['target_score']!,
          _targetScoreMeta,
        ),
      );
    }
    if (data.containsKey('target_time_seconds')) {
      context.handle(
        _targetTimeSecondsMeta,
        targetTimeSeconds.isAcceptableOrUnknown(
          data['target_time_seconds']!,
          _targetTimeSecondsMeta,
        ),
      );
    }
    if (data.containsKey('seed')) {
      context.handle(
        _seedMeta,
        seed.isAcceptableOrUnknown(data['seed']!, _seedMeta),
      );
    }
    if (data.containsKey('undo_history_json')) {
      context.handle(
        _undoHistoryJsonMeta,
        undoHistoryJson.isAcceptableOrUnknown(
          data['undo_history_json']!,
          _undoHistoryJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameSessionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameSessionEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      boardJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_json'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      combo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}combo'],
      )!,
      maxCombo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_combo'],
      )!,
      matchesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matches_count'],
      )!,
      addsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}adds_count'],
      )!,
      elapsedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_seconds'],
      )!,
      selectedIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}selected_index'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      isWon: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_won'],
      )!,
      targetScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_score'],
      ),
      targetTimeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_time_seconds'],
      ),
      seed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed'],
      ),
      undoHistoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}undo_history_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GameSessionsTableTable createAlias(String alias) {
    return $GameSessionsTableTable(attachedDatabase, alias);
  }
}

class GameSessionEntry extends DataClass
    implements Insertable<GameSessionEntry> {
  final String id;
  final String mode;
  final String boardJson;
  final int score;
  final int combo;
  final int maxCombo;
  final int matchesCount;
  final int addsCount;
  final int elapsedSeconds;
  final int? selectedIndex;
  final bool isCompleted;
  final bool isWon;
  final int? targetScore;
  final int? targetTimeSeconds;
  final int? seed;
  final String undoHistoryJson;
  final DateTime updatedAt;
  const GameSessionEntry({
    required this.id,
    required this.mode,
    required this.boardJson,
    required this.score,
    required this.combo,
    required this.maxCombo,
    required this.matchesCount,
    required this.addsCount,
    required this.elapsedSeconds,
    this.selectedIndex,
    required this.isCompleted,
    required this.isWon,
    this.targetScore,
    this.targetTimeSeconds,
    this.seed,
    required this.undoHistoryJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mode'] = Variable<String>(mode);
    map['board_json'] = Variable<String>(boardJson);
    map['score'] = Variable<int>(score);
    map['combo'] = Variable<int>(combo);
    map['max_combo'] = Variable<int>(maxCombo);
    map['matches_count'] = Variable<int>(matchesCount);
    map['adds_count'] = Variable<int>(addsCount);
    map['elapsed_seconds'] = Variable<int>(elapsedSeconds);
    if (!nullToAbsent || selectedIndex != null) {
      map['selected_index'] = Variable<int>(selectedIndex);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['is_won'] = Variable<bool>(isWon);
    if (!nullToAbsent || targetScore != null) {
      map['target_score'] = Variable<int>(targetScore);
    }
    if (!nullToAbsent || targetTimeSeconds != null) {
      map['target_time_seconds'] = Variable<int>(targetTimeSeconds);
    }
    if (!nullToAbsent || seed != null) {
      map['seed'] = Variable<int>(seed);
    }
    map['undo_history_json'] = Variable<String>(undoHistoryJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GameSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return GameSessionsTableCompanion(
      id: Value(id),
      mode: Value(mode),
      boardJson: Value(boardJson),
      score: Value(score),
      combo: Value(combo),
      maxCombo: Value(maxCombo),
      matchesCount: Value(matchesCount),
      addsCount: Value(addsCount),
      elapsedSeconds: Value(elapsedSeconds),
      selectedIndex: selectedIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedIndex),
      isCompleted: Value(isCompleted),
      isWon: Value(isWon),
      targetScore: targetScore == null && nullToAbsent
          ? const Value.absent()
          : Value(targetScore),
      targetTimeSeconds: targetTimeSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(targetTimeSeconds),
      seed: seed == null && nullToAbsent ? const Value.absent() : Value(seed),
      undoHistoryJson: Value(undoHistoryJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory GameSessionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameSessionEntry(
      id: serializer.fromJson<String>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      boardJson: serializer.fromJson<String>(json['boardJson']),
      score: serializer.fromJson<int>(json['score']),
      combo: serializer.fromJson<int>(json['combo']),
      maxCombo: serializer.fromJson<int>(json['maxCombo']),
      matchesCount: serializer.fromJson<int>(json['matchesCount']),
      addsCount: serializer.fromJson<int>(json['addsCount']),
      elapsedSeconds: serializer.fromJson<int>(json['elapsedSeconds']),
      selectedIndex: serializer.fromJson<int?>(json['selectedIndex']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      isWon: serializer.fromJson<bool>(json['isWon']),
      targetScore: serializer.fromJson<int?>(json['targetScore']),
      targetTimeSeconds: serializer.fromJson<int?>(json['targetTimeSeconds']),
      seed: serializer.fromJson<int?>(json['seed']),
      undoHistoryJson: serializer.fromJson<String>(json['undoHistoryJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mode': serializer.toJson<String>(mode),
      'boardJson': serializer.toJson<String>(boardJson),
      'score': serializer.toJson<int>(score),
      'combo': serializer.toJson<int>(combo),
      'maxCombo': serializer.toJson<int>(maxCombo),
      'matchesCount': serializer.toJson<int>(matchesCount),
      'addsCount': serializer.toJson<int>(addsCount),
      'elapsedSeconds': serializer.toJson<int>(elapsedSeconds),
      'selectedIndex': serializer.toJson<int?>(selectedIndex),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'isWon': serializer.toJson<bool>(isWon),
      'targetScore': serializer.toJson<int?>(targetScore),
      'targetTimeSeconds': serializer.toJson<int?>(targetTimeSeconds),
      'seed': serializer.toJson<int?>(seed),
      'undoHistoryJson': serializer.toJson<String>(undoHistoryJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GameSessionEntry copyWith({
    String? id,
    String? mode,
    String? boardJson,
    int? score,
    int? combo,
    int? maxCombo,
    int? matchesCount,
    int? addsCount,
    int? elapsedSeconds,
    Value<int?> selectedIndex = const Value.absent(),
    bool? isCompleted,
    bool? isWon,
    Value<int?> targetScore = const Value.absent(),
    Value<int?> targetTimeSeconds = const Value.absent(),
    Value<int?> seed = const Value.absent(),
    String? undoHistoryJson,
    DateTime? updatedAt,
  }) => GameSessionEntry(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    boardJson: boardJson ?? this.boardJson,
    score: score ?? this.score,
    combo: combo ?? this.combo,
    maxCombo: maxCombo ?? this.maxCombo,
    matchesCount: matchesCount ?? this.matchesCount,
    addsCount: addsCount ?? this.addsCount,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    selectedIndex: selectedIndex.present
        ? selectedIndex.value
        : this.selectedIndex,
    isCompleted: isCompleted ?? this.isCompleted,
    isWon: isWon ?? this.isWon,
    targetScore: targetScore.present ? targetScore.value : this.targetScore,
    targetTimeSeconds: targetTimeSeconds.present
        ? targetTimeSeconds.value
        : this.targetTimeSeconds,
    seed: seed.present ? seed.value : this.seed,
    undoHistoryJson: undoHistoryJson ?? this.undoHistoryJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GameSessionEntry copyWithCompanion(GameSessionsTableCompanion data) {
    return GameSessionEntry(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      boardJson: data.boardJson.present ? data.boardJson.value : this.boardJson,
      score: data.score.present ? data.score.value : this.score,
      combo: data.combo.present ? data.combo.value : this.combo,
      maxCombo: data.maxCombo.present ? data.maxCombo.value : this.maxCombo,
      matchesCount: data.matchesCount.present
          ? data.matchesCount.value
          : this.matchesCount,
      addsCount: data.addsCount.present ? data.addsCount.value : this.addsCount,
      elapsedSeconds: data.elapsedSeconds.present
          ? data.elapsedSeconds.value
          : this.elapsedSeconds,
      selectedIndex: data.selectedIndex.present
          ? data.selectedIndex.value
          : this.selectedIndex,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      isWon: data.isWon.present ? data.isWon.value : this.isWon,
      targetScore: data.targetScore.present
          ? data.targetScore.value
          : this.targetScore,
      targetTimeSeconds: data.targetTimeSeconds.present
          ? data.targetTimeSeconds.value
          : this.targetTimeSeconds,
      seed: data.seed.present ? data.seed.value : this.seed,
      undoHistoryJson: data.undoHistoryJson.present
          ? data.undoHistoryJson.value
          : this.undoHistoryJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionEntry(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('boardJson: $boardJson, ')
          ..write('score: $score, ')
          ..write('combo: $combo, ')
          ..write('maxCombo: $maxCombo, ')
          ..write('matchesCount: $matchesCount, ')
          ..write('addsCount: $addsCount, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('selectedIndex: $selectedIndex, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isWon: $isWon, ')
          ..write('targetScore: $targetScore, ')
          ..write('targetTimeSeconds: $targetTimeSeconds, ')
          ..write('seed: $seed, ')
          ..write('undoHistoryJson: $undoHistoryJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mode,
    boardJson,
    score,
    combo,
    maxCombo,
    matchesCount,
    addsCount,
    elapsedSeconds,
    selectedIndex,
    isCompleted,
    isWon,
    targetScore,
    targetTimeSeconds,
    seed,
    undoHistoryJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameSessionEntry &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.boardJson == this.boardJson &&
          other.score == this.score &&
          other.combo == this.combo &&
          other.maxCombo == this.maxCombo &&
          other.matchesCount == this.matchesCount &&
          other.addsCount == this.addsCount &&
          other.elapsedSeconds == this.elapsedSeconds &&
          other.selectedIndex == this.selectedIndex &&
          other.isCompleted == this.isCompleted &&
          other.isWon == this.isWon &&
          other.targetScore == this.targetScore &&
          other.targetTimeSeconds == this.targetTimeSeconds &&
          other.seed == this.seed &&
          other.undoHistoryJson == this.undoHistoryJson &&
          other.updatedAt == this.updatedAt);
}

class GameSessionsTableCompanion extends UpdateCompanion<GameSessionEntry> {
  final Value<String> id;
  final Value<String> mode;
  final Value<String> boardJson;
  final Value<int> score;
  final Value<int> combo;
  final Value<int> maxCombo;
  final Value<int> matchesCount;
  final Value<int> addsCount;
  final Value<int> elapsedSeconds;
  final Value<int?> selectedIndex;
  final Value<bool> isCompleted;
  final Value<bool> isWon;
  final Value<int?> targetScore;
  final Value<int?> targetTimeSeconds;
  final Value<int?> seed;
  final Value<String> undoHistoryJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GameSessionsTableCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.boardJson = const Value.absent(),
    this.score = const Value.absent(),
    this.combo = const Value.absent(),
    this.maxCombo = const Value.absent(),
    this.matchesCount = const Value.absent(),
    this.addsCount = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.selectedIndex = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isWon = const Value.absent(),
    this.targetScore = const Value.absent(),
    this.targetTimeSeconds = const Value.absent(),
    this.seed = const Value.absent(),
    this.undoHistoryJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameSessionsTableCompanion.insert({
    required String id,
    required String mode,
    required String boardJson,
    this.score = const Value.absent(),
    this.combo = const Value.absent(),
    this.maxCombo = const Value.absent(),
    this.matchesCount = const Value.absent(),
    this.addsCount = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.selectedIndex = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isWon = const Value.absent(),
    this.targetScore = const Value.absent(),
    this.targetTimeSeconds = const Value.absent(),
    this.seed = const Value.absent(),
    this.undoHistoryJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mode = Value(mode),
       boardJson = Value(boardJson);
  static Insertable<GameSessionEntry> custom({
    Expression<String>? id,
    Expression<String>? mode,
    Expression<String>? boardJson,
    Expression<int>? score,
    Expression<int>? combo,
    Expression<int>? maxCombo,
    Expression<int>? matchesCount,
    Expression<int>? addsCount,
    Expression<int>? elapsedSeconds,
    Expression<int>? selectedIndex,
    Expression<bool>? isCompleted,
    Expression<bool>? isWon,
    Expression<int>? targetScore,
    Expression<int>? targetTimeSeconds,
    Expression<int>? seed,
    Expression<String>? undoHistoryJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (boardJson != null) 'board_json': boardJson,
      if (score != null) 'score': score,
      if (combo != null) 'combo': combo,
      if (maxCombo != null) 'max_combo': maxCombo,
      if (matchesCount != null) 'matches_count': matchesCount,
      if (addsCount != null) 'adds_count': addsCount,
      if (elapsedSeconds != null) 'elapsed_seconds': elapsedSeconds,
      if (selectedIndex != null) 'selected_index': selectedIndex,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (isWon != null) 'is_won': isWon,
      if (targetScore != null) 'target_score': targetScore,
      if (targetTimeSeconds != null) 'target_time_seconds': targetTimeSeconds,
      if (seed != null) 'seed': seed,
      if (undoHistoryJson != null) 'undo_history_json': undoHistoryJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameSessionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? mode,
    Value<String>? boardJson,
    Value<int>? score,
    Value<int>? combo,
    Value<int>? maxCombo,
    Value<int>? matchesCount,
    Value<int>? addsCount,
    Value<int>? elapsedSeconds,
    Value<int?>? selectedIndex,
    Value<bool>? isCompleted,
    Value<bool>? isWon,
    Value<int?>? targetScore,
    Value<int?>? targetTimeSeconds,
    Value<int?>? seed,
    Value<String>? undoHistoryJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GameSessionsTableCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      boardJson: boardJson ?? this.boardJson,
      score: score ?? this.score,
      combo: combo ?? this.combo,
      maxCombo: maxCombo ?? this.maxCombo,
      matchesCount: matchesCount ?? this.matchesCount,
      addsCount: addsCount ?? this.addsCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      isWon: isWon ?? this.isWon,
      targetScore: targetScore ?? this.targetScore,
      targetTimeSeconds: targetTimeSeconds ?? this.targetTimeSeconds,
      seed: seed ?? this.seed,
      undoHistoryJson: undoHistoryJson ?? this.undoHistoryJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (boardJson.present) {
      map['board_json'] = Variable<String>(boardJson.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (combo.present) {
      map['combo'] = Variable<int>(combo.value);
    }
    if (maxCombo.present) {
      map['max_combo'] = Variable<int>(maxCombo.value);
    }
    if (matchesCount.present) {
      map['matches_count'] = Variable<int>(matchesCount.value);
    }
    if (addsCount.present) {
      map['adds_count'] = Variable<int>(addsCount.value);
    }
    if (elapsedSeconds.present) {
      map['elapsed_seconds'] = Variable<int>(elapsedSeconds.value);
    }
    if (selectedIndex.present) {
      map['selected_index'] = Variable<int>(selectedIndex.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (isWon.present) {
      map['is_won'] = Variable<bool>(isWon.value);
    }
    if (targetScore.present) {
      map['target_score'] = Variable<int>(targetScore.value);
    }
    if (targetTimeSeconds.present) {
      map['target_time_seconds'] = Variable<int>(targetTimeSeconds.value);
    }
    if (seed.present) {
      map['seed'] = Variable<int>(seed.value);
    }
    if (undoHistoryJson.present) {
      map['undo_history_json'] = Variable<String>(undoHistoryJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('boardJson: $boardJson, ')
          ..write('score: $score, ')
          ..write('combo: $combo, ')
          ..write('maxCombo: $maxCombo, ')
          ..write('matchesCount: $matchesCount, ')
          ..write('addsCount: $addsCount, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('selectedIndex: $selectedIndex, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isWon: $isWon, ')
          ..write('targetScore: $targetScore, ')
          ..write('targetTimeSeconds: $targetTimeSeconds, ')
          ..write('seed: $seed, ')
          ..write('undoHistoryJson: $undoHistoryJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyChallengesTableTable extends DailyChallengesTable
    with TableInfo<$DailyChallengesTableTable, DailyChallengeEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyChallengesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateKeyMeta = const VerificationMeta(
    'dateKey',
  );
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
    'date_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _movesMeta = const VerificationMeta('moves');
  @override
  late final GeneratedColumn<int> moves = GeneratedColumn<int>(
    'moves',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _elapsedSecondsMeta = const VerificationMeta(
    'elapsedSeconds',
  );
  @override
  late final GeneratedColumn<int> elapsedSeconds = GeneratedColumn<int>(
    'elapsed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    dateKey,
    isCompleted,
    score,
    moves,
    elapsedSeconds,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_challenges_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyChallengeEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('moves')) {
      context.handle(
        _movesMeta,
        moves.isAcceptableOrUnknown(data['moves']!, _movesMeta),
      );
    }
    if (data.containsKey('elapsed_seconds')) {
      context.handle(
        _elapsedSecondsMeta,
        elapsedSeconds.isAcceptableOrUnknown(
          data['elapsed_seconds']!,
          _elapsedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dateKey};
  @override
  DailyChallengeEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyChallengeEntry(
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      moves: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}moves'],
      )!,
      elapsedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_seconds'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $DailyChallengesTableTable createAlias(String alias) {
    return $DailyChallengesTableTable(attachedDatabase, alias);
  }
}

class DailyChallengeEntry extends DataClass
    implements Insertable<DailyChallengeEntry> {
  final String dateKey;
  final bool isCompleted;
  final int score;
  final int moves;
  final int elapsedSeconds;
  final DateTime? completedAt;
  const DailyChallengeEntry({
    required this.dateKey,
    required this.isCompleted,
    required this.score,
    required this.moves,
    required this.elapsedSeconds,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date_key'] = Variable<String>(dateKey);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['score'] = Variable<int>(score);
    map['moves'] = Variable<int>(moves);
    map['elapsed_seconds'] = Variable<int>(elapsedSeconds);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  DailyChallengesTableCompanion toCompanion(bool nullToAbsent) {
    return DailyChallengesTableCompanion(
      dateKey: Value(dateKey),
      isCompleted: Value(isCompleted),
      score: Value(score),
      moves: Value(moves),
      elapsedSeconds: Value(elapsedSeconds),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DailyChallengeEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyChallengeEntry(
      dateKey: serializer.fromJson<String>(json['dateKey']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      score: serializer.fromJson<int>(json['score']),
      moves: serializer.fromJson<int>(json['moves']),
      elapsedSeconds: serializer.fromJson<int>(json['elapsedSeconds']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dateKey': serializer.toJson<String>(dateKey),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'score': serializer.toJson<int>(score),
      'moves': serializer.toJson<int>(moves),
      'elapsedSeconds': serializer.toJson<int>(elapsedSeconds),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  DailyChallengeEntry copyWith({
    String? dateKey,
    bool? isCompleted,
    int? score,
    int? moves,
    int? elapsedSeconds,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => DailyChallengeEntry(
    dateKey: dateKey ?? this.dateKey,
    isCompleted: isCompleted ?? this.isCompleted,
    score: score ?? this.score,
    moves: moves ?? this.moves,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  DailyChallengeEntry copyWithCompanion(DailyChallengesTableCompanion data) {
    return DailyChallengeEntry(
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      score: data.score.present ? data.score.value : this.score,
      moves: data.moves.present ? data.moves.value : this.moves,
      elapsedSeconds: data.elapsedSeconds.present
          ? data.elapsedSeconds.value
          : this.elapsedSeconds,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyChallengeEntry(')
          ..write('dateKey: $dateKey, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('score: $score, ')
          ..write('moves: $moves, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    dateKey,
    isCompleted,
    score,
    moves,
    elapsedSeconds,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyChallengeEntry &&
          other.dateKey == this.dateKey &&
          other.isCompleted == this.isCompleted &&
          other.score == this.score &&
          other.moves == this.moves &&
          other.elapsedSeconds == this.elapsedSeconds &&
          other.completedAt == this.completedAt);
}

class DailyChallengesTableCompanion
    extends UpdateCompanion<DailyChallengeEntry> {
  final Value<String> dateKey;
  final Value<bool> isCompleted;
  final Value<int> score;
  final Value<int> moves;
  final Value<int> elapsedSeconds;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const DailyChallengesTableCompanion({
    this.dateKey = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.score = const Value.absent(),
    this.moves = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyChallengesTableCompanion.insert({
    required String dateKey,
    this.isCompleted = const Value.absent(),
    this.score = const Value.absent(),
    this.moves = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : dateKey = Value(dateKey);
  static Insertable<DailyChallengeEntry> custom({
    Expression<String>? dateKey,
    Expression<bool>? isCompleted,
    Expression<int>? score,
    Expression<int>? moves,
    Expression<int>? elapsedSeconds,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dateKey != null) 'date_key': dateKey,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (score != null) 'score': score,
      if (moves != null) 'moves': moves,
      if (elapsedSeconds != null) 'elapsed_seconds': elapsedSeconds,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyChallengesTableCompanion copyWith({
    Value<String>? dateKey,
    Value<bool>? isCompleted,
    Value<int>? score,
    Value<int>? moves,
    Value<int>? elapsedSeconds,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return DailyChallengesTableCompanion(
      dateKey: dateKey ?? this.dateKey,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      moves: moves ?? this.moves,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (moves.present) {
      map['moves'] = Variable<int>(moves.value);
    }
    if (elapsedSeconds.present) {
      map['elapsed_seconds'] = Variable<int>(elapsedSeconds.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyChallengesTableCompanion(')
          ..write('dateKey: $dateKey, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('score: $score, ')
          ..write('moves: $moves, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameStatisticsTableTable extends GameStatisticsTable
    with TableInfo<$GameStatisticsTableTable, GameStatisticsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameStatisticsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _modeKeyMeta = const VerificationMeta(
    'modeKey',
  );
  @override
  late final GeneratedColumn<String> modeKey = GeneratedColumn<String>(
    'mode_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gamesPlayedMeta = const VerificationMeta(
    'gamesPlayed',
  );
  @override
  late final GeneratedColumn<int> gamesPlayed = GeneratedColumn<int>(
    'games_played',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gamesWonMeta = const VerificationMeta(
    'gamesWon',
  );
  @override
  late final GeneratedColumn<int> gamesWon = GeneratedColumn<int>(
    'games_won',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bestScoreMeta = const VerificationMeta(
    'bestScore',
  );
  @override
  late final GeneratedColumn<int> bestScore = GeneratedColumn<int>(
    'best_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalScoreMeta = const VerificationMeta(
    'totalScore',
  );
  @override
  late final GeneratedColumn<int> totalScore = GeneratedColumn<int>(
    'total_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bestComboMeta = const VerificationMeta(
    'bestCombo',
  );
  @override
  late final GeneratedColumn<int> bestCombo = GeneratedColumn<int>(
    'best_combo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPairsMatchedMeta = const VerificationMeta(
    'totalPairsMatched',
  );
  @override
  late final GeneratedColumn<int> totalPairsMatched = GeneratedColumn<int>(
    'total_pairs_matched',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalNumbersAddedMeta = const VerificationMeta(
    'totalNumbersAdded',
  );
  @override
  late final GeneratedColumn<int> totalNumbersAdded = GeneratedColumn<int>(
    'total_numbers_added',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalTimeSecondsMeta = const VerificationMeta(
    'totalTimeSeconds',
  );
  @override
  late final GeneratedColumn<int> totalTimeSeconds = GeneratedColumn<int>(
    'total_time_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bestStreakMeta = const VerificationMeta(
    'bestStreak',
  );
  @override
  late final GeneratedColumn<int> bestStreak = GeneratedColumn<int>(
    'best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    modeKey,
    gamesPlayed,
    gamesWon,
    bestScore,
    totalScore,
    bestCombo,
    totalPairsMatched,
    totalNumbersAdded,
    totalTimeSeconds,
    currentStreak,
    bestStreak,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_statistics_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameStatisticsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mode_key')) {
      context.handle(
        _modeKeyMeta,
        modeKey.isAcceptableOrUnknown(data['mode_key']!, _modeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_modeKeyMeta);
    }
    if (data.containsKey('games_played')) {
      context.handle(
        _gamesPlayedMeta,
        gamesPlayed.isAcceptableOrUnknown(
          data['games_played']!,
          _gamesPlayedMeta,
        ),
      );
    }
    if (data.containsKey('games_won')) {
      context.handle(
        _gamesWonMeta,
        gamesWon.isAcceptableOrUnknown(data['games_won']!, _gamesWonMeta),
      );
    }
    if (data.containsKey('best_score')) {
      context.handle(
        _bestScoreMeta,
        bestScore.isAcceptableOrUnknown(data['best_score']!, _bestScoreMeta),
      );
    }
    if (data.containsKey('total_score')) {
      context.handle(
        _totalScoreMeta,
        totalScore.isAcceptableOrUnknown(data['total_score']!, _totalScoreMeta),
      );
    }
    if (data.containsKey('best_combo')) {
      context.handle(
        _bestComboMeta,
        bestCombo.isAcceptableOrUnknown(data['best_combo']!, _bestComboMeta),
      );
    }
    if (data.containsKey('total_pairs_matched')) {
      context.handle(
        _totalPairsMatchedMeta,
        totalPairsMatched.isAcceptableOrUnknown(
          data['total_pairs_matched']!,
          _totalPairsMatchedMeta,
        ),
      );
    }
    if (data.containsKey('total_numbers_added')) {
      context.handle(
        _totalNumbersAddedMeta,
        totalNumbersAdded.isAcceptableOrUnknown(
          data['total_numbers_added']!,
          _totalNumbersAddedMeta,
        ),
      );
    }
    if (data.containsKey('total_time_seconds')) {
      context.handle(
        _totalTimeSecondsMeta,
        totalTimeSeconds.isAcceptableOrUnknown(
          data['total_time_seconds']!,
          _totalTimeSecondsMeta,
        ),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('best_streak')) {
      context.handle(
        _bestStreakMeta,
        bestStreak.isAcceptableOrUnknown(data['best_streak']!, _bestStreakMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {modeKey};
  @override
  GameStatisticsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameStatisticsEntry(
      modeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode_key'],
      )!,
      gamesPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}games_played'],
      )!,
      gamesWon: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}games_won'],
      )!,
      bestScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_score'],
      )!,
      totalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_score'],
      )!,
      bestCombo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_combo'],
      )!,
      totalPairsMatched: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pairs_matched'],
      )!,
      totalNumbersAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_numbers_added'],
      )!,
      totalTimeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_time_seconds'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      bestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_streak'],
      )!,
    );
  }

  @override
  $GameStatisticsTableTable createAlias(String alias) {
    return $GameStatisticsTableTable(attachedDatabase, alias);
  }
}

class GameStatisticsEntry extends DataClass
    implements Insertable<GameStatisticsEntry> {
  final String modeKey;
  final int gamesPlayed;
  final int gamesWon;
  final int bestScore;
  final int totalScore;
  final int bestCombo;
  final int totalPairsMatched;
  final int totalNumbersAdded;
  final int totalTimeSeconds;
  final int currentStreak;
  final int bestStreak;
  const GameStatisticsEntry({
    required this.modeKey,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.bestScore,
    required this.totalScore,
    required this.bestCombo,
    required this.totalPairsMatched,
    required this.totalNumbersAdded,
    required this.totalTimeSeconds,
    required this.currentStreak,
    required this.bestStreak,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mode_key'] = Variable<String>(modeKey);
    map['games_played'] = Variable<int>(gamesPlayed);
    map['games_won'] = Variable<int>(gamesWon);
    map['best_score'] = Variable<int>(bestScore);
    map['total_score'] = Variable<int>(totalScore);
    map['best_combo'] = Variable<int>(bestCombo);
    map['total_pairs_matched'] = Variable<int>(totalPairsMatched);
    map['total_numbers_added'] = Variable<int>(totalNumbersAdded);
    map['total_time_seconds'] = Variable<int>(totalTimeSeconds);
    map['current_streak'] = Variable<int>(currentStreak);
    map['best_streak'] = Variable<int>(bestStreak);
    return map;
  }

  GameStatisticsTableCompanion toCompanion(bool nullToAbsent) {
    return GameStatisticsTableCompanion(
      modeKey: Value(modeKey),
      gamesPlayed: Value(gamesPlayed),
      gamesWon: Value(gamesWon),
      bestScore: Value(bestScore),
      totalScore: Value(totalScore),
      bestCombo: Value(bestCombo),
      totalPairsMatched: Value(totalPairsMatched),
      totalNumbersAdded: Value(totalNumbersAdded),
      totalTimeSeconds: Value(totalTimeSeconds),
      currentStreak: Value(currentStreak),
      bestStreak: Value(bestStreak),
    );
  }

  factory GameStatisticsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameStatisticsEntry(
      modeKey: serializer.fromJson<String>(json['modeKey']),
      gamesPlayed: serializer.fromJson<int>(json['gamesPlayed']),
      gamesWon: serializer.fromJson<int>(json['gamesWon']),
      bestScore: serializer.fromJson<int>(json['bestScore']),
      totalScore: serializer.fromJson<int>(json['totalScore']),
      bestCombo: serializer.fromJson<int>(json['bestCombo']),
      totalPairsMatched: serializer.fromJson<int>(json['totalPairsMatched']),
      totalNumbersAdded: serializer.fromJson<int>(json['totalNumbersAdded']),
      totalTimeSeconds: serializer.fromJson<int>(json['totalTimeSeconds']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      bestStreak: serializer.fromJson<int>(json['bestStreak']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'modeKey': serializer.toJson<String>(modeKey),
      'gamesPlayed': serializer.toJson<int>(gamesPlayed),
      'gamesWon': serializer.toJson<int>(gamesWon),
      'bestScore': serializer.toJson<int>(bestScore),
      'totalScore': serializer.toJson<int>(totalScore),
      'bestCombo': serializer.toJson<int>(bestCombo),
      'totalPairsMatched': serializer.toJson<int>(totalPairsMatched),
      'totalNumbersAdded': serializer.toJson<int>(totalNumbersAdded),
      'totalTimeSeconds': serializer.toJson<int>(totalTimeSeconds),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'bestStreak': serializer.toJson<int>(bestStreak),
    };
  }

  GameStatisticsEntry copyWith({
    String? modeKey,
    int? gamesPlayed,
    int? gamesWon,
    int? bestScore,
    int? totalScore,
    int? bestCombo,
    int? totalPairsMatched,
    int? totalNumbersAdded,
    int? totalTimeSeconds,
    int? currentStreak,
    int? bestStreak,
  }) => GameStatisticsEntry(
    modeKey: modeKey ?? this.modeKey,
    gamesPlayed: gamesPlayed ?? this.gamesPlayed,
    gamesWon: gamesWon ?? this.gamesWon,
    bestScore: bestScore ?? this.bestScore,
    totalScore: totalScore ?? this.totalScore,
    bestCombo: bestCombo ?? this.bestCombo,
    totalPairsMatched: totalPairsMatched ?? this.totalPairsMatched,
    totalNumbersAdded: totalNumbersAdded ?? this.totalNumbersAdded,
    totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
    currentStreak: currentStreak ?? this.currentStreak,
    bestStreak: bestStreak ?? this.bestStreak,
  );
  GameStatisticsEntry copyWithCompanion(GameStatisticsTableCompanion data) {
    return GameStatisticsEntry(
      modeKey: data.modeKey.present ? data.modeKey.value : this.modeKey,
      gamesPlayed: data.gamesPlayed.present
          ? data.gamesPlayed.value
          : this.gamesPlayed,
      gamesWon: data.gamesWon.present ? data.gamesWon.value : this.gamesWon,
      bestScore: data.bestScore.present ? data.bestScore.value : this.bestScore,
      totalScore: data.totalScore.present
          ? data.totalScore.value
          : this.totalScore,
      bestCombo: data.bestCombo.present ? data.bestCombo.value : this.bestCombo,
      totalPairsMatched: data.totalPairsMatched.present
          ? data.totalPairsMatched.value
          : this.totalPairsMatched,
      totalNumbersAdded: data.totalNumbersAdded.present
          ? data.totalNumbersAdded.value
          : this.totalNumbersAdded,
      totalTimeSeconds: data.totalTimeSeconds.present
          ? data.totalTimeSeconds.value
          : this.totalTimeSeconds,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      bestStreak: data.bestStreak.present
          ? data.bestStreak.value
          : this.bestStreak,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameStatisticsEntry(')
          ..write('modeKey: $modeKey, ')
          ..write('gamesPlayed: $gamesPlayed, ')
          ..write('gamesWon: $gamesWon, ')
          ..write('bestScore: $bestScore, ')
          ..write('totalScore: $totalScore, ')
          ..write('bestCombo: $bestCombo, ')
          ..write('totalPairsMatched: $totalPairsMatched, ')
          ..write('totalNumbersAdded: $totalNumbersAdded, ')
          ..write('totalTimeSeconds: $totalTimeSeconds, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('bestStreak: $bestStreak')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    modeKey,
    gamesPlayed,
    gamesWon,
    bestScore,
    totalScore,
    bestCombo,
    totalPairsMatched,
    totalNumbersAdded,
    totalTimeSeconds,
    currentStreak,
    bestStreak,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameStatisticsEntry &&
          other.modeKey == this.modeKey &&
          other.gamesPlayed == this.gamesPlayed &&
          other.gamesWon == this.gamesWon &&
          other.bestScore == this.bestScore &&
          other.totalScore == this.totalScore &&
          other.bestCombo == this.bestCombo &&
          other.totalPairsMatched == this.totalPairsMatched &&
          other.totalNumbersAdded == this.totalNumbersAdded &&
          other.totalTimeSeconds == this.totalTimeSeconds &&
          other.currentStreak == this.currentStreak &&
          other.bestStreak == this.bestStreak);
}

class GameStatisticsTableCompanion
    extends UpdateCompanion<GameStatisticsEntry> {
  final Value<String> modeKey;
  final Value<int> gamesPlayed;
  final Value<int> gamesWon;
  final Value<int> bestScore;
  final Value<int> totalScore;
  final Value<int> bestCombo;
  final Value<int> totalPairsMatched;
  final Value<int> totalNumbersAdded;
  final Value<int> totalTimeSeconds;
  final Value<int> currentStreak;
  final Value<int> bestStreak;
  final Value<int> rowid;
  const GameStatisticsTableCompanion({
    this.modeKey = const Value.absent(),
    this.gamesPlayed = const Value.absent(),
    this.gamesWon = const Value.absent(),
    this.bestScore = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.bestCombo = const Value.absent(),
    this.totalPairsMatched = const Value.absent(),
    this.totalNumbersAdded = const Value.absent(),
    this.totalTimeSeconds = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameStatisticsTableCompanion.insert({
    required String modeKey,
    this.gamesPlayed = const Value.absent(),
    this.gamesWon = const Value.absent(),
    this.bestScore = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.bestCombo = const Value.absent(),
    this.totalPairsMatched = const Value.absent(),
    this.totalNumbersAdded = const Value.absent(),
    this.totalTimeSeconds = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : modeKey = Value(modeKey);
  static Insertable<GameStatisticsEntry> custom({
    Expression<String>? modeKey,
    Expression<int>? gamesPlayed,
    Expression<int>? gamesWon,
    Expression<int>? bestScore,
    Expression<int>? totalScore,
    Expression<int>? bestCombo,
    Expression<int>? totalPairsMatched,
    Expression<int>? totalNumbersAdded,
    Expression<int>? totalTimeSeconds,
    Expression<int>? currentStreak,
    Expression<int>? bestStreak,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (modeKey != null) 'mode_key': modeKey,
      if (gamesPlayed != null) 'games_played': gamesPlayed,
      if (gamesWon != null) 'games_won': gamesWon,
      if (bestScore != null) 'best_score': bestScore,
      if (totalScore != null) 'total_score': totalScore,
      if (bestCombo != null) 'best_combo': bestCombo,
      if (totalPairsMatched != null) 'total_pairs_matched': totalPairsMatched,
      if (totalNumbersAdded != null) 'total_numbers_added': totalNumbersAdded,
      if (totalTimeSeconds != null) 'total_time_seconds': totalTimeSeconds,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (bestStreak != null) 'best_streak': bestStreak,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameStatisticsTableCompanion copyWith({
    Value<String>? modeKey,
    Value<int>? gamesPlayed,
    Value<int>? gamesWon,
    Value<int>? bestScore,
    Value<int>? totalScore,
    Value<int>? bestCombo,
    Value<int>? totalPairsMatched,
    Value<int>? totalNumbersAdded,
    Value<int>? totalTimeSeconds,
    Value<int>? currentStreak,
    Value<int>? bestStreak,
    Value<int>? rowid,
  }) {
    return GameStatisticsTableCompanion(
      modeKey: modeKey ?? this.modeKey,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      gamesWon: gamesWon ?? this.gamesWon,
      bestScore: bestScore ?? this.bestScore,
      totalScore: totalScore ?? this.totalScore,
      bestCombo: bestCombo ?? this.bestCombo,
      totalPairsMatched: totalPairsMatched ?? this.totalPairsMatched,
      totalNumbersAdded: totalNumbersAdded ?? this.totalNumbersAdded,
      totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (modeKey.present) {
      map['mode_key'] = Variable<String>(modeKey.value);
    }
    if (gamesPlayed.present) {
      map['games_played'] = Variable<int>(gamesPlayed.value);
    }
    if (gamesWon.present) {
      map['games_won'] = Variable<int>(gamesWon.value);
    }
    if (bestScore.present) {
      map['best_score'] = Variable<int>(bestScore.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<int>(totalScore.value);
    }
    if (bestCombo.present) {
      map['best_combo'] = Variable<int>(bestCombo.value);
    }
    if (totalPairsMatched.present) {
      map['total_pairs_matched'] = Variable<int>(totalPairsMatched.value);
    }
    if (totalNumbersAdded.present) {
      map['total_numbers_added'] = Variable<int>(totalNumbersAdded.value);
    }
    if (totalTimeSeconds.present) {
      map['total_time_seconds'] = Variable<int>(totalTimeSeconds.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (bestStreak.present) {
      map['best_streak'] = Variable<int>(bestStreak.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameStatisticsTableCompanion(')
          ..write('modeKey: $modeKey, ')
          ..write('gamesPlayed: $gamesPlayed, ')
          ..write('gamesWon: $gamesWon, ')
          ..write('bestScore: $bestScore, ')
          ..write('totalScore: $totalScore, ')
          ..write('bestCombo: $bestCombo, ')
          ..write('totalPairsMatched: $totalPairsMatched, ')
          ..write('totalNumbersAdded: $totalNumbersAdded, ')
          ..write('totalTimeSeconds: $totalTimeSeconds, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerWalletsTableTable extends PlayerWalletsTable
    with TableInfo<$PlayerWalletsTableTable, PlayerWalletEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerWalletsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(200),
  );
  static const VerificationMeta _totalCoinsEarnedMeta = const VerificationMeta(
    'totalCoinsEarned',
  );
  @override
  late final GeneratedColumn<int> totalCoinsEarned = GeneratedColumn<int>(
    'total_coins_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(200),
  );
  static const VerificationMeta _totalCoinsSpentMeta = const VerificationMeta(
    'totalCoinsSpent',
  );
  @override
  late final GeneratedColumn<int> totalCoinsSpent = GeneratedColumn<int>(
    'total_coins_spent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coins,
    totalCoinsEarned,
    totalCoinsSpent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_wallets_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerWalletEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    }
    if (data.containsKey('total_coins_earned')) {
      context.handle(
        _totalCoinsEarnedMeta,
        totalCoinsEarned.isAcceptableOrUnknown(
          data['total_coins_earned']!,
          _totalCoinsEarnedMeta,
        ),
      );
    }
    if (data.containsKey('total_coins_spent')) {
      context.handle(
        _totalCoinsSpentMeta,
        totalCoinsSpent.isAcceptableOrUnknown(
          data['total_coins_spent']!,
          _totalCoinsSpentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerWalletEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerWalletEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
      totalCoinsEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_coins_earned'],
      )!,
      totalCoinsSpent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_coins_spent'],
      )!,
    );
  }

  @override
  $PlayerWalletsTableTable createAlias(String alias) {
    return $PlayerWalletsTableTable(attachedDatabase, alias);
  }
}

class PlayerWalletEntry extends DataClass
    implements Insertable<PlayerWalletEntry> {
  final String id;
  final int coins;
  final int totalCoinsEarned;
  final int totalCoinsSpent;
  const PlayerWalletEntry({
    required this.id,
    required this.coins,
    required this.totalCoinsEarned,
    required this.totalCoinsSpent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coins'] = Variable<int>(coins);
    map['total_coins_earned'] = Variable<int>(totalCoinsEarned);
    map['total_coins_spent'] = Variable<int>(totalCoinsSpent);
    return map;
  }

  PlayerWalletsTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerWalletsTableCompanion(
      id: Value(id),
      coins: Value(coins),
      totalCoinsEarned: Value(totalCoinsEarned),
      totalCoinsSpent: Value(totalCoinsSpent),
    );
  }

  factory PlayerWalletEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerWalletEntry(
      id: serializer.fromJson<String>(json['id']),
      coins: serializer.fromJson<int>(json['coins']),
      totalCoinsEarned: serializer.fromJson<int>(json['totalCoinsEarned']),
      totalCoinsSpent: serializer.fromJson<int>(json['totalCoinsSpent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coins': serializer.toJson<int>(coins),
      'totalCoinsEarned': serializer.toJson<int>(totalCoinsEarned),
      'totalCoinsSpent': serializer.toJson<int>(totalCoinsSpent),
    };
  }

  PlayerWalletEntry copyWith({
    String? id,
    int? coins,
    int? totalCoinsEarned,
    int? totalCoinsSpent,
  }) => PlayerWalletEntry(
    id: id ?? this.id,
    coins: coins ?? this.coins,
    totalCoinsEarned: totalCoinsEarned ?? this.totalCoinsEarned,
    totalCoinsSpent: totalCoinsSpent ?? this.totalCoinsSpent,
  );
  PlayerWalletEntry copyWithCompanion(PlayerWalletsTableCompanion data) {
    return PlayerWalletEntry(
      id: data.id.present ? data.id.value : this.id,
      coins: data.coins.present ? data.coins.value : this.coins,
      totalCoinsEarned: data.totalCoinsEarned.present
          ? data.totalCoinsEarned.value
          : this.totalCoinsEarned,
      totalCoinsSpent: data.totalCoinsSpent.present
          ? data.totalCoinsSpent.value
          : this.totalCoinsSpent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerWalletEntry(')
          ..write('id: $id, ')
          ..write('coins: $coins, ')
          ..write('totalCoinsEarned: $totalCoinsEarned, ')
          ..write('totalCoinsSpent: $totalCoinsSpent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, coins, totalCoinsEarned, totalCoinsSpent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerWalletEntry &&
          other.id == this.id &&
          other.coins == this.coins &&
          other.totalCoinsEarned == this.totalCoinsEarned &&
          other.totalCoinsSpent == this.totalCoinsSpent);
}

class PlayerWalletsTableCompanion extends UpdateCompanion<PlayerWalletEntry> {
  final Value<String> id;
  final Value<int> coins;
  final Value<int> totalCoinsEarned;
  final Value<int> totalCoinsSpent;
  final Value<int> rowid;
  const PlayerWalletsTableCompanion({
    this.id = const Value.absent(),
    this.coins = const Value.absent(),
    this.totalCoinsEarned = const Value.absent(),
    this.totalCoinsSpent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerWalletsTableCompanion.insert({
    required String id,
    this.coins = const Value.absent(),
    this.totalCoinsEarned = const Value.absent(),
    this.totalCoinsSpent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<PlayerWalletEntry> custom({
    Expression<String>? id,
    Expression<int>? coins,
    Expression<int>? totalCoinsEarned,
    Expression<int>? totalCoinsSpent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coins != null) 'coins': coins,
      if (totalCoinsEarned != null) 'total_coins_earned': totalCoinsEarned,
      if (totalCoinsSpent != null) 'total_coins_spent': totalCoinsSpent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerWalletsTableCompanion copyWith({
    Value<String>? id,
    Value<int>? coins,
    Value<int>? totalCoinsEarned,
    Value<int>? totalCoinsSpent,
    Value<int>? rowid,
  }) {
    return PlayerWalletsTableCompanion(
      id: id ?? this.id,
      coins: coins ?? this.coins,
      totalCoinsEarned: totalCoinsEarned ?? this.totalCoinsEarned,
      totalCoinsSpent: totalCoinsSpent ?? this.totalCoinsSpent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    if (totalCoinsEarned.present) {
      map['total_coins_earned'] = Variable<int>(totalCoinsEarned.value);
    }
    if (totalCoinsSpent.present) {
      map['total_coins_spent'] = Variable<int>(totalCoinsSpent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerWalletsTableCompanion(')
          ..write('id: $id, ')
          ..write('coins: $coins, ')
          ..write('totalCoinsEarned: $totalCoinsEarned, ')
          ..write('totalCoinsSpent: $totalCoinsSpent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntitlementsTableTable extends EntitlementsTable
    with TableInfo<$EntitlementsTableTable, EntitlementEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitlementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEntitledMeta = const VerificationMeta(
    'isEntitled',
  );
  @override
  late final GeneratedColumn<bool> isEntitled = GeneratedColumn<bool>(
    'is_entitled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_entitled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _purchasedAtMeta = const VerificationMeta(
    'purchasedAt',
  );
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
    'purchased_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signatureMeta = const VerificationMeta(
    'signature',
  );
  @override
  late final GeneratedColumn<String> signature = GeneratedColumn<String>(
    'signature',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSandboxMeta = const VerificationMeta(
    'isSandbox',
  );
  @override
  late final GeneratedColumn<bool> isSandbox = GeneratedColumn<bool>(
    'is_sandbox',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sandbox" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    productId,
    isEntitled,
    purchasedAt,
    transactionId,
    signature,
    isSandbox,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entitlements_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntitlementEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('is_entitled')) {
      context.handle(
        _isEntitledMeta,
        isEntitled.isAcceptableOrUnknown(data['is_entitled']!, _isEntitledMeta),
      );
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
        _purchasedAtMeta,
        purchasedAt.isAcceptableOrUnknown(
          data['purchased_at']!,
          _purchasedAtMeta,
        ),
      );
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('signature')) {
      context.handle(
        _signatureMeta,
        signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta),
      );
    }
    if (data.containsKey('is_sandbox')) {
      context.handle(
        _isSandboxMeta,
        isSandbox.isAcceptableOrUnknown(data['is_sandbox']!, _isSandboxMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  EntitlementEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntitlementEntry(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      isEntitled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_entitled'],
      )!,
      purchasedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchased_at'],
      ),
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      signature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signature'],
      ),
      isSandbox: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sandbox'],
      )!,
    );
  }

  @override
  $EntitlementsTableTable createAlias(String alias) {
    return $EntitlementsTableTable(attachedDatabase, alias);
  }
}

class EntitlementEntry extends DataClass
    implements Insertable<EntitlementEntry> {
  final String productId;
  final bool isEntitled;
  final DateTime? purchasedAt;
  final String? transactionId;
  final String? signature;
  final bool isSandbox;
  const EntitlementEntry({
    required this.productId,
    required this.isEntitled,
    this.purchasedAt,
    this.transactionId,
    this.signature,
    required this.isSandbox,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['is_entitled'] = Variable<bool>(isEntitled);
    if (!nullToAbsent || purchasedAt != null) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt);
    }
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || signature != null) {
      map['signature'] = Variable<String>(signature);
    }
    map['is_sandbox'] = Variable<bool>(isSandbox);
    return map;
  }

  EntitlementsTableCompanion toCompanion(bool nullToAbsent) {
    return EntitlementsTableCompanion(
      productId: Value(productId),
      isEntitled: Value(isEntitled),
      purchasedAt: purchasedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasedAt),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      signature: signature == null && nullToAbsent
          ? const Value.absent()
          : Value(signature),
      isSandbox: Value(isSandbox),
    );
  }

  factory EntitlementEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntitlementEntry(
      productId: serializer.fromJson<String>(json['productId']),
      isEntitled: serializer.fromJson<bool>(json['isEntitled']),
      purchasedAt: serializer.fromJson<DateTime?>(json['purchasedAt']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      signature: serializer.fromJson<String?>(json['signature']),
      isSandbox: serializer.fromJson<bool>(json['isSandbox']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'isEntitled': serializer.toJson<bool>(isEntitled),
      'purchasedAt': serializer.toJson<DateTime?>(purchasedAt),
      'transactionId': serializer.toJson<String?>(transactionId),
      'signature': serializer.toJson<String?>(signature),
      'isSandbox': serializer.toJson<bool>(isSandbox),
    };
  }

  EntitlementEntry copyWith({
    String? productId,
    bool? isEntitled,
    Value<DateTime?> purchasedAt = const Value.absent(),
    Value<String?> transactionId = const Value.absent(),
    Value<String?> signature = const Value.absent(),
    bool? isSandbox,
  }) => EntitlementEntry(
    productId: productId ?? this.productId,
    isEntitled: isEntitled ?? this.isEntitled,
    purchasedAt: purchasedAt.present ? purchasedAt.value : this.purchasedAt,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    signature: signature.present ? signature.value : this.signature,
    isSandbox: isSandbox ?? this.isSandbox,
  );
  EntitlementEntry copyWithCompanion(EntitlementsTableCompanion data) {
    return EntitlementEntry(
      productId: data.productId.present ? data.productId.value : this.productId,
      isEntitled: data.isEntitled.present
          ? data.isEntitled.value
          : this.isEntitled,
      purchasedAt: data.purchasedAt.present
          ? data.purchasedAt.value
          : this.purchasedAt,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      signature: data.signature.present ? data.signature.value : this.signature,
      isSandbox: data.isSandbox.present ? data.isSandbox.value : this.isSandbox,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntitlementEntry(')
          ..write('productId: $productId, ')
          ..write('isEntitled: $isEntitled, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('transactionId: $transactionId, ')
          ..write('signature: $signature, ')
          ..write('isSandbox: $isSandbox')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    productId,
    isEntitled,
    purchasedAt,
    transactionId,
    signature,
    isSandbox,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntitlementEntry &&
          other.productId == this.productId &&
          other.isEntitled == this.isEntitled &&
          other.purchasedAt == this.purchasedAt &&
          other.transactionId == this.transactionId &&
          other.signature == this.signature &&
          other.isSandbox == this.isSandbox);
}

class EntitlementsTableCompanion extends UpdateCompanion<EntitlementEntry> {
  final Value<String> productId;
  final Value<bool> isEntitled;
  final Value<DateTime?> purchasedAt;
  final Value<String?> transactionId;
  final Value<String?> signature;
  final Value<bool> isSandbox;
  final Value<int> rowid;
  const EntitlementsTableCompanion({
    this.productId = const Value.absent(),
    this.isEntitled = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.signature = const Value.absent(),
    this.isSandbox = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntitlementsTableCompanion.insert({
    required String productId,
    this.isEntitled = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.signature = const Value.absent(),
    this.isSandbox = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId);
  static Insertable<EntitlementEntry> custom({
    Expression<String>? productId,
    Expression<bool>? isEntitled,
    Expression<DateTime>? purchasedAt,
    Expression<String>? transactionId,
    Expression<String>? signature,
    Expression<bool>? isSandbox,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (isEntitled != null) 'is_entitled': isEntitled,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (transactionId != null) 'transaction_id': transactionId,
      if (signature != null) 'signature': signature,
      if (isSandbox != null) 'is_sandbox': isSandbox,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntitlementsTableCompanion copyWith({
    Value<String>? productId,
    Value<bool>? isEntitled,
    Value<DateTime?>? purchasedAt,
    Value<String?>? transactionId,
    Value<String?>? signature,
    Value<bool>? isSandbox,
    Value<int>? rowid,
  }) {
    return EntitlementsTableCompanion(
      productId: productId ?? this.productId,
      isEntitled: isEntitled ?? this.isEntitled,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      transactionId: transactionId ?? this.transactionId,
      signature: signature ?? this.signature,
      isSandbox: isSandbox ?? this.isSandbox,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (isEntitled.present) {
      map['is_entitled'] = Variable<bool>(isEntitled.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    if (isSandbox.present) {
      map['is_sandbox'] = Variable<bool>(isSandbox.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitlementsTableCompanion(')
          ..write('productId: $productId, ')
          ..write('isEntitled: $isEntitled, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('transactionId: $transactionId, ')
          ..write('signature: $signature, ')
          ..write('isSandbox: $isSandbox, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GameSessionsTableTable gameSessionsTable =
      $GameSessionsTableTable(this);
  late final $DailyChallengesTableTable dailyChallengesTable =
      $DailyChallengesTableTable(this);
  late final $GameStatisticsTableTable gameStatisticsTable =
      $GameStatisticsTableTable(this);
  late final $PlayerWalletsTableTable playerWalletsTable =
      $PlayerWalletsTableTable(this);
  late final $EntitlementsTableTable entitlementsTable =
      $EntitlementsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gameSessionsTable,
    dailyChallengesTable,
    gameStatisticsTable,
    playerWalletsTable,
    entitlementsTable,
  ];
}

typedef $$GameSessionsTableTableCreateCompanionBuilder =
    GameSessionsTableCompanion Function({
      required String id,
      required String mode,
      required String boardJson,
      Value<int> score,
      Value<int> combo,
      Value<int> maxCombo,
      Value<int> matchesCount,
      Value<int> addsCount,
      Value<int> elapsedSeconds,
      Value<int?> selectedIndex,
      Value<bool> isCompleted,
      Value<bool> isWon,
      Value<int?> targetScore,
      Value<int?> targetTimeSeconds,
      Value<int?> seed,
      Value<String> undoHistoryJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$GameSessionsTableTableUpdateCompanionBuilder =
    GameSessionsTableCompanion Function({
      Value<String> id,
      Value<String> mode,
      Value<String> boardJson,
      Value<int> score,
      Value<int> combo,
      Value<int> maxCombo,
      Value<int> matchesCount,
      Value<int> addsCount,
      Value<int> elapsedSeconds,
      Value<int?> selectedIndex,
      Value<bool> isCompleted,
      Value<bool> isWon,
      Value<int?> targetScore,
      Value<int?> targetTimeSeconds,
      Value<int?> seed,
      Value<String> undoHistoryJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GameSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GameSessionsTableTable> {
  $$GameSessionsTableTableFilterComposer({
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

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardJson => $composableBuilder(
    column: $table.boardJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get combo => $composableBuilder(
    column: $table.combo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxCombo => $composableBuilder(
    column: $table.maxCombo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchesCount => $composableBuilder(
    column: $table.matchesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get addsCount => $composableBuilder(
    column: $table.addsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get selectedIndex => $composableBuilder(
    column: $table.selectedIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isWon => $composableBuilder(
    column: $table.isWon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetScore => $composableBuilder(
    column: $table.targetScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetTimeSeconds => $composableBuilder(
    column: $table.targetTimeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get undoHistoryJson => $composableBuilder(
    column: $table.undoHistoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GameSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GameSessionsTableTable> {
  $$GameSessionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardJson => $composableBuilder(
    column: $table.boardJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get combo => $composableBuilder(
    column: $table.combo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxCombo => $composableBuilder(
    column: $table.maxCombo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchesCount => $composableBuilder(
    column: $table.matchesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get addsCount => $composableBuilder(
    column: $table.addsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get selectedIndex => $composableBuilder(
    column: $table.selectedIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isWon => $composableBuilder(
    column: $table.isWon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetScore => $composableBuilder(
    column: $table.targetScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetTimeSeconds => $composableBuilder(
    column: $table.targetTimeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get undoHistoryJson => $composableBuilder(
    column: $table.undoHistoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GameSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameSessionsTableTable> {
  $$GameSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get boardJson =>
      $composableBuilder(column: $table.boardJson, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get combo =>
      $composableBuilder(column: $table.combo, builder: (column) => column);

  GeneratedColumn<int> get maxCombo =>
      $composableBuilder(column: $table.maxCombo, builder: (column) => column);

  GeneratedColumn<int> get matchesCount => $composableBuilder(
    column: $table.matchesCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get addsCount =>
      $composableBuilder(column: $table.addsCount, builder: (column) => column);

  GeneratedColumn<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get selectedIndex => $composableBuilder(
    column: $table.selectedIndex,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isWon =>
      $composableBuilder(column: $table.isWon, builder: (column) => column);

  GeneratedColumn<int> get targetScore => $composableBuilder(
    column: $table.targetScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetTimeSeconds => $composableBuilder(
    column: $table.targetTimeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seed =>
      $composableBuilder(column: $table.seed, builder: (column) => column);

  GeneratedColumn<String> get undoHistoryJson => $composableBuilder(
    column: $table.undoHistoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GameSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameSessionsTableTable,
          GameSessionEntry,
          $$GameSessionsTableTableFilterComposer,
          $$GameSessionsTableTableOrderingComposer,
          $$GameSessionsTableTableAnnotationComposer,
          $$GameSessionsTableTableCreateCompanionBuilder,
          $$GameSessionsTableTableUpdateCompanionBuilder,
          (
            GameSessionEntry,
            BaseReferences<
              _$AppDatabase,
              $GameSessionsTableTable,
              GameSessionEntry
            >,
          ),
          GameSessionEntry,
          PrefetchHooks Function()
        > {
  $$GameSessionsTableTableTableManager(
    _$AppDatabase db,
    $GameSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> boardJson = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> combo = const Value.absent(),
                Value<int> maxCombo = const Value.absent(),
                Value<int> matchesCount = const Value.absent(),
                Value<int> addsCount = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<int?> selectedIndex = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isWon = const Value.absent(),
                Value<int?> targetScore = const Value.absent(),
                Value<int?> targetTimeSeconds = const Value.absent(),
                Value<int?> seed = const Value.absent(),
                Value<String> undoHistoryJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameSessionsTableCompanion(
                id: id,
                mode: mode,
                boardJson: boardJson,
                score: score,
                combo: combo,
                maxCombo: maxCombo,
                matchesCount: matchesCount,
                addsCount: addsCount,
                elapsedSeconds: elapsedSeconds,
                selectedIndex: selectedIndex,
                isCompleted: isCompleted,
                isWon: isWon,
                targetScore: targetScore,
                targetTimeSeconds: targetTimeSeconds,
                seed: seed,
                undoHistoryJson: undoHistoryJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mode,
                required String boardJson,
                Value<int> score = const Value.absent(),
                Value<int> combo = const Value.absent(),
                Value<int> maxCombo = const Value.absent(),
                Value<int> matchesCount = const Value.absent(),
                Value<int> addsCount = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<int?> selectedIndex = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isWon = const Value.absent(),
                Value<int?> targetScore = const Value.absent(),
                Value<int?> targetTimeSeconds = const Value.absent(),
                Value<int?> seed = const Value.absent(),
                Value<String> undoHistoryJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameSessionsTableCompanion.insert(
                id: id,
                mode: mode,
                boardJson: boardJson,
                score: score,
                combo: combo,
                maxCombo: maxCombo,
                matchesCount: matchesCount,
                addsCount: addsCount,
                elapsedSeconds: elapsedSeconds,
                selectedIndex: selectedIndex,
                isCompleted: isCompleted,
                isWon: isWon,
                targetScore: targetScore,
                targetTimeSeconds: targetTimeSeconds,
                seed: seed,
                undoHistoryJson: undoHistoryJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GameSessionsTableTable, GameSessionEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GameSessionsTableTable,
                    GameSessionEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GameSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameSessionsTableTable,
      GameSessionEntry,
      $$GameSessionsTableTableFilterComposer,
      $$GameSessionsTableTableOrderingComposer,
      $$GameSessionsTableTableAnnotationComposer,
      $$GameSessionsTableTableCreateCompanionBuilder,
      $$GameSessionsTableTableUpdateCompanionBuilder,
      (
        GameSessionEntry,
        BaseReferences<
          _$AppDatabase,
          $GameSessionsTableTable,
          GameSessionEntry
        >,
      ),
      GameSessionEntry,
      PrefetchHooks Function()
    >;
typedef $$DailyChallengesTableTableCreateCompanionBuilder =
    DailyChallengesTableCompanion Function({
      required String dateKey,
      Value<bool> isCompleted,
      Value<int> score,
      Value<int> moves,
      Value<int> elapsedSeconds,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$DailyChallengesTableTableUpdateCompanionBuilder =
    DailyChallengesTableCompanion Function({
      Value<String> dateKey,
      Value<bool> isCompleted,
      Value<int> score,
      Value<int> moves,
      Value<int> elapsedSeconds,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$DailyChallengesTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyChallengesTableTable> {
  $$DailyChallengesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moves => $composableBuilder(
    column: $table.moves,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyChallengesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyChallengesTableTable> {
  $$DailyChallengesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moves => $composableBuilder(
    column: $table.moves,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyChallengesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyChallengesTableTable> {
  $$DailyChallengesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get moves =>
      $composableBuilder(column: $table.moves, builder: (column) => column);

  GeneratedColumn<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$DailyChallengesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyChallengesTableTable,
          DailyChallengeEntry,
          $$DailyChallengesTableTableFilterComposer,
          $$DailyChallengesTableTableOrderingComposer,
          $$DailyChallengesTableTableAnnotationComposer,
          $$DailyChallengesTableTableCreateCompanionBuilder,
          $$DailyChallengesTableTableUpdateCompanionBuilder,
          (
            DailyChallengeEntry,
            BaseReferences<
              _$AppDatabase,
              $DailyChallengesTableTable,
              DailyChallengeEntry
            >,
          ),
          DailyChallengeEntry,
          PrefetchHooks Function()
        > {
  $$DailyChallengesTableTableTableManager(
    _$AppDatabase db,
    $DailyChallengesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyChallengesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyChallengesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyChallengesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> dateKey = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> moves = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyChallengesTableCompanion(
                dateKey: dateKey,
                isCompleted: isCompleted,
                score: score,
                moves: moves,
                elapsedSeconds: elapsedSeconds,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dateKey,
                Value<bool> isCompleted = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> moves = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyChallengesTableCompanion.insert(
                dateKey: dateKey,
                isCompleted: isCompleted,
                score: score,
                moves: moves,
                elapsedSeconds: elapsedSeconds,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyChallengesTableTable, DailyChallengeEntry>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyChallengesTableTable,
                    DailyChallengeEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyChallengesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyChallengesTableTable,
      DailyChallengeEntry,
      $$DailyChallengesTableTableFilterComposer,
      $$DailyChallengesTableTableOrderingComposer,
      $$DailyChallengesTableTableAnnotationComposer,
      $$DailyChallengesTableTableCreateCompanionBuilder,
      $$DailyChallengesTableTableUpdateCompanionBuilder,
      (
        DailyChallengeEntry,
        BaseReferences<
          _$AppDatabase,
          $DailyChallengesTableTable,
          DailyChallengeEntry
        >,
      ),
      DailyChallengeEntry,
      PrefetchHooks Function()
    >;
typedef $$GameStatisticsTableTableCreateCompanionBuilder =
    GameStatisticsTableCompanion Function({
      required String modeKey,
      Value<int> gamesPlayed,
      Value<int> gamesWon,
      Value<int> bestScore,
      Value<int> totalScore,
      Value<int> bestCombo,
      Value<int> totalPairsMatched,
      Value<int> totalNumbersAdded,
      Value<int> totalTimeSeconds,
      Value<int> currentStreak,
      Value<int> bestStreak,
      Value<int> rowid,
    });
typedef $$GameStatisticsTableTableUpdateCompanionBuilder =
    GameStatisticsTableCompanion Function({
      Value<String> modeKey,
      Value<int> gamesPlayed,
      Value<int> gamesWon,
      Value<int> bestScore,
      Value<int> totalScore,
      Value<int> bestCombo,
      Value<int> totalPairsMatched,
      Value<int> totalNumbersAdded,
      Value<int> totalTimeSeconds,
      Value<int> currentStreak,
      Value<int> bestStreak,
      Value<int> rowid,
    });

class $$GameStatisticsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GameStatisticsTableTable> {
  $$GameStatisticsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get modeKey => $composableBuilder(
    column: $table.modeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gamesPlayed => $composableBuilder(
    column: $table.gamesPlayed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gamesWon => $composableBuilder(
    column: $table.gamesWon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestScore => $composableBuilder(
    column: $table.bestScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestCombo => $composableBuilder(
    column: $table.bestCombo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPairsMatched => $composableBuilder(
    column: $table.totalPairsMatched,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalNumbersAdded => $composableBuilder(
    column: $table.totalNumbersAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTimeSeconds => $composableBuilder(
    column: $table.totalTimeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GameStatisticsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GameStatisticsTableTable> {
  $$GameStatisticsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get modeKey => $composableBuilder(
    column: $table.modeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gamesPlayed => $composableBuilder(
    column: $table.gamesPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gamesWon => $composableBuilder(
    column: $table.gamesWon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestScore => $composableBuilder(
    column: $table.bestScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestCombo => $composableBuilder(
    column: $table.bestCombo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPairsMatched => $composableBuilder(
    column: $table.totalPairsMatched,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalNumbersAdded => $composableBuilder(
    column: $table.totalNumbersAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTimeSeconds => $composableBuilder(
    column: $table.totalTimeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GameStatisticsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameStatisticsTableTable> {
  $$GameStatisticsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get modeKey =>
      $composableBuilder(column: $table.modeKey, builder: (column) => column);

  GeneratedColumn<int> get gamesPlayed => $composableBuilder(
    column: $table.gamesPlayed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gamesWon =>
      $composableBuilder(column: $table.gamesWon, builder: (column) => column);

  GeneratedColumn<int> get bestScore =>
      $composableBuilder(column: $table.bestScore, builder: (column) => column);

  GeneratedColumn<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestCombo =>
      $composableBuilder(column: $table.bestCombo, builder: (column) => column);

  GeneratedColumn<int> get totalPairsMatched => $composableBuilder(
    column: $table.totalPairsMatched,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalNumbersAdded => $composableBuilder(
    column: $table.totalNumbersAdded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTimeSeconds => $composableBuilder(
    column: $table.totalTimeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => column,
  );
}

class $$GameStatisticsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameStatisticsTableTable,
          GameStatisticsEntry,
          $$GameStatisticsTableTableFilterComposer,
          $$GameStatisticsTableTableOrderingComposer,
          $$GameStatisticsTableTableAnnotationComposer,
          $$GameStatisticsTableTableCreateCompanionBuilder,
          $$GameStatisticsTableTableUpdateCompanionBuilder,
          (
            GameStatisticsEntry,
            BaseReferences<
              _$AppDatabase,
              $GameStatisticsTableTable,
              GameStatisticsEntry
            >,
          ),
          GameStatisticsEntry,
          PrefetchHooks Function()
        > {
  $$GameStatisticsTableTableTableManager(
    _$AppDatabase db,
    $GameStatisticsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameStatisticsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameStatisticsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GameStatisticsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> modeKey = const Value.absent(),
                Value<int> gamesPlayed = const Value.absent(),
                Value<int> gamesWon = const Value.absent(),
                Value<int> bestScore = const Value.absent(),
                Value<int> totalScore = const Value.absent(),
                Value<int> bestCombo = const Value.absent(),
                Value<int> totalPairsMatched = const Value.absent(),
                Value<int> totalNumbersAdded = const Value.absent(),
                Value<int> totalTimeSeconds = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameStatisticsTableCompanion(
                modeKey: modeKey,
                gamesPlayed: gamesPlayed,
                gamesWon: gamesWon,
                bestScore: bestScore,
                totalScore: totalScore,
                bestCombo: bestCombo,
                totalPairsMatched: totalPairsMatched,
                totalNumbersAdded: totalNumbersAdded,
                totalTimeSeconds: totalTimeSeconds,
                currentStreak: currentStreak,
                bestStreak: bestStreak,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String modeKey,
                Value<int> gamesPlayed = const Value.absent(),
                Value<int> gamesWon = const Value.absent(),
                Value<int> bestScore = const Value.absent(),
                Value<int> totalScore = const Value.absent(),
                Value<int> bestCombo = const Value.absent(),
                Value<int> totalPairsMatched = const Value.absent(),
                Value<int> totalNumbersAdded = const Value.absent(),
                Value<int> totalTimeSeconds = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameStatisticsTableCompanion.insert(
                modeKey: modeKey,
                gamesPlayed: gamesPlayed,
                gamesWon: gamesWon,
                bestScore: bestScore,
                totalScore: totalScore,
                bestCombo: bestCombo,
                totalPairsMatched: totalPairsMatched,
                totalNumbersAdded: totalNumbersAdded,
                totalTimeSeconds: totalTimeSeconds,
                currentStreak: currentStreak,
                bestStreak: bestStreak,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GameStatisticsTableTable, GameStatisticsEntry>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $GameStatisticsTableTable,
                    GameStatisticsEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GameStatisticsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameStatisticsTableTable,
      GameStatisticsEntry,
      $$GameStatisticsTableTableFilterComposer,
      $$GameStatisticsTableTableOrderingComposer,
      $$GameStatisticsTableTableAnnotationComposer,
      $$GameStatisticsTableTableCreateCompanionBuilder,
      $$GameStatisticsTableTableUpdateCompanionBuilder,
      (
        GameStatisticsEntry,
        BaseReferences<
          _$AppDatabase,
          $GameStatisticsTableTable,
          GameStatisticsEntry
        >,
      ),
      GameStatisticsEntry,
      PrefetchHooks Function()
    >;
typedef $$PlayerWalletsTableTableCreateCompanionBuilder =
    PlayerWalletsTableCompanion Function({
      required String id,
      Value<int> coins,
      Value<int> totalCoinsEarned,
      Value<int> totalCoinsSpent,
      Value<int> rowid,
    });
typedef $$PlayerWalletsTableTableUpdateCompanionBuilder =
    PlayerWalletsTableCompanion Function({
      Value<String> id,
      Value<int> coins,
      Value<int> totalCoinsEarned,
      Value<int> totalCoinsSpent,
      Value<int> rowid,
    });

class $$PlayerWalletsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerWalletsTableTable> {
  $$PlayerWalletsTableTableFilterComposer({
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

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCoinsEarned => $composableBuilder(
    column: $table.totalCoinsEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCoinsSpent => $composableBuilder(
    column: $table.totalCoinsSpent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayerWalletsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerWalletsTableTable> {
  $$PlayerWalletsTableTableOrderingComposer({
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

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCoinsEarned => $composableBuilder(
    column: $table.totalCoinsEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCoinsSpent => $composableBuilder(
    column: $table.totalCoinsSpent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayerWalletsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerWalletsTableTable> {
  $$PlayerWalletsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);

  GeneratedColumn<int> get totalCoinsEarned => $composableBuilder(
    column: $table.totalCoinsEarned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCoinsSpent => $composableBuilder(
    column: $table.totalCoinsSpent,
    builder: (column) => column,
  );
}

class $$PlayerWalletsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerWalletsTableTable,
          PlayerWalletEntry,
          $$PlayerWalletsTableTableFilterComposer,
          $$PlayerWalletsTableTableOrderingComposer,
          $$PlayerWalletsTableTableAnnotationComposer,
          $$PlayerWalletsTableTableCreateCompanionBuilder,
          $$PlayerWalletsTableTableUpdateCompanionBuilder,
          (
            PlayerWalletEntry,
            BaseReferences<
              _$AppDatabase,
              $PlayerWalletsTableTable,
              PlayerWalletEntry
            >,
          ),
          PlayerWalletEntry,
          PrefetchHooks Function()
        > {
  $$PlayerWalletsTableTableTableManager(
    _$AppDatabase db,
    $PlayerWalletsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerWalletsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerWalletsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerWalletsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> totalCoinsEarned = const Value.absent(),
                Value<int> totalCoinsSpent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerWalletsTableCompanion(
                id: id,
                coins: coins,
                totalCoinsEarned: totalCoinsEarned,
                totalCoinsSpent: totalCoinsSpent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> coins = const Value.absent(),
                Value<int> totalCoinsEarned = const Value.absent(),
                Value<int> totalCoinsSpent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerWalletsTableCompanion.insert(
                id: id,
                coins: coins,
                totalCoinsEarned: totalCoinsEarned,
                totalCoinsSpent: totalCoinsSpent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlayerWalletsTableTable, PlayerWalletEntry>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $PlayerWalletsTableTable,
                    PlayerWalletEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayerWalletsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerWalletsTableTable,
      PlayerWalletEntry,
      $$PlayerWalletsTableTableFilterComposer,
      $$PlayerWalletsTableTableOrderingComposer,
      $$PlayerWalletsTableTableAnnotationComposer,
      $$PlayerWalletsTableTableCreateCompanionBuilder,
      $$PlayerWalletsTableTableUpdateCompanionBuilder,
      (
        PlayerWalletEntry,
        BaseReferences<
          _$AppDatabase,
          $PlayerWalletsTableTable,
          PlayerWalletEntry
        >,
      ),
      PlayerWalletEntry,
      PrefetchHooks Function()
    >;
typedef $$EntitlementsTableTableCreateCompanionBuilder =
    EntitlementsTableCompanion Function({
      required String productId,
      Value<bool> isEntitled,
      Value<DateTime?> purchasedAt,
      Value<String?> transactionId,
      Value<String?> signature,
      Value<bool> isSandbox,
      Value<int> rowid,
    });
typedef $$EntitlementsTableTableUpdateCompanionBuilder =
    EntitlementsTableCompanion Function({
      Value<String> productId,
      Value<bool> isEntitled,
      Value<DateTime?> purchasedAt,
      Value<String?> transactionId,
      Value<String?> signature,
      Value<bool> isSandbox,
      Value<int> rowid,
    });

class $$EntitlementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EntitlementsTableTable> {
  $$EntitlementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEntitled => $composableBuilder(
    column: $table.isEntitled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signature => $composableBuilder(
    column: $table.signature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSandbox => $composableBuilder(
    column: $table.isSandbox,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EntitlementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EntitlementsTableTable> {
  $$EntitlementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEntitled => $composableBuilder(
    column: $table.isEntitled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signature => $composableBuilder(
    column: $table.signature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSandbox => $composableBuilder(
    column: $table.isSandbox,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntitlementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntitlementsTableTable> {
  $$EntitlementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<bool> get isEntitled => $composableBuilder(
    column: $table.isEntitled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signature =>
      $composableBuilder(column: $table.signature, builder: (column) => column);

  GeneratedColumn<bool> get isSandbox =>
      $composableBuilder(column: $table.isSandbox, builder: (column) => column);
}

class $$EntitlementsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntitlementsTableTable,
          EntitlementEntry,
          $$EntitlementsTableTableFilterComposer,
          $$EntitlementsTableTableOrderingComposer,
          $$EntitlementsTableTableAnnotationComposer,
          $$EntitlementsTableTableCreateCompanionBuilder,
          $$EntitlementsTableTableUpdateCompanionBuilder,
          (
            EntitlementEntry,
            BaseReferences<
              _$AppDatabase,
              $EntitlementsTableTable,
              EntitlementEntry
            >,
          ),
          EntitlementEntry,
          PrefetchHooks Function()
        > {
  $$EntitlementsTableTableTableManager(
    _$AppDatabase db,
    $EntitlementsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitlementsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitlementsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitlementsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<bool> isEntitled = const Value.absent(),
                Value<DateTime?> purchasedAt = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> signature = const Value.absent(),
                Value<bool> isSandbox = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitlementsTableCompanion(
                productId: productId,
                isEntitled: isEntitled,
                purchasedAt: purchasedAt,
                transactionId: transactionId,
                signature: signature,
                isSandbox: isSandbox,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                Value<bool> isEntitled = const Value.absent(),
                Value<DateTime?> purchasedAt = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> signature = const Value.absent(),
                Value<bool> isSandbox = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitlementsTableCompanion.insert(
                productId: productId,
                isEntitled: isEntitled,
                purchasedAt: purchasedAt,
                transactionId: transactionId,
                signature: signature,
                isSandbox: isSandbox,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EntitlementsTableTable, EntitlementEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $EntitlementsTableTable,
                    EntitlementEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EntitlementsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntitlementsTableTable,
      EntitlementEntry,
      $$EntitlementsTableTableFilterComposer,
      $$EntitlementsTableTableOrderingComposer,
      $$EntitlementsTableTableAnnotationComposer,
      $$EntitlementsTableTableCreateCompanionBuilder,
      $$EntitlementsTableTableUpdateCompanionBuilder,
      (
        EntitlementEntry,
        BaseReferences<
          _$AppDatabase,
          $EntitlementsTableTable,
          EntitlementEntry
        >,
      ),
      EntitlementEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GameSessionsTableTableTableManager get gameSessionsTable =>
      $$GameSessionsTableTableTableManager(_db, _db.gameSessionsTable);
  $$DailyChallengesTableTableTableManager get dailyChallengesTable =>
      $$DailyChallengesTableTableTableManager(_db, _db.dailyChallengesTable);
  $$GameStatisticsTableTableTableManager get gameStatisticsTable =>
      $$GameStatisticsTableTableTableManager(_db, _db.gameStatisticsTable);
  $$PlayerWalletsTableTableTableManager get playerWalletsTable =>
      $$PlayerWalletsTableTableTableManager(_db, _db.playerWalletsTable);
  $$EntitlementsTableTableTableManager get entitlementsTable =>
      $$EntitlementsTableTableTableManager(_db, _db.entitlementsTable);
}
