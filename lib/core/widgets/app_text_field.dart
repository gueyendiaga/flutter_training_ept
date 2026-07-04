import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.maxLines = 1,
    this.minLines = 1,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final int minLines;
  final int maxLines;

  OutlineInputBorder _border(Color color, {double width = AppSizes.borderWidthThin}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget field = TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      focusNode: focusNode,
      style: const TextStyle(fontSize: AppSizes.fontSizeMd, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        helperText: helperText,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: AppSizes.iconSm) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: enabled ? AppColors.surface : AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
        border: _border(AppColors.border),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.primary, width: AppSizes.borderWidthMedium),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, width: AppSizes.borderWidthMedium),
        disabledBorder: _border(AppColors.disabled),
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
          style: TextStyle(
            fontSize: AppSizes.fontSizeSm,
            fontWeight: FontWeight.w600,
            color: enabled ? AppColors.textPrimary : AppColors.disabled,
          ),
        ),
        const SizedBox(height: AppSizes.xs),
        field,
      ],
    );
  }
}
