import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

enum AppDatePickerMode { date, time, dateAndTime }

// ─── Helper function ──────────────────────────────────────────────────────────

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
  AppDatePickerMode mode = AppDatePickerMode.date,
  String? title,
  String confirmLabel = 'Pilih',
  String cancelLabel = 'Batal',
}) async {
  DateTime selected = initialDate ?? DateTime.now();

  return showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _AppDatePickerSheet(
      initialDate: selected,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      mode: mode,
      title: title,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
    ),
  );
}

// ─── Sheet widget ─────────────────────────────────────────────────────────────

class _AppDatePickerSheet extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final AppDatePickerMode mode;
  final String? title;
  final String confirmLabel;
  final String cancelLabel;

  const _AppDatePickerSheet({
    required this.initialDate,
    required this.mode,
    required this.confirmLabel,
    required this.cancelLabel,
    this.minimumDate,
    this.maximumDate,
    this.title,
  });

  @override
  State<_AppDatePickerSheet> createState() => _AppDatePickerSheetState();
}

class _AppDatePickerSheetState extends State<_AppDatePickerSheet> {
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
  }

  CupertinoDatePickerMode get _cupertinoMode => switch (widget.mode) {
    AppDatePickerMode.date => CupertinoDatePickerMode.date,
    AppDatePickerMode.time => CupertinoDatePickerMode.time,
    AppDatePickerMode.dateAndTime => CupertinoDatePickerMode.dateAndTime,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Drag handle ────────────────────────────────
          Center(
            child: Container(
              margin: EdgeInsets.only(top: AppSize.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSize.radiusFull),
              ),
            ),
          ),

          // ─── Header ─────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(AppSize.lg, AppSize.sm, AppSize.md, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title ?? _defaultTitle,
                    style: TextStyle(
                      fontSize: AppFont.lg,
                      fontWeight: AppFont.semiBold,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: AppSize.iconMd,
                    color: AppColor.primaryColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),

          // ─── Cupertino Picker ────────────────────────────
          SizedBox(
            height: 220,
            child: CupertinoDatePicker(
              mode: _cupertinoMode,
              initialDateTime: _selected,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              use24hFormat: true,
              onDateTimeChanged: (date) => setState(() => _selected = date),
            ),
          ),

          // ─── Confirm button ──────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSize.lg,
              AppSize.sm,
              AppSize.lg,
              AppSize.lg,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selected),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSize.md),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.radiusMd),
                  ),
                ),
                child: Text(
                  widget.confirmLabel,
                  style: TextStyle(
                    fontSize: AppFont.base,
                    fontWeight: AppFont.semiBold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  String get _defaultTitle => switch (widget.mode) {
    AppDatePickerMode.date => 'Pilih Tanggal',
    AppDatePickerMode.time => 'Pilih Waktu',
    AppDatePickerMode.dateAndTime => 'Pilih Tanggal & Waktu',
  };
}

// ─── AppDatePickerField — input yang tap untuk buka picker ───────────────────
