import 'ad_provider.dart';

/// Clean placeholder hook for future AdMob / mediation integration.
/// Strictly non-functional in offline v1 mode: emits zero network calls and grants zero fake rewards.
class AdMobPlaceholderAdProvider implements AdProvider {
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    _initialized = true;
  }

  bool get isInitialized => _initialized;

  @override
  Future<bool> isInterstitialReady() async => false;

  @override
  Future<bool> showInterstitial() async => false;

  @override
  Future<bool> isRewardedReady() async => false;

  @override
  Future<bool> showRewarded({required void Function() onUserEarnedReward}) async => false;
}
