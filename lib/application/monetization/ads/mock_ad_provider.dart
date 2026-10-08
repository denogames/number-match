import 'ad_provider.dart';

class MockAdProvider implements AdProvider {
  bool isInitialized = false;
  bool shouldSimulateFailure = false;
  int interstitialImpressions = 0;
  int rewardedImpressions = 0;

  @override
  Future<void> initialize() async {
    isInitialized = true;
  }

  @override
  Future<bool> isInterstitialReady() async => true;

  @override
  Future<bool> showInterstitial() async {
    if (shouldSimulateFailure) return false;
    interstitialImpressions++;
    // Simulate brief network delay
    await Future.delayed(const Duration(milliseconds: 150));
    return true;
  }

  @override
  Future<bool> isRewardedReady() async => true;

  @override
  Future<bool> showRewarded({required void Function() onUserEarnedReward}) async {
    if (shouldSimulateFailure) return false;
    rewardedImpressions++;
    await Future.delayed(const Duration(milliseconds: 200));
    onUserEarnedReward();
    return true;
  }
}
