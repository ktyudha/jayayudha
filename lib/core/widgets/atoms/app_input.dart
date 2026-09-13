import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jayayudha/core/theme/theme.dart';

enum AppInputSize { xs, sm, md, lg }

enum AppInputVariant { outlined, filled }

class AppInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool required;
  final int? maxLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Widget? suffix;
  final Widget? prefix;

  final AppInputVariant variant;
  final AppInputSize size;

  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.required = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.suffix,
    this.prefix,
    this.variant = AppInputVariant.outlined,
    this.size = AppInputSize.xs,
  });

  // ─── Named constructors ───────────────────────────────────
  const AppInput.password({
    super.key,
    this.label = 'Password',
    this.hint = 'Masukkan password',
    this.helper,
    this.errorText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.required = false,
    this.variant = AppInputVariant.outlined,
    this.size = AppInputSize.xs,
  }) : obscureText = true,
       readOnly = false,
       maxLines = 1,
       maxLength = null,
       keyboardType = TextInputType.visiblePassword,
       textInputAction = TextInputAction.done,
       inputFormatters = null,
       prefixIcon = Icons.lock_outline,
       suffixIcon = null,
       onSuffixTap = null,
       suffix = null,
       prefix = null;

  const AppInput.search({
    super.key,
    this.hint = 'Cari...',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.xs,
  }) : label = null,
       helper = null,
       errorText = null,
       obscureText = false,
       readOnly = false,
       required = false,
       maxLines = 1,
       maxLength = null,
       keyboardType = TextInputType.text,
       textInputAction = TextInputAction.search,
       inputFormatters = null,
       prefixIcon = Icons.search,
       suffixIcon = null,
       onSuffixTap = null,
       suffix = null,
       prefix = null;

  const AppInput.textarea({
    super.key,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.required = false,
    this.maxLines = 5,
    this.maxLength,
    this.variant = AppInputVariant.outlined,
    this.size = AppInputSize.xs,
  }) : obscureText = false,
       readOnly = false,
       keyboardType = TextInputType.multiline,
       textInputAction = TextInputAction.newline,
       inputFormatters = null,
       prefixIcon = null,
       suffixIcon = null,
       onSuffixTap = null,
       onSubmitted = null,
       suffix = null,
       prefix = null;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Label ────────────────────────────────────────
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: AppFont.sm,
                  fontWeight: AppFont.medium,
                  color: widget.enabled
                      ? AppColor.primaryColor
                      : AppColor.primaryColor.withValues(alpha: 0.4),
                ),
              ),
              if (widget.required)
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

        // ─── Field ────────────────────────────────────────
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          obscureText: _obscure,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: _obscure ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          style: TextStyle(
            fontSize: AppFont.base,
            fontWeight: AppFont.regular,
            color: widget.enabled
                ? AppColor.primaryColor
                : AppColor.primaryColor.withValues(alpha: 0.4),
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: AppFont.base,
              color: AppColor.primaryColor.withValues(alpha: 0.3),
            ),
            filled: widget.variant == AppInputVariant.filled,
            fillColor: widget.variant == AppInputVariant.filled
                ? AppColor.surfaceColor
                : null,
            errorText: widget.errorText,
            errorStyle: TextStyle(
              fontSize: AppFont.xs,
              color: AppColor.errorColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSize.md,
              vertical: _verticalPadding,
            ),

            // prefix
            prefixIcon: widget.prefix != null
                ? widget.prefix
                : widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    size: AppSize.iconMd,
                    color: AppColor.primaryColor.withValues(alpha: 0.5),
                  )
                : null,

            // suffix
            suffixIcon: widget.obscureText
                ? GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: AppSize.iconMd,
                      color: AppColor.primaryColor.withValues(alpha: 0.5),
                    ),
                  )
                : widget.suffix != null
                ? widget.suffix
                : widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: Icon(
                      widget.suffixIcon,
                      size: AppSize.iconMd,
                      color: AppColor.primaryColor.withValues(alpha: 0.5),
                    ),
                  )
                : null,

            // border
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(focused: true),
            errorBorder: _border(error: true),
            focusedErrorBorder: _border(error: true, focused: true),
            disabledBorder: _border(disabled: true),
          ),
        ),

        // ─── Helper ───────────────────────────────────────
        if (widget.helper != null && widget.errorText == null) ...[
          SizedBox(height: AppSize.xs),
          Text(
            widget.helper!,
            style: TextStyle(
              fontSize: AppFont.xs,
              color: AppColor.primaryColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      ],
    );
  }

  OutlineInputBorder _border({
    bool focused = false,
    bool error = false,
    bool disabled = false,
  }) {
    Color color;
    double width;

    if (error) {
      color = AppColor.errorColor;
      width = 1.5;
    } else if (focused) {
      color = AppColor.primaryColor;
      width = 1.5;
    } else if (disabled) {
      color = AppColor.primaryColor.withValues(alpha: 0.2);
      width = 1;
    } else {
      color = AppColor.primaryColor.withValues(alpha: 0.3);
      width = 1;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMd),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  double get _verticalPadding => switch (widget.size) {
    AppInputSize.xs => AppSize.xs,
    AppInputSize.sm => AppSize.sm,
    AppInputSize.md => AppSize.md,
    AppInputSize.lg => AppSize.lg,
  };
}
