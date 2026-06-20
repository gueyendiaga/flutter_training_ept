import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_colors.dart';
import 'package:flutter_training/core/constants/app_sizes.dart';
import 'package:flutter_training/core/models/product_model.dart';

class ProductFormDialog extends StatefulWidget {
  final ProductModel? product;
  final void Function(ProductModel) onSubmit;

  const ProductFormDialog({super.key, this.product, required this.onSubmit});

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool get _isEditing => widget.product != null;

  Future<void>_onSubmit() async {
    if(!_formKey.currentState!.validate()) return; // Form is not valid
    final product = ProductModel(
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
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text('Titre du produit'),
                  hint: Text('Entrez le titre du produit'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Le titre du produit est requis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  label: Text('Catégorie du produit'),
                  hint: Text('Entrez la Catégorie du produit'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'La catégorie du produit est requise';
                  } else if(value.length < 3) {
                    return 'La catégorie du produit doit contenir au moins 3 caractères';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _priceController,
                decoration: InputDecoration(
                  label: Text('Prix du produit'),
                  hint: Text('Entrez le prix du produit'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Le prix du produit est requis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _photoController,
                decoration: InputDecoration(
                  label: Text('Image du produit'),
                  hint: Text('Entrez l\'image du produit'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'L\'image du produit est requise';
                  }
                  return null;
                },
              ),
              TextFormField(
                minLines: 3,
                maxLines: 6,
                controller: _descriptionController,
                decoration: InputDecoration(
                  label: Text('Description du produit'),
                  hint: Text('Entrez la description du produit'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'La description du produit est requise';
                  }
                  return null;
                },
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
