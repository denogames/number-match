import 'dart:async';
import 'analytics_event.dart';

abstract class AnalyticsBackend {
  Future<void> sendEvent(AnalyticsEvent event);
}

class ConsoleAnalyticsBackend implements AnalyticsBackend {
  @override
  Future<void> sendEvent(AnalyticsEvent event) async {
    // In production, forward to Firebase / Segment / custom pipeline
    // Avoid PII logging
  }
}

class AnalyticsService {
  final AnalyticsBackend backend;
  bool isEnabled;

  final List<AnalyticsEvent> _loggedEvents = [];
  final _eventController = StreamController<AnalyticsEvent>.broadcast();

  AnalyticsService({
    AnalyticsBackend? backend,
    this.isEnabled = true,
  }) : backend = backend ?? ConsoleAnalyticsBackend();

  Stream<AnalyticsEvent> get eventStream => _eventController.stream;
  List<AnalyticsEvent> get loggedEvents => List.unmodifiable(_loggedEvents);

  Future<void> logEvent(
    AnalyticsEventType type, [
    Map<String, dynamic> parameters = const {},
  ]) async {
    if (!isEnabled) return;

    final event = AnalyticsEvent(
      type: type,
      parameters: parameters,
    );

    _loggedEvents.add(event);
    _eventController.add(event);

    try {
      await backend.sendEvent(event);
    } catch (_) {
      // Never let analytics failure crash the application
    }
  }

  void clearHistory() {
    _loggedEvents.clear();
  }

  void dispose() {
    _eventController.close();
  }
}
