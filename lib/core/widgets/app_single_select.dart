import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

/// le libellé affiché pour un élément de type [T].
typedef AppSelectLabelBuilder<T> = String Function(T item);

class AppSingleSelect<T> extends StatelessWidget {
  const AppSingleSelect({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.selectedItem,
    this.label,
    this.hint = 'Sélectionner',
    this.enabled = true,
    this.errorText,
  });

  final List<T> items;
  final AppSelectLabelBuilder<T> labelBuilder;
  final ValueChanged<T> onChanged;
  final T? selectedItem;
  final String? label;
  final String hint;
  final bool enabled;
  final String? errorText;

  Future<void> _open(BuildContext context) async {
    final T? result = await _SelectSheet.show<T>(
      context: context,
      title: label ?? hint,
      items: items,
      labelBuilder: labelBuilder,
      initialSelection: selectedItem == null ? <T>[] : <T>[selectedItem as T],
      multiple: false,
    ) as T?;

    if (result != null) onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return _SelectField(
      label: label,
      hint: hint,
      enabled: enabled,
      errorText: errorText,
      valueText: selectedItem != null ? labelBuilder(selectedItem as T) : null,
      onTap: enabled ? () => _open(context) : null,
    );
  }
}

class AppMultiSelect<T> extends StatelessWidget {
  const AppMultiSelect({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.selectedItems = const [],
    this.label,
    this.hint = 'Sélectionner',
    this.enabled = true,
    this.errorText,
  });

  final List<T> items;
  final AppSelectLabelBuilder<T> labelBuilder;
  final ValueChanged<List<T>> onChanged;
  final List<T> selectedItems;
  final String? label;
  final String hint;
  final bool enabled;
  final String? errorText;

  Future<void> _open(BuildContext context) async {
    final List<T>? result = await _SelectSheet.show<T>(
      context: context,
      title: label ?? hint,
      items: items,
      labelBuilder: labelBuilder,
      initialSelection: selectedItems,
      multiple: true,
    ) as List<T>?;

    if (result != null) onChanged(result);
  }

  String? get _valueText {
    if (selectedItems.isEmpty) return null;
    if (selectedItems.length == 1) return labelBuilder(selectedItems.first);
    return '${selectedItems.length} éléments sélectionnés';
  }

  @override
  Widget build(BuildContext context) {
    return _SelectField(
      label: label,
      hint: hint,
      enabled: enabled,
      errorText: errorText,
      valueText: _valueText,
      onTap: enabled ? () => _open(context) : null,
    );
  }
}

class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.hint,
    required this.enabled,
    required this.onTap,
    this.valueText,
    this.label,
    this.errorText,
  });

  final String? valueText;
  final String? label;
  final String hint;
  final bool enabled;
  final String? errorText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = errorText != null
        ? AppColors.error
        : enabled
        ? AppColors.border
        : AppColors.disabled;

    final Widget field = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          fillColor: enabled ? AppColors.surface : AppColors.background,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            borderSide: BorderSide(color: borderColor),
          ),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, size: AppSizes.iconMd),
        ),
        child: Text(
          valueText ?? hint,
          style: TextStyle(
            fontSize: AppSizes.fontSizeMd,
            color: valueText != null ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
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

class _SelectSheet<T> extends StatefulWidget {
  const _SelectSheet({
    required this.title,
    required this.items,
    required this.labelBuilder,
    required this.initialSelection,
    required this.multiple,
  });

  final String title;
  final List<T> items;
  final AppSelectLabelBuilder<T> labelBuilder;
  final List<T> initialSelection;
  final bool multiple;

  /// Ouvre la sheet et retourne :
  /// - un [T] si [multiple] est `false`,
  /// - une `List<T>` si [multiple] est `true`.
  static Future<dynamic> show<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required AppSelectLabelBuilder<T> labelBuilder,
    required List<T> initialSelection,
    required bool multiple,
  }) {
    return showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusMd)),
      ),
      builder: (_) => _SelectSheet<T>(
        title: title,
        items: items,
        labelBuilder: labelBuilder,
        initialSelection: initialSelection,
        multiple: multiple,
      ),
    );
  }

  @override
  State<_SelectSheet<T>> createState() => _SelectSheetState<T>();
}

class _SelectSheetState<T> extends State<_SelectSheet<T>> {
  late final Set<T> _selection = Set<T>.from(widget.initialSelection);

  void _handleTap(T item) {
    if (!widget.multiple) {
      Navigator.of(context).pop(item);
      return;
    }
    setState(() {
      _selection.contains(item) ? _selection.remove(item) : _selection.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: AppSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: AppSizes.fontSizeLg, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSizes.sm),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, index) {
                  final T item = widget.items[index];
                  final bool isSelected = _selection.contains(item);
                  return ListTile(
                    title: Text(widget.labelBuilder(item)),
                    trailing: widget.multiple
                        ? Checkbox(
                      value: isSelected,
                      activeColor: AppColors.primary,
                      onChanged: (_) => _handleTap(item),
                    )
                        : (isSelected ? const Icon(Icons.check, color: AppColors.primary) : null),
                    onTap: () => _handleTap(item),
                  );
                },
              ),
            ),
            if (widget.multiple)
              Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(_selection.toList()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                    ),
                    child: const Text('Valider'),
                  ),
                ),
              )
            else
              const SizedBox(height: AppSizes.md),
          ],
        ),
      ),
    );
  }
}
