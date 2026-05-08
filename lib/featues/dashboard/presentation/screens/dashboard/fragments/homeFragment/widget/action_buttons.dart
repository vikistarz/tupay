import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/theme/app_theme.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          _ActionItem(
            label: "Fund",
            imagePath: "images/funds.png",
            index: 0,
          ),
          SizedBox(width: 12),
          _ActionItem(
            label: "Pay",
            imagePath: "images/pay.png",
            index: 1,
          ),
          SizedBox(width: 12),
          _ActionItem(
            label: "Swap",
            imagePath: "images/swap.png",
            index: 2,
          ),
        ],
      ),
    );
  }
}



final actionPressProvider = StateProvider<int?>((ref) => null);


class _ActionItem extends ConsumerWidget {
  final String label;
  final String imagePath; // 👈 change from IconData
  final int index;

  const _ActionItem({
    required this.label,
    required this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pressedIndex = ref.watch(actionPressProvider);
    final isPressed = pressedIndex == index;

    return Expanded(
      child: Card(
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onTapDown: (_) {
            ref.read(actionPressProvider.notifier).state = index;
          },
          onTapUp: (_) {
            ref.read(actionPressProvider.notifier).state = null;
          },
          onTapCancel: () {
            ref.read(actionPressProvider.notifier).state = null;
          },
          onTap: () {
            // handle action here
          },
          child: AnimatedScale(
            scale: isPressed ? 0.95 : 1,
            duration: const Duration(milliseconds: 100),
            child: Column(
              children: [

                const SizedBox(height: 15),

                  Image.asset(
                    imagePath,
                    height: 48,
                    width: 48,
                    fit: BoxFit.contain,
                  ),

                const SizedBox(height: 10),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}