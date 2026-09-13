import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

enum AppButtonVariant { primary, secondary, outline, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.fullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          backgroundColor: _bgColor,
          foregroundColor: _fgColor,
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.lg,
            vertical: AppSize.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
            side: variant == AppButtonVariant.outline
                ? BorderSide(color: AppColor.primaryColor)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: AppSize.iconSm,
                height: AppSize.iconSm,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _fgColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppSize.iconSm),
                    SizedBox(width: AppSize.sm),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: AppFont.base,
                      fontWeight: AppFont.semiBold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color get _bgColor => switch (variant) {
    AppButtonVariant.primary => AppColor.primaryColor,
    AppButtonVariant.secondary => AppColor.secondaryColor,
    AppButtonVariant.outline => Colors.transparent,
    AppButtonVariant.ghost => Colors.transparent,
  };

  Color get _fgColor => switch (variant) {
    AppButtonVariant.primary => Colors.white,
    AppButtonVariant.secondary => Colors.white,
    AppButtonVariant.outline => AppColor.primaryColor,
    AppButtonVariant.ghost => AppColor.primaryColor,
  };
}
