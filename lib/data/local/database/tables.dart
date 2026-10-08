import 'package:drift/drift.dart';

@DataClassName('GameSessionEntry')
class GameSessionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get mode => text()();
  TextColumn get boardJson => text()();
  IntColumn get score => integer().withDefault(const Constant(0))();
  IntColumn get combo => integer().withDefault(const Constant(1))();
  IntColumn get maxCombo => integer().withDefault(const Constant(1))();
  IntColumn get matchesCount => integer().withDefault(const Constant(0))();
  IntColumn get addsCount => integer().withDefault(const Constant(0))();
  IntColumn get elapsedSeconds => integer().withDefault(const Constant(0))();
  IntColumn get selectedIndex => integer().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isWon => boolean().withDefault(const Constant(false))();
  IntColumn get targetScore => integer().nullable()();
  IntColumn get targetTimeSeconds => integer().nullable()();
  IntColumn get seed => integer().nullable()();
  TextColumn get undoHistoryJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DailyChallengeEntry')
class DailyChallengesTable extends Table {
  TextColumn get dateKey => text()(); // YYYY-MM-DD
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get score => integer().withDefault(const Constant(0))();
  IntColumn get moves => integer().withDefault(const Constant(0))();
  IntColumn get elapsedSeconds => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {dateKey};
}

@DataClassName('GameStatisticsEntry')
class GameStatisticsTable extends Table {
  TextColumn get modeKey => text()(); // classic, daily, timed, global
  IntColumn get gamesPlayed => integer().withDefault(const Constant(0))();
  IntColumn get gamesWon => integer().withDefault(const Constant(0))();
  IntColumn get bestScore => integer().withDefault(const Constant(0))();
  IntColumn get totalScore => integer().withDefault(const Constant(0))();
  IntColumn get bestCombo => integer().withDefault(const Constant(0))();
  IntColumn get totalPairsMatched => integer().withDefault(const Constant(0))();
  IntColumn get totalNumbersAdded => integer().withDefault(const Constant(0))();
  IntColumn get totalTimeSeconds => integer().withDefault(const Constant(0))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get bestStreak => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {modeKey};
}

@DataClassName('PlayerWalletEntry')
class PlayerWalletsTable extends Table {
  TextColumn get id => text()();
  IntColumn get coins => integer().withDefault(const Constant(200))(); // Starting 200 coins
  IntColumn get totalCoinsEarned => integer().withDefault(const Constant(200))();
  IntColumn get totalCoinsSpent => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('EntitlementEntry')
class EntitlementsTable extends Table {
  TextColumn get productId => text()();
  BoolColumn get isEntitled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get purchasedAt => dateTime().nullable()();
  TextColumn get transactionId => text().nullable()();
  TextColumn get signature => text().nullable()();
  BoolColumn get isSandbox => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {productId};
}
