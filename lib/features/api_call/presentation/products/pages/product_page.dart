import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_colors.dart';
import 'package:flutter_training/core/models/product_model.dart';
import 'package:flutter_training/core/repositories/product_repository.dart';
import 'package:flutter_training/features/api_call/presentation/products/widgets/product_item_widget.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../whatsapp/presentation/chat/widgets/product_form_dialog.dart';

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
    try {
      await _productRepository.updateProduct(product);
      _showSnackbar('Produit mis à jour avec succès');
    } catch(error) {
      _showSnackbar('Erreur lors de la modification du produit', isError: true);
    }
  }

  // Delete product
  Future<void> _deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      _showSnackbar('Produit supprimé avec succès');
    } catch(error) {
      _showSnackbar('Erreur lors de la suppression du produit', isError: true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
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
    if(errorMessage != null) {
      return Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: AppSizes.fontSizeLg)));
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
            onDelete: () {
                // TODO: show confirmation dialog before deleting the product
            },
            onEdit: ()=> _openProductForm(product: product),
          );
        },

      ),
    );

  }
}
