import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:studio_core_sdk/studio_core_sdk.dart';
import '../../core/constants/game_constants.dart';
import '../../domain/models/game_mode.dart';
import '../../domain/repositories/settings_repository.dart';
import '../analytics/analytics_event.dart';
import '../analytics/analytics_service.dart';

class RewardService {
  final SettingsRepository settingsRepository;
  final AnalyticsService analyticsService;

  final _coinStreamController = StreamController<int>.broadcast();
  int _cachedCoins = GameConstants.startingCoins;
  VoidCallback? _removeWalletListener;

  RewardService({
    required this.settingsRepository,
    required this.analyticsService,
  });

  Stream<int> get coinStream => _coinStreamController.stream;
  int get currentCoins => _cachedCoins;

  int get currentHintCost {
    if (StudioSdk.isInitialized) {
      return StudioSdk.instance.liveOps.getBalanceValue<int>(
        'hintCostCoins',
        defaultValue: GameConstants.hintCostCoins,
      );
    }
    return GameConstants.hintCostCoins;
  }

  Future<void> initialize() async {
    final localCoins = await settingsRepository.getCoins();
    if (StudioSdk.isInitialized) {
      final sdkWallet = StudioSdk.instance.wallet;
      final sdkCoins = sdkWallet.gold;
      if (sdkCoins > 0) {
        _cachedCoins = sdkCoins;
      } else if (localCoins > 0) {
        _cachedCoins = localCoins;
        await sdkWallet.setExactBalance(
          StudioCurrencyIds.gold,
          localCoins,
          recordInOutbox: false,
        );
      } else {
        _cachedCoins = GameConstants.startingCoins;
        await sdkWallet.setExactBalance(
          StudioCurrencyIds.gold,
          _cachedCoins,
          recordInOutbox: false,
        );
      }

      final coinListenable = sdkWallet.watchCurrency(StudioCurrencyIds.gold);
      void onSdkCoinChanged() {
        final val = coinListenable.value;
        if (val != _cachedCoins) {
          _cachedCoins = val;
          _coinStreamController.add(_cachedCoins);
          unawaited(settingsRepository.setCoins(_cachedCoins));
        }
      }

      coinListenable.addListener(onSdkCoinChanged);
      _removeWalletListener = () => coinListenable.removeListener(onSdkCoinChanged);
    } else {
      _cachedCoins = localCoins;
    }
    _coinStreamController.add(_cachedCoins);
  }

  Future<int> addCoins(int amount, {required String reason}) async {
    if (amount <= 0) return _cachedCoins;

    if (StudioSdk.isInitialized) {
      await StudioSdk.instance.wallet.credit(
        StudioCurrencyIds.gold,
        amount,
        source: reason,
      );
      _cachedCoins = StudioSdk.instance.wallet.gold;
    } else {
      _cachedCoins += amount;
    }

    await settingsRepository.setCoins(_cachedCoins);
    _coinStreamController.add(_cachedCoins);

    return _cachedCoins;
  }

  Future<bool> spendCoins(int amount, {required String reason}) async {
    if (amount <= 0) return true;

    if (StudioSdk.isInitialized) {
      final success = await StudioSdk.instance.wallet.trySpend(
        StudioCurrencyIds.gold,
        amount,
        reason: reason,
      );
      if (!success) return false;
      _cachedCoins = StudioSdk.instance.wallet.gold;
    } else {
      if (_cachedCoins < amount) return false;
      _cachedCoins -= amount;
    }

    await settingsRepository.setCoins(_cachedCoins);
    _coinStreamController.add(_cachedCoins);

    return true;
  }

  Future<bool> canAffordHint() async {
    return _cachedCoins >= currentHintCost;
  }

  Future<bool> spendForHint() async {
    final cost = currentHintCost;
    final success = await spendCoins(
      cost,
      reason: 'hint_purchased',
    );
    if (success) {
      await analyticsService.logEvent(AnalyticsEventType.hintUsed, {
        'cost': cost,
        'remaining_coins': _cachedCoins,
      });
    }
    return success;
  }

  Future<int> awardMatchBonus(int matchesCount) async {
    // Every 5 matches, award 5 bonus coins
    if (matchesCount > 0 && matchesCount % 5 == 0) {
      const reward = 5;
      await addCoins(reward, reason: 'matches_milestone');
      return reward;
    }
    return 0;
  }

  Future<int> awardRowClearBonus() async {
    const reward = 10;
    await addCoins(reward, reason: 'row_clear_bonus');
    return reward;
  }

  Future<int> awardGameVictory(GameMode mode, int score) async {
    final defaultReward = mode == GameMode.daily
        ? GameConstants.dailyChallengeRewardCoins
        : GameConstants.gameWinRewardCoins;
    final configKey = mode == GameMode.daily
        ? 'dailyChallengeRewardCoins'
        : 'gameWinRewardCoins';
    final reward = StudioSdk.isInitialized
        ? StudioSdk.instance.liveOps.getBalanceValue<int>(
            configKey,
            defaultValue: defaultReward,
          )
        : defaultReward;

    await addCoins(reward, reason: 'victory_${mode.storageKey}');
    return reward;
  }

  Future<int> awardRewardedAd() async {
    final defaultReward = GameConstants.rewardedAdCoins;
    final reward = StudioSdk.isInitialized
        ? StudioSdk.instance.liveOps.getBalanceValue<int>(
            'rewardedAdCoins',
            defaultValue: defaultReward,
          )
        : defaultReward;

    await addCoins(reward, reason: 'rewarded_ad_watched');
    await analyticsService.logEvent(AnalyticsEventType.rewardedAdCompleted, {
      'coins_awarded': reward,
    });
    return reward;
  }

  void dispose() {
    _removeWalletListener?.call();
    _coinStreamController.close();
  }
}
