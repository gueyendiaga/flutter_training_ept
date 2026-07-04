import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

/// Variante visuelle du bouton.
enum ButtonVariant { primary, secondary, outlinePrimary, outlineSecondary }

/// Taille du bouton.
enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  bool get _isDisabled => onPressed == null || isLoading;

  @override
  Widget build(BuildContext context) {
    final _ButtonStyleData style = _ButtonStyleData.fromVariant(variant, isDisabled: _isDisabled);
    final _ButtonSizeData sizing = _ButtonSizeData.fromSize(size);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: sizing.height,
      child: ElevatedButton(
        onPressed: _isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: style.backgroundColor,
          foregroundColor: style.foregroundColor,
          disabledBackgroundColor: style.backgroundColor,
          disabledForegroundColor: style.foregroundColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: sizing.horizontalPadding),
          side: style.borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          ),
        ),
        child: isLoading ? _buildLoader(style, sizing) : _buildContent(sizing),
      ),
    );
  }

  Widget _buildLoader(_ButtonStyleData style, _ButtonSizeData sizing) {
    return SizedBox(
      width: sizing.iconSize,
      height: sizing.iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(style.foregroundColor),
      ),
    );
  }

  Widget _buildContent(_ButtonSizeData sizing) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: sizing.iconSize),
          const SizedBox(width: AppSizes.xs),
        ],
        Text(
          label,
          style: TextStyle(fontSize: sizing.fontSize, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

/// Regroupe les couleurs à appliquer selon la variante et l'état (activé/désactivé).
class _ButtonStyleData {
  const _ButtonStyleData({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderSide = BorderSide.none,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide borderSide;

  factory _ButtonStyleData.fromVariant(ButtonVariant variant, {required bool isDisabled}) {
    if (isDisabled) {
      final bool isOutline = variant == ButtonVariant.outlinePrimary || variant == ButtonVariant.outlineSecondary;
      return isOutline
          ? const _ButtonStyleData(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.disabled,
        borderSide: BorderSide(color: AppColors.disabled, width: AppSizes.borderWidthThin),
      )
          : const _ButtonStyleData(
        backgroundColor: AppColors.disabled,
        foregroundColor: AppColors.white,
      );
    }

    switch (variant) {
      case ButtonVariant.primary:
        return const _ButtonStyleData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        );
      case ButtonVariant.secondary:
        return const _ButtonStyleData(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.white,
        );
      case ButtonVariant.outlinePrimary:
        return const _ButtonStyleData(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          borderSide: BorderSide(color: AppColors.primary, width: AppSizes.borderWidthMedium),
        );
      case ButtonVariant.outlineSecondary:
        return const _ButtonStyleData(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primaryDark,
          borderSide: BorderSide(color: AppColors.primaryDark, width: AppSizes.borderWidthMedium),
        );
    }
  }
}

/// Regroupe les dimensions à appliquer selon la taille du bouton.
class _ButtonSizeData {
  const _ButtonSizeData({
    required this.height,
    required this.horizontalPadding,
    required this.fontSize,
    required this.iconSize,
  });

  final double height;
  final double horizontalPadding;
  final double fontSize;
  final double iconSize;

  factory _ButtonSizeData.fromSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return const _ButtonSizeData(
          height: AppSizes.buttonHeightSm,
          horizontalPadding: AppSizes.md,
          fontSize: AppSizes.fontSizeSm,
          iconSize: AppSizes.iconXs,
        );
      case ButtonSize.medium:
        return const _ButtonSizeData(
          height: AppSizes.buttonHeightMd,
          horizontalPadding: AppSizes.lg,
          fontSize: AppSizes.fontSizeMd,
          iconSize: AppSizes.iconSm,
        );
      case ButtonSize.large:
        return const _ButtonSizeData(
          height: AppSizes.buttonHeightLg,
          horizontalPadding: AppSizes.xl,
          fontSize: AppSizes.fontSizeLg,
          iconSize: AppSizes.iconMd,
        );
    }
  }
}
