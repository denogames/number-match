import '../../analytics/analytics_event.dart';
import '../../analytics/analytics_service.dart';
import '../iap/entitlement_state.dart';
import 'ad_provider.dart';

class AdService {
  final AdProvider provider;
  final AnalyticsService analyticsService;
  final EntitlementState entitlementState;

  // Interstitial frequency limits
  final Duration minInterstitialInterval;
  DateTime? _lastInterstitialShownAt;

  AdService({
    required this.provider,
    required this.analyticsService,
    required this.entitlementState,
    this.minInterstitialInterval = const Duration(seconds: 120),
  });

  Future<void> initialize() async {
    await provider.initialize();
  }

  bool get isAdsFree => entitlementState.isAdsFree;

  bool get canShowInterstitial {
    if (isAdsFree) return false;
    if (_lastInterstitialShownAt == null) return true;
    final elapsed = DateTime.now().difference(_lastInterstitialShownAt!);
    return elapsed >= minInterstitialInterval;
  }

  // Shows interstitial only during natural breaks (game completion, returning to menu)
  // NEVER during active gameplay or cell selection!
  Future<bool> showBreakInterstitial({required String placement}) async {
    if (!canShowInterstitial) return false;

    final success = await provider.showInterstitial();
    if (success) {
      _lastInterstitialShownAt = DateTime.now();
      await analyticsService.logEvent(AnalyticsEventType.adImpression, {
        'ad_type': 'interstitial',
        'placement': placement,
      });
      return true;
    }
    return false;
  }

  // Shows rewarded ad with instant claim privilege for Ads Free users!
  Future<bool> showRewarded({
    required String placement,
    required void Function() onRewardEarned,
  }) async {
    // If player purchased Ads Free, reward is granted immediately with zero ad waiting!
    if (isAdsFree) {
      onRewardEarned();
      await analyticsService.logEvent(AnalyticsEventType.rewardedAdCompleted, {
        'placement': placement,
        'via_ads_free_perk': true,
      });
      return true;
    }

    final success = await provider.showRewarded(
      onUserEarnedReward: () {
        onRewardEarned();
        analyticsService.logEvent(AnalyticsEventType.rewardedAdCompleted, {
          'placement': placement,
          'via_ads_free_perk': false,
        });
      },
    );

    return success;
  }
}
