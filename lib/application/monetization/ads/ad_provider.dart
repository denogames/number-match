abstract class AdProvider {
  Future<void> initialize();
  Future<bool> isInterstitialReady();
  Future<bool> showInterstitial();
  Future<bool> isRewardedReady();
  Future<bool> showRewarded({required void Function() onUserEarnedReward});
}
