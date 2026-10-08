// Analytics event definitions for Number Match game.

enum AnalyticsEventType {
  firstOpen,
  tutorialStarted,
  tutorialCompleted,
  gameStarted,
  pairMatched,
  invalidPair,
  numbersAdded,
  hintUsed,
  undoUsed,
  gameCompleted,
  gameAbandoned,
  adImpression,
  rewardedAdCompleted,
  iapPurchaseStarted,
  iapPurchaseVerified,
  iapPurchaseFailed,
  adsFreeActivated,
}

extension AnalyticsEventTypeExtension on AnalyticsEventType {
  String get eventName {
    switch (this) {
      case AnalyticsEventType.firstOpen:
        return 'first_open';
      case AnalyticsEventType.tutorialStarted:
        return 'tutorial_started';
      case AnalyticsEventType.tutorialCompleted:
        return 'tutorial_completed';
      case AnalyticsEventType.gameStarted:
        return 'game_started';
      case AnalyticsEventType.pairMatched:
        return 'pair_matched';
      case AnalyticsEventType.invalidPair:
        return 'invalid_pair';
      case AnalyticsEventType.numbersAdded:
        return 'numbers_added';
      case AnalyticsEventType.hintUsed:
        return 'hint_used';
      case AnalyticsEventType.undoUsed:
        return 'undo_used';
      case AnalyticsEventType.gameCompleted:
        return 'game_completed';
      case AnalyticsEventType.gameAbandoned:
        return 'game_abandoned';
      case AnalyticsEventType.adImpression:
        return 'ad_impression';
      case AnalyticsEventType.rewardedAdCompleted:
        return 'rewarded_ad_completed';
      case AnalyticsEventType.iapPurchaseStarted:
        return 'iap_purchase_started';
      case AnalyticsEventType.iapPurchaseVerified:
        return 'iap_purchase_verified';
      case AnalyticsEventType.iapPurchaseFailed:
        return 'iap_purchase_failed';
      case AnalyticsEventType.adsFreeActivated:
        return 'ads_free_activated';
    }
  }
}

class AnalyticsEvent {
  final AnalyticsEventType type;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;

  AnalyticsEvent({
    required this.type,
    this.parameters = const {},
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'event': type.eventName,
      'timestamp': timestamp.toIso8601String(),
      'parameters': parameters,
    };
  }

  @override
  String toString() => 'AnalyticsEvent(${type.eventName}, $parameters)';
}
