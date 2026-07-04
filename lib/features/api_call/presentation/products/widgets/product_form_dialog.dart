import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_colors.dart';
import 'package:flutter_training/core/constants/app_sizes.dart';
import 'package:flutter_training/core/models/product_model.dart';

import '../../../../../core/widgets/app_text_field.dart';

class ProductFormDialog extends StatefulWidget {
  final ProductModel? product;
  final void Function(ProductModel) onSubmit;

  const ProductFormDialog({super.key, this.product, required this.onSubmit});

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _photoController;
  late TextEditingController _descriptionController;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    initializeFormValues(widget.product);
  }

  void initializeFormValues(ProductModel? product) {
    _titleController = TextEditingController(text: product?.title ?? '');
    _categoryController = TextEditingController(text: product?.category ?? '');
    _priceController = TextEditingController(text: product?.price.toString() ?? '');
    _photoController = TextEditingController(text: product?.image ?? '');
    _descriptionController = TextEditingController(text: product?.description ?? '');
  }

  Future<void>_onSubmit() async {
    if(!_formKey.currentState!.validate()) return; // Form is not valid
    final product = ProductModel(
        id: widget.product?.id ?? '',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _categoryController.text.trim(),
        image: _photoController.text.trim(),
        price: int.tryParse(_priceController.text.trim()) ?? 0
    );
    Navigator.pop(context);
    widget.onSubmit(product);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.lg),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: AppSizes.md,
            children: [
              Text(_isEditing ? 'Modifier le produit' : 'Nouveau produit'),
              AppTextField(
                controller: _titleController,
                label: 'Titre du produit',
                hint: 'Entrez le titre du produit',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Le titre du produit est requis';
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _categoryController,
                label: 'Catégorie du produit',
                hint: 'Entrez la Catégorie du produit',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'La catégorie du produit est requise';
                  } else if(value.length < 3) {
                    return 'La catégorie du produit doit contenir au moins 3 caractères';
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _priceController,
                label: 'Prix du produit',
                hint: 'Entrez le prix du produit',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Le prix du produit est requis';
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _photoController,
                label: 'Image du produit',
                hint: 'Entrez l\'image du produit',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'L\'image du produit est requise';
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _descriptionController,
                label: 'Description du produit',
                hint: 'Entrez la description du produit',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'L\'image du produit est requise';
                  }
                  return null;
                },
                minLines: 3,
                maxLines: 6,
              ),

              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler')
                      ),
                  ),
                  SizedBox(width: AppSizes.lg),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                        onPressed: _onSubmit,
                        child: Text(_isEditing ? 'Enregistrer' : 'Créer')
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
