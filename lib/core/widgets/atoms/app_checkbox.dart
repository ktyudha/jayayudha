import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

enum AppCheckboxSize { sm, md, lg }

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final String? helper;
  final bool enabled;
  final AppCheckboxSize size;
  final bool isError;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.helper,
    this.enabled = true,
    this.size = AppCheckboxSize.md,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onChanged(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Box ────────────────────────────────────────
          SizedBox(
            width: _boxSize,
            height: _boxSize,
            child: Checkbox(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: AppColor.primaryColor,
              checkColor: Colors.white,
              side: BorderSide(
                color: isError
                    ? AppColor.errorColor
                    : value
                    ? AppColor.primaryColor
                    : AppColor.primaryColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.radiusSm),
              ),
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
                      fontWeight: AppFont.regular,
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
    AppCheckboxSize.sm => 16,
    AppCheckboxSize.md => 20,
    AppCheckboxSize.lg => 24,
  };

  double get _fontSize => switch (size) {
    AppCheckboxSize.sm => AppFont.sm,
    AppCheckboxSize.md => AppFont.base,
    AppCheckboxSize.lg => AppFont.lg,
  };
}

// ─── Group ────────────────────────────────────────────────────────────────────

class AppCheckboxGroup<T> extends StatelessWidget {
  final List<T> values;
  final List<T> selected;
  final String Function(T) labelBuilder;
  final ValueChanged<List<T>> onChanged;
  final bool enabled;
  final AppCheckboxSize size;
  final Axis direction;

  const AppCheckboxGroup({
    super.key,
    required this.values,
    required this.selected,
    required this.labelBuilder,
    required this.onChanged,
    this.enabled = true,
    this.size = AppCheckboxSize.md,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final items = values.map((item) {
      return AppCheckbox(
        value: selected.contains(item),
        label: labelBuilder(item),
        enabled: enabled,
        size: size,
        onChanged: (_) {
          final next = List<T>.from(selected);
          selected.contains(item) ? next.remove(item) : next.add(item);
          onChanged(next);
        },
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
