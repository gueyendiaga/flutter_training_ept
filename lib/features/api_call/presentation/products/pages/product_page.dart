import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_colors.dart';
import 'package:flutter_training/core/models/product_model.dart';
import 'package:flutter_training/core/repositories/product_repository.dart';
import 'package:flutter_training/features/api_call/presentation/products/widgets/product_item_widget.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../widgets/product_form_dialog.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductRepository _productRepository;

  List<ProductModel> products = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final data = await _productRepository.getProducts();
      debugPrint('Loaded products: $data');
      setState(()=> products = data);
    } catch(error) {
      debugPrint('Failed to load products: $error');
      setState(() {
        errorMessage = 'Failed to load products';
      });
    } finally {
      setState(()=> isLoading = false);
    }
  }

  // Create product
  Future<void> _createProduct(ProductModel product) async {
    try {
      final createdProduct = await _productRepository.createProduct(product);
      setState(()=> products.add(createdProduct));
      debugPrint('created product: ${createdProduct.toJson()}');
      _showSnackbar('Produit ajouté avec succès');
    } catch(error) {
      _showSnackbar('Erreur lors de l\'ajout du produit', isError: true);
    }
  }

  // Update product
  Future<void> _updateProduct(ProductModel product) async {
    debugPrint('updateProduct called');
    try {
      await _productRepository.updateProduct(product);
      //_loadProducts();
      setState(() {
        final index = products.indexWhere((item)=> item.id == product.id);
        products[index] = product;
      });
      _showSnackbar('Produit mis à jour avec succès');
    } catch(error) {
      debugPrint('Erreur lors de la modification du produit');
      debugPrint('⚠ ERROR: $error');
      debugPrint('⚠ PAYLOAD: ${product.toJson()}');
      debugPrint('⚠ PRODUCT ID: ${product.id}');
      _showSnackbar('Erreur lors de la modification du produit', isError: true);
    }
  }

  // Delete product
  Future<void> _deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      _loadProducts();
      _showSnackbar('Produit supprimé avec succès');
    } catch (e) {
      debugPrint('Erreur lors de la suppression du produit : $e');
      _showSnackbar('Erreur lors de la suppression du produit : $e', isError: true);
    }
  }


  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green
      ),
    );
  }

  void _openProductForm({ProductModel? product}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_)=> ProductFormDialog(
            product: product,
            onSubmit: (p)=> product == null ? _createProduct(p) : _updateProduct(p),
        )
    );
  }

  void _showConfirmationDialog(ProductModel product) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer le produit'),
          content: Text(
            'Voulez-vous vraiment supprimer le produit ${product.title}',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Supprimer'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(product.id!);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            onPressed: _loadProducts,
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualiser',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _openProductForm,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    /// Il faut afficher le loader si isLoading est true
    if(isLoading) {
      return Center(
          child: CircularProgressIndicator()
      );
    }
    /// Ill faut afficher le message d'erreur si errorMessage n'est pas null
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: AppSizes.sm),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: AppSizes.md),
            FilledButton.icon(
              onPressed: _loadProducts,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }


    /// Il faut afficher le message "No products found" si products est vide
    if(products.isEmpty) {
      return Center(child: Text('No products found', style: TextStyle(fontSize: AppSizes.fontSizeLg)));
    }

    /// Il faut afficher la liste des produits si products n'est pas vide
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColors.primary,
      strokeWidth: 4.0,
      onRefresh: _loadProducts,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.m20),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products.elementAt(index);
          return ProductItemWidget(
              product: product,
            onDelete: ()=> _showConfirmationDialog(product),
            onEdit: ()=> _openProductForm(product: product),
          );
        },

      ),
    );

  }
}
