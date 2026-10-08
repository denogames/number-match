import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/application/analytics/analytics_service.dart';
import 'package:number_match/application/monetization/ads/ad_service.dart';
import 'package:number_match/application/monetization/ads/mock_ad_provider.dart';
import 'package:number_match/application/monetization/iap/entitlement_state.dart';
import 'package:number_match/application/monetization/iap/purchase_verifier.dart';

void main() {
  late AnalyticsService analyticsService;
  late MockAdProvider adProvider;
  late EntitlementState entitlementState;
  late AdService adService;

  setUp(() {
    analyticsService = AnalyticsService();
    adProvider = MockAdProvider();
    entitlementState = EntitlementState();
    adService = AdService(
      provider: adProvider,
      analyticsService: analyticsService,
      entitlementState: entitlementState,
      minInterstitialInterval: const Duration(seconds: 1),
    );
  });

  group('Monetization - Entitlement and Ads Free', () {
    test('entitlementState starts false and notifies listeners on change', () {
      expect(entitlementState.isAdsFree, isFalse);
      bool notified = false;
      entitlementState.addListener(() => notified = true);

      entitlementState.setAdsFree(true);
      expect(entitlementState.isAdsFree, isTrue);
      expect(notified, isTrue);
    });

    test('interstitials are shown when not ads free and cooldown has elapsed', () async {
      await adService.initialize();
      expect(adService.canShowInterstitial, isTrue);

      final shown = await adService.showBreakInterstitial(placement: 'post_game');
      expect(shown, isTrue);
      expect(adProvider.interstitialImpressions, 1);

      // Immediately after showing, cooldown should prevent another forced ad
      expect(adService.canShowInterstitial, isFalse);
      final immediateSecondTry = await adService.showBreakInterstitial(placement: 'post_game');
      expect(immediateSecondTry, isFalse);
      expect(adProvider.interstitialImpressions, 1);
    });

    test('interstitials are completely suppressed when Ads Free is active', () async {
      entitlementState.setAdsFree(true);
      expect(adService.canShowInterstitial, isFalse);

      final shown = await adService.showBreakInterstitial(placement: 'post_game');
      expect(shown, isFalse);
      expect(adProvider.interstitialImpressions, 0);
    });

    test('rewarded ads give instant reward without watching for Ads Free players', () async {
      entitlementState.setAdsFree(true);
      bool rewardReceived = false;

      final success = await adService.showRewarded(
        placement: 'shop_bonus',
        onRewardEarned: () {
          rewardReceived = true;
        },
      );

      expect(success, isTrue);
      expect(rewardReceived, isTrue);
      // Provider was NOT called because player has Ads Free perk!
      expect(adProvider.rewardedImpressions, 0);
    });

    test('rewarded ads invoke provider when not Ads Free', () async {
      entitlementState.setAdsFree(false);
      bool rewardReceived = false;

      final success = await adService.showRewarded(
        placement: 'shop_bonus',
        onRewardEarned: () {
          rewardReceived = true;
        },
      );

      expect(success, isTrue);
      expect(rewardReceived, isTrue);
      expect(adProvider.rewardedImpressions, 1);
    });
  });

  group('Monetization - Purchase Verifier', () {
    test('SandboxPurchaseVerifier successfully validates tokens', () async {
      final verifier = SandboxPurchaseVerifier();
      final result = await verifier.verify(
        productId: 'com.numbermatch.game.ads_free',
        purchaseID: 'tx_12345',
        verificationData: 'dummy_payload',
        source: 'google_play',
      );

      expect(result.isValid, isTrue);
      expect(result.transactionId, 'tx_12345');
      expect(result.signature, isNotNull);
    });

    test('SandboxPurchaseVerifier rejects empty tokens', () async {
      final verifier = SandboxPurchaseVerifier();
      final result = await verifier.verify(
        productId: 'com.numbermatch.game.ads_free',
        purchaseID: 'tx_12345',
        verificationData: '',
        source: 'google_play',
      );

      expect(result.isValid, isFalse);
      expect(result.errorMessage, isNotNull);
    });
  });
}
