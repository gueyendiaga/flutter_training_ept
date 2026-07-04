import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.subtitle,
    this.activeColor,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? subtitle;
  final Color? activeColor;
  final bool enabled;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final Widget switchWidget = Switch.adaptive(
      value: value,
      onChanged: _isInteractive ? onChanged : null,
      activeColor: activeColor ?? AppColors.primary,
    );

    if (label == null) return switchWidget;

    return InkWell(
      onTap: _isInteractive ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeMd,
                      fontWeight: FontWeight.w500,
                      color: enabled ? AppColors.textPrimary : AppColors.disabled,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(fontSize: AppSizes.fontSizeXs, color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            switchWidget,
          ],
        ),
      ),
    );
  }
}
