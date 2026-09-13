import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

enum AppRadioSize { sm, md, lg }

class AppRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? helper;
  final bool enabled;
  final AppRadioSize size;
  final bool isError;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.helper,
    this.enabled = true,
    this.size = AppRadioSize.md,
    this.isError = false,
  });

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onChanged(value) : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Circle ─────────────────────────────────────
          SizedBox(
            width: _boxSize,
            height: _boxSize,
            child: Radio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: enabled ? onChanged : null,
              activeColor: AppColor.primaryColor,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppColor.primaryColor.withValues(alpha: 0.3);
                }
                if (states.contains(WidgetState.selected)) {
                  return isError ? AppColor.errorColor : AppColor.primaryColor;
                }
                return isError
                    ? AppColor.errorColor
                    : AppColor.primaryColor.withValues(alpha: 0.3);
              }),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),

          // ─── Label ──────────────────────────────────────
          if (label != null) ...[
            SizedBox(width: AppSize.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: _fontSize,
                      fontWeight: _isSelected
                          ? AppFont.medium
                          : AppFont.regular,
                      color: enabled
                          ? AppColor.primaryColor
                          : AppColor.primaryColor.withValues(alpha: 0.4),
                    ),
                  ),
                  if (helper != null) ...[
                    SizedBox(height: 2),
                    Text(
                      helper!,
                      style: TextStyle(
                        fontSize: AppFont.xs,
                        color: isError
                            ? AppColor.errorColor
                            : AppColor.primaryColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  double get _boxSize => switch (size) {
    AppRadioSize.sm => 16,
    AppRadioSize.md => 20,
    AppRadioSize.lg => 24,
  };

  double get _fontSize => switch (size) {
    AppRadioSize.sm => AppFont.sm,
    AppRadioSize.md => AppFont.base,
    AppRadioSize.lg => AppFont.lg,
  };
}

// ─── Group ────────────────────────────────────────────────────────────────────

class AppRadioGroup<T> extends StatelessWidget {
  final List<T> values;
  final T? groupValue;
  final String Function(T) labelBuilder;
  final String Function(T)? helperBuilder;
  final ValueChanged<T?> onChanged;
  final bool enabled;
  final AppRadioSize size;
  final Axis direction;

  const AppRadioGroup({
    super.key,
    required this.values,
    required this.groupValue,
    required this.labelBuilder,
    required this.onChanged,
    this.helperBuilder,
    this.enabled = true,
    this.size = AppRadioSize.md,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final items = values.map((item) {
      return AppRadio<T>(
        value: item,
        groupValue: groupValue,
        label: labelBuilder(item),
        helper: helperBuilder?.call(item),
        enabled: enabled,
        size: size,
        onChanged: onChanged,
      );
    }).toList();

    if (direction == Axis.horizontal) {
      return Wrap(spacing: AppSize.lg, runSpacing: AppSize.sm, children: items);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: AppSize.sm),
              child: e,
            ),
          )
          .toList(),
    );
  }
}
