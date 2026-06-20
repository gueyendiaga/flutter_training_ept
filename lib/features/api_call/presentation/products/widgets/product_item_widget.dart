import 'package:flutter/material.dart';
import 'package:flutter_training/core/models/product_model.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  final void Function() onEdit;
  final void Function() onDelete;

  const ProductItemWidget({super.key, required this.product, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: AppSizes.cardImageHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusSm)),
              image: DecorationImage(
                image: NetworkImage(product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                Text('\$${product.price}', style: TextStyle(fontSize: 14, color: Colors.green)),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit_outlined, color: AppColors.primary),
                tooltip: 'Modifier',
              ),
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'Supprimer',
              ),
            ],
          )
        ],
      ),
    );
  }
}
