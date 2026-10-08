import 'package:flutter/services.dart';

class AudioFeedbackService {
  final bool isEnabled;

  const AudioFeedbackService({this.isEnabled = true});

  Future<void> playSelect() async {
    if (!isEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  Future<void> playMatch() async {
    if (!isEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  Future<void> playCombo() async {
    if (!isEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  Future<void> playInvalid() async {
    if (!isEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.alert);
    } catch (_) {}
  }

  Future<void> playVictory() async {
    if (!isEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }
}
