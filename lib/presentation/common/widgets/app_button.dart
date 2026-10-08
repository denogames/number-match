import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isSecondary;
  final bool isFullWidth;
  final double height;
  final double textScale;

  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.isSecondary = false,
    this.isFullWidth = false,
    this.height = 50.0,
    this.textScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ??
        (isSecondary
            ? theme.colorScheme.surface
            : theme.colorScheme.primary);
    final fg = foregroundColor ??
        (isSecondary
            ? theme.colorScheme.onSurface
            : theme.colorScheme.onPrimary);

    Widget child = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20.0 * textScale, color: fg),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0 * textScale,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
      ],
    );

    return SizedBox(
      height: height,
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: isSecondary ? 0 : 2,
          side: isSecondary
              ? BorderSide(color: theme.dividerColor, width: 1.5)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
