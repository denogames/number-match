import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers.dart';
import '../../../core/constants/game_constants.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/coin_chip.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;
    final entitlement = ref.watch(entitlementStateProvider);
    final iapService = ref.watch(iapServiceProvider);
    final adService = ref.watch(adServiceProvider);
    final rewardService = ref.watch(rewardServiceProvider);

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: theme.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Shop',
          style: TextStyle(
            fontSize: 18.0 * settings.textScale,
            fontWeight: FontWeight.w700,
            color: theme.textPrimary,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: CoinChip()),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: entitlement,
          builder: (context, _) {
            final isAdsFree = entitlement.isAdsFree;
            return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // 1. Ads Free (Lifetime) Non-Consumable Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isAdsFree
                      ? [
                          theme.cellHintBorder.withValues(alpha: 0.15),
                          theme.cellHintBorder.withValues(alpha: 0.05),
                        ]
                      : [
                          theme.primary.withValues(alpha: 0.15),
                          theme.surface,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isAdsFree ? theme.cellHintBorder : theme.primary,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isAdsFree
                                ? Icons.verified_rounded
                                : Icons.block_rounded,
                            color:
                                isAdsFree ? theme.cellHintBorder : theme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'ADS FREE (LIFETIME)',
                            style: TextStyle(
                              fontSize: 16.0 * settings.textScale,
                              fontWeight: FontWeight.w900,
                              color: theme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      if (isAdsFree)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.cellHintBorder,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'ACTIVE ✓',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isAdsFree
                        ? 'All automatic ads permanently removed. Rewarded ad perks can be claimed instantly without waiting!'
                        : 'Permanently remove all automatic interstitial and banner advertisements. Includes instant claims for rewarded bonuses.',
                    style: TextStyle(
                      fontSize: 14.0 * settings.textScale,
                      color: theme.textSecondary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!isAdsFree) ...[
                    AppButton(
                      label: 'Unlock for \$2.99',
                      icon: Icons.shopping_bag_rounded,
                      isFullWidth: true,
                      onPressed: () async {
                        await iapService.buyAdsFree();
                      },
                      textScale: settings.textScale,
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          await iapService.restorePurchases();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Purchases restored successfully.'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Restore Purchases',
                          style: TextStyle(
                            fontSize: 13.0 * settings.textScale,
                            fontWeight: FontWeight.w600,
                            color: theme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Free Coins (Rewarded Ad or Instant Claim)
            Text(
              'FREE REWARDS',
              style: TextStyle(
                fontSize: 12.0 * settings.textScale,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: theme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.divider),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.accent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.video_library_rounded,
                      color: theme.accent,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '+${GameConstants.rewardedAdCoins} Coins',
                          style: TextStyle(
                            fontSize: 16.0 * settings.textScale,
                            fontWeight: FontWeight.w800,
                            color: theme.textPrimary,
                          ),
                        ),
                        Text(
                          isAdsFree
                              ? 'Instant Claim (Ads Free Perk)'
                              : 'Watch a short sponsor video',
                          style: TextStyle(
                            fontSize: 13.0 * settings.textScale,
                            color: theme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      foregroundColor: theme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await adService.showRewarded(
                        placement: 'shop_reward',
                        onRewardEarned: () async {
                          await rewardService.awardRewardedAd();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '+${GameConstants.rewardedAdCoins} Coins added!',
                                ),
                                backgroundColor: theme.accent,
                              ),
                            );
                          }
                        },
                      );
                    },
                    child: Text(isAdsFree ? 'Claim' : 'Watch'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Coin Bundles
            Text(
              'COIN BUNDLES',
              style: TextStyle(
                fontSize: 12.0 * settings.textScale,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: theme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            _CoinBundleTile(
              coins: 500,
              price: '\$0.99',
              theme: theme,
              textScale: settings.textScale,
              onBuy: () async {
                await rewardService.addCoins(500, reason: 'bundle_500');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('+500 Coins added!')),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            _CoinBundleTile(
              coins: 1500,
              price: '\$1.99',
              badge: 'POPULAR',
              theme: theme,
              textScale: settings.textScale,
              onBuy: () async {
                await rewardService.addCoins(1500, reason: 'bundle_1500');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('+1,500 Coins added!')),
                  );
                }
              },
            ),
          ],
        );
      },
    ),
  ),
);
  }
}

class _CoinBundleTile extends StatelessWidget {
  final int coins;
  final String price;
  final String? badge;
  final dynamic theme;
  final double textScale;
  final VoidCallback onBuy;

  const _CoinBundleTile({
    required this.coins,
    required this.price,
    this.badge,
    required this.theme,
    required this.textScale,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.divider),
      ),
      child: Row(
        children: [
          Icon(
            Icons.monetization_on_rounded,
            color: theme.accent,
            size: 32,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Row(
              children: [
                Text(
                  '$coins Coins',
                  style: TextStyle(
                    fontSize: 16.0 * textScale,
                    fontWeight: FontWeight.w800,
                    color: theme.textPrimary,
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        fontSize: 10.0 * textScale,
                        fontWeight: FontWeight.w800,
                        color: theme.accent,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: theme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onBuy,
            child: Text(price),
          ),
        ],
      ),
    );
  }
}
