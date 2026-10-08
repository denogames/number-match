// Game mode definitions for Number Match.

enum GameMode {
  classic,
  daily,
  timed,
}

extension GameModeExtension on GameMode {
  String get displayName {
    switch (this) {
      case GameMode.classic:
        return 'Classic';
      case GameMode.daily:
        return 'Daily Challenge';
      case GameMode.timed:
        return 'Timed Rush';
    }
  }

  String get description {
    switch (this) {
      case GameMode.classic:
        return 'Relaxed, untimed gameplay with automatic saving.';
      case GameMode.daily:
        return 'Deterministic calendar challenge for all players.';
      case GameMode.timed:
        return 'Race against the clock to score maximum points.';
    }
  }

  String get storageKey {
    switch (this) {
      case GameMode.classic:
        return 'classic';
      case GameMode.daily:
        return 'daily';
      case GameMode.timed:
        return 'timed';
    }
  }

  static GameMode fromStorageKey(String key) {
    switch (key) {
      case 'daily':
        return GameMode.daily;
      case 'timed':
        return GameMode.timed;
      case 'classic':
      default:
        return GameMode.classic;
    }
  }
}
