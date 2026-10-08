import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers.dart';

class CoinChip extends ConsumerWidget {
  final VoidCallback? onTap;

  const CoinChip({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardService = ref.watch(rewardServiceProvider);
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;

    return StreamBuilder<int>(
      stream: rewardService.coinStream,
      initialData: rewardService.currentCoins,
      builder: (context, snapshot) {
        final coins = snapshot.data ?? rewardService.currentCoins;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ?? () => context.push('/shop'),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.surfaceSubtle,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.accent.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.monetization_on_rounded,
                    color: theme.accent,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$coins',
                    style: TextStyle(
                      fontSize: 15.0 * settings.textScale,
                      fontWeight: FontWeight.w700,
                      color: theme.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.add_circle,
                    color: theme.primary,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
