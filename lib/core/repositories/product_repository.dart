import 'package:flutter/cupertino.dart';
import 'package:flutter_training/core/constants/endpoints.dart';
import 'package:flutter_training/core/models/product_model.dart';

import '../constants/constants.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService _apiService = ApiService(baseUrl: Constants.baseUrl);

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiService.get(Endpoints.products);
    return (response as List).map((json)=> ProductModel.fromJson(json)).toList();
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await _apiService.post(
      Endpoints.products,
      data: product.toJson()
    );
    return ProductModel.fromJson(response);
  }

  Future<void> updateProduct(ProductModel product) async {
     await _apiService.put(
        '${Endpoints.products}/${product.id}',
        data: product.toJson()
    );
  }

  Future<void> deleteProduct(String productId) async {
    await _apiService.delete('${Endpoints.products}/$productId');
  }
}
