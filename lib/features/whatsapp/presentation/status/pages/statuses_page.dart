import 'package:flutter/material.dart';
import 'package:flutter_training/features/api_call/presentation/products/pages/product_page.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/ui_kit_samples.dart';

class StatusesPage extends StatefulWidget {
  const StatusesPage({super.key});

  @override
  State<StatusesPage> createState() => _StatusesPageState();
}

class _StatusesPageState extends State<StatusesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        children: [
          Text('Statuses Page'),
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const ProductPage(),
                ),
              );
            },
            child: Text('Voir les products'),
          ),
          UiKitSamplesPage(),

          MultiDropdown<String>(
            items: [
              DropdownItem(label: 'Australia', value: 'AU'),
              DropdownItem(label: 'Canada', value: 'CA'),
              DropdownItem(label: 'India', value: 'IN'),
              DropdownItem(label: 'United States', value: 'US'),
            ],
            onSelectionChange: (selectedItems) {
              debugPrint('Selected: $selectedItems');
            },
          )
        ],
      ),
    );
  }
}
