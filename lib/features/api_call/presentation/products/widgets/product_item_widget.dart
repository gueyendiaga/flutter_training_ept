import 'package:flutter/material.dart';
import 'package:flutter_training/core/models/product_model.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function()? onTap;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSizes.sm, AppSizes.sm, AppSizes.sm, AppSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: AppSizes.fontSizeMd,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: AppSizes.fontSizeXs,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSizes.sm, 0, AppSizes.xs, AppSizes.xs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: AppSizes.fontSizeMd,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  _buildActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: Image.network(
        product.image,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: AppColors.background,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.background,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image_outlined, color: AppColors.disabled, size: AppSizes.iconMd),
          );
        },
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(AppSizes.radiusCircle),
          child: const Padding(
            padding: EdgeInsets.all(AppSizes.xs),
            child: Icon(Icons.edit_outlined, size: AppSizes.iconSm, color: AppColors.primary),
          ),
        ),
        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(AppSizes.radiusCircle),
          child: const Padding(
            padding: EdgeInsets.all(AppSizes.xs),
            child: Icon(Icons.delete_outline, size: AppSizes.iconSm, color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
