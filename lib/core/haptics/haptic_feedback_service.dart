import 'package:flutter/services.dart';

class HapticFeedbackService {
  final bool isEnabled;

  const HapticFeedbackService({this.isEnabled = true});

  Future<void> selection() async {
    if (!isEnabled) return;
    await HapticFeedback.selectionClick();
  }

  Future<void> matchSuccess() async {
    if (!isEnabled) return;
    await HapticFeedback.mediumImpact();
  }

  Future<void> comboBonus() async {
    if (!isEnabled) return;
    await HapticFeedback.heavyImpact();
  }

  Future<void> invalid() async {
    if (!isEnabled) return;
    await HapticFeedback.vibrate();
  }

  Future<void> buttonTap() async {
    if (!isEnabled) return;
    await HapticFeedback.lightImpact();
  }
}
