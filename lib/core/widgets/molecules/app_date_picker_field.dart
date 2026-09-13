import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';
import 'package:jayayudha/core/widgets/atoms/atoms.dart';

class AppDatePickerField extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final bool required;
  final bool enabled;
  final AppDatePickerMode mode;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final String? Function(DateTime)? formatter;

  const AppDatePickerField({
    super.key,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.required = false,
    this.enabled = true,
    this.mode = AppDatePickerMode.date,
    this.minimumDate,
    this.maximumDate,
    this.formatter,
  });

  String get _displayValue {
    if (value == null) return '';
    if (formatter != null) return formatter!(value!) ?? '';
    return switch (mode) {
      AppDatePickerMode.date => _formatDate(value!),
      AppDatePickerMode.time => _formatTime(value!),
      AppDatePickerMode.dateAndTime =>
        '${_formatDate(value!)} ${_formatTime(value!)}',
    };
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Label ──────────────────────────────────────
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: TextStyle(
                  fontSize: AppFont.sm,
                  fontWeight: AppFont.medium,
                  color: enabled
                      ? AppColor.primaryColor
                      : AppColor.primaryColor.withValues(alpha: 0.4),
                ),
              ),
              if (required)
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: AppFont.sm,
                    color: AppColor.errorColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: AppSize.xs),
        ],

        // ─── Field ──────────────────────────────────────
        GestureDetector(
          onTap: enabled
              ? () async {
                  final result = await showAppDatePicker(
                    context: context,
                    initialDate: value,
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    mode: mode,
                  );
                  if (result != null) onChanged(result);
                }
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.md,
              vertical: AppSize.md,
            ),
            decoration: BoxDecoration(
              color: enabled ? Colors.transparent : AppColor.surfaceColor,
              borderRadius: BorderRadius.circular(AppSize.radiusMd),
              border: Border.all(
                color: errorText != null
                    ? AppColor.errorColor
                    : AppColor.primaryColor.withValues(alpha: 0.3),
                width: errorText != null ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  mode == AppDatePickerMode.time
                      ? Icons.access_time
                      : Icons.calendar_today_outlined,
                  size: AppSize.iconMd,
                  color: AppColor.primaryColor.withValues(alpha: 0.5),
                ),
                SizedBox(width: AppSize.sm),
                Expanded(
                  child: Text(
                    value != null ? _displayValue : (hint ?? _defaultHint),
                    style: TextStyle(
                      fontSize: AppFont.base,
                      color: value != null
                          ? AppColor.primaryColor
                          : AppColor.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                if (value != null && enabled)
                  GestureDetector(
                    onTap: () => onChanged(null),
                    child: Icon(
                      Icons.close,
                      size: AppSize.iconSm,
                      color: AppColor.primaryColor.withValues(alpha: 0.4),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // ─── Helper / Error ──────────────────────────────
        if (errorText != null) ...[
          SizedBox(height: AppSize.xs),
          Text(
            errorText!,
            style: TextStyle(fontSize: AppFont.xs, color: AppColor.errorColor),
          ),
        ] else if (helper != null) ...[
          SizedBox(height: AppSize.xs),
          Text(
            helper!,
            style: TextStyle(
              fontSize: AppFont.xs,
              color: AppColor.primaryColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      ],
    );
  }

  String get _defaultHint => switch (mode) {
    AppDatePickerMode.date => 'Pilih tanggal',
    AppDatePickerMode.time => 'Pilih waktu',
    AppDatePickerMode.dateAndTime => 'Pilih tanggal & waktu',
  };
}
