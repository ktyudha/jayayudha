import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

// ─── Helper functions (cara pakai) ────────────────────────────────────────────

/// Regular bottom sheet — bisa dismiss dengan swipe/tap outside
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isDismissible = true,
  bool showDragHandle = true,
  bool showCloseButton = false,
  double? initialSize,
  double? minSize,
  double? maxSize,
  bool isScrollable = false,
  EdgeInsetsGeometry? padding,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AppBottomSheetContent(
      title: title,
      showDragHandle: showDragHandle,
      showCloseButton: showCloseButton,
      isScrollable: isScrollable,
      initialSize: initialSize ?? (isScrollable ? 0.5 : null),
      minSize: minSize ?? (isScrollable ? 0.3 : null),
      maxSize: maxSize ?? (isScrollable ? 0.9 : null),
      padding: padding,
      child: child,
    ),
  );
}

/// Modal bottom sheet — tidak bisa dismiss sembarangan, butuh aksi user
Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissible = false,
  String? title,
  String? confirmLabel,
  String? cancelLabel,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool showActions = true,
  double? initialSize,
  EdgeInsetsGeometry? padding,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (builderContext) => AppBottomSheetContent(
      title: title,
      showDragHandle: false,
      showCloseButton: true,
      isScrollable: initialSize != null,
      initialSize: initialSize,
      minSize: initialSize,
      maxSize: initialSize ?? 0.9,
      padding: padding,
      footer: showActions
          ? _ModalActions(
              confirmLabel: confirmLabel ?? 'Konfirmasi',
              cancelLabel: cancelLabel ?? 'Batal',
              onConfirm: onConfirm ?? () => Navigator.pop(builderContext),
              onCancel: onCancel ?? () => Navigator.pop(builderContext),
            )
          : null,
      child: child,
    ),
  );
}

// ─── Core content widget ──────────────────────────────────────────────────────

class AppBottomSheetContent extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showDragHandle;
  final bool showCloseButton;
  final bool isScrollable;
  final double? initialSize;
  final double? minSize;
  final double? maxSize;
  final EdgeInsetsGeometry? padding;
  final Widget? footer;

  const AppBottomSheetContent({
    super.key,
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.showCloseButton = false,
    this.isScrollable = false,
    this.initialSize,
    this.minSize,
    this.maxSize,
    this.padding,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Drag handle ────────────────────────────────
          if (showDragHandle)
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
          if (title != null || showCloseButton)
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSize.lg,
                showDragHandle ? AppSize.sm : AppSize.lg,
                AppSize.md,
                0,
              ),
              child: Row(
                children: [
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: TextStyle(
                          fontSize: AppFont.lg,
                          fontWeight: AppFont.semiBold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  if (showCloseButton)
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

          // ─── Body ───────────────────────────────────────
          Flexible(
            child: Padding(
              padding:
                  padding ??
                  EdgeInsets.fromLTRB(
                    AppSize.lg,
                    AppSize.md,
                    AppSize.lg,
                    footer != null ? AppSize.sm : AppSize.xl,
                  ),
              child: child,
            ),
          ),

          // ─── Footer / Actions ────────────────────────────
          if (footer != null) ...[
            Divider(
              height: 1,
              color: AppColor.primaryColor.withValues(alpha: 0.1),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSize.lg,
                AppSize.md,
                AppSize.lg,
                AppSize.lg,
              ),
              child: footer,
            ),
          ],

          // safe area bottom
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );

    // Scrollable (DraggableScrollableSheet)
    if (isScrollable && initialSize != null) {
      return DraggableScrollableSheet(
        initialChildSize: initialSize!,
        minChildSize: minSize ?? 0.3,
        maxChildSize: maxSize ?? 0.9,
        expand: false,
        builder: (_, scrollController) =>
            SingleChildScrollView(controller: scrollController, child: content),
      );
    }

    return content;
  }
}

// ─── Modal action buttons ─────────────────────────────────────────────────────

class _ModalActions extends StatelessWidget {
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _ModalActions({
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColor.primaryColor,
              side: BorderSide(color: AppColor.primaryColor),
              padding: EdgeInsets.symmetric(vertical: AppSize.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.radiusMd),
              ),
            ),
            child: Text(
              cancelLabel,
              style: TextStyle(
                fontSize: AppFont.base,
                fontWeight: AppFont.medium,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSize.sm),
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirm,
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
              confirmLabel,
              style: TextStyle(
                fontSize: AppFont.base,
                fontWeight: AppFont.semiBold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
