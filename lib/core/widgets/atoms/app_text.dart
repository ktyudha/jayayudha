import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  // ─── Named constructors ───────────────────────────────────
  AppText.sm(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : fontSize = AppFont.sm,
       fontWeight = AppFont.regular;

  AppText.md(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : fontSize = AppFont.md,
       fontWeight = AppFont.regular;

  AppText.lg(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : fontSize = AppFont.lg,
       fontWeight = AppFont.semiBold;

  AppText.heading(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : fontSize = AppFont.xl2,
       fontWeight = AppFont.bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? AppFont.base,
        fontWeight: fontWeight ?? AppFont.regular,
        color: color ?? AppColor.primaryColor,
      ),
    );
  }
}
