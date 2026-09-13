import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

enum AppBadgeVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  ghost,
}

enum AppBadgeSize { sm, md, lg }

class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeVariant variant;
  final AppBadgeSize size;
  final IconData? icon;
  final bool dot;

  const AppBadge(
    this.label, {
    super.key,
    this.variant = AppBadgeVariant.primary,
    this.size = AppBadgeSize.md,
    this.icon,
    this.dot = false,
  });

  // ─── Named constructors ───────────────────────────────────
  const AppBadge.success(
    this.label, {
    super.key,
    this.size = AppBadgeSize.md,
    this.icon,
    this.dot = false,
  }) : variant = AppBadgeVariant.success;

  const AppBadge.warning(
    this.label, {
    super.key,
    this.size = AppBadgeSize.md,
    this.icon,
    this.dot = false,
  }) : variant = AppBadgeVariant.warning;

  const AppBadge.error(
    this.label, {
    super.key,
    this.size = AppBadgeSize.md,
    this.icon,
    this.dot = false,
  }) : variant = AppBadgeVariant.error;

  const AppBadge.info(
    this.label, {
    super.key,
    this.size = AppBadgeSize.md,
    this.icon,
    this.dot = false,
  }) : variant = AppBadgeVariant.info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _hPadding, vertical: _vPadding),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(AppSize.radiusFull),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _fgColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: AppSize.xs),
          ],
          if (icon != null && !dot) ...[
            Icon(icon, size: _iconSize, color: _fgColor),
            SizedBox(width: AppSize.xs),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: _fontSize,
              fontWeight: AppFont.medium,
              color: _fgColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Size tokens ──────────────────────────────────────────
  double get _hPadding => switch (size) {
    AppBadgeSize.sm => AppSize.sm,
    AppBadgeSize.md => AppSize.md,
    AppBadgeSize.lg => AppSize.lg,
  };

  double get _vPadding => switch (size) {
    AppBadgeSize.sm => 2,
    AppBadgeSize.md => AppSize.xs,
    AppBadgeSize.lg => AppSize.sm,
  };

  double get _fontSize => switch (size) {
    AppBadgeSize.sm => AppFont.xs,
    AppBadgeSize.md => AppFont.sm,
    AppBadgeSize.lg => AppFont.md,
  };

  double get _iconSize => switch (size) {
    AppBadgeSize.sm => AppSize.iconSm - 4,
    AppBadgeSize.md => AppSize.iconSm,
    AppBadgeSize.lg => AppSize.iconMd,
  };

  // ─── Color tokens ─────────────────────────────────────────
  Color get _bgColor => switch (variant) {
    AppBadgeVariant.primary => AppColor.primaryColor.withValues(alpha: 0.1),
    AppBadgeVariant.secondary => AppColor.secondaryColor.withValues(alpha: 0.1),
    AppBadgeVariant.success => AppColor.successColor.withValues(alpha: 0.1),
    AppBadgeVariant.warning => AppColor.warningColor.withValues(alpha: 0.1),
    AppBadgeVariant.error => AppColor.errorColor.withValues(alpha: 0.1),
    AppBadgeVariant.info => AppColor.blueLight100,
    AppBadgeVariant.ghost => Colors.transparent,
  };

  Color get _fgColor => switch (variant) {
    AppBadgeVariant.primary => AppColor.primaryColor,
    AppBadgeVariant.secondary => AppColor.secondaryColor,
    AppBadgeVariant.success => AppColor.successColor,
    AppBadgeVariant.warning => AppColor.warningColor,
    AppBadgeVariant.error => AppColor.errorColor,
    AppBadgeVariant.info => AppColor.blueLight700,
    AppBadgeVariant.ghost => AppColor.primaryColor,
  };

  Color get _borderColor => switch (variant) {
    AppBadgeVariant.primary => AppColor.primaryColor.withValues(alpha: 0.3),
    AppBadgeVariant.secondary => AppColor.secondaryColor.withValues(alpha: 0.3),
    AppBadgeVariant.success => AppColor.successColor.withValues(alpha: 0.3),
    AppBadgeVariant.warning => AppColor.warningColor.withValues(alpha: 0.3),
    AppBadgeVariant.error => AppColor.errorColor.withValues(alpha: 0.3),
    AppBadgeVariant.info => AppColor.blueLight200,
    AppBadgeVariant.ghost => Colors.transparent,
  };
}
