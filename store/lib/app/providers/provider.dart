import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store/app/models/model_product.dart';

class ProductProvider extends ChangeNotifier {
  // Properties
  bool isLoading = false;
  List<Product> product = [];
  List<Product> cartProducts = [];
  List<Product> filteredProducts = [];

  // API endpoints
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1';
  static const String _productsEndpoint = '$_baseUrl/products';
  static const String _cartEndpoint = '$_baseUrl/products/cart';

  // Image validation methods
  Future<bool> isValidImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      final contentType = response.headers['content-type'];

      return response.statusCode == 200 &&
          contentType != null &&
          contentType.toLowerCase().startsWith('image/');
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasValidImages(Product product) async {
    if (product.images.isEmpty) return false;

    for (String imageUrl in product.images) {
      if (!(await isValidImageUrl(imageUrl))) {
        return false;
      }
    }
    return true;
  }

  // Product fetching and filtering methods
  Future<void> fetchProduct() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_productsEndpoint));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final allProducts =
            (data as List).map((item) => Product.fromJson(item)).toList();

        product = [];
        for (var prod in allProducts) {
          if (await hasValidImages(prod)) {
            product.add(prod);
          }
        }

        filteredProducts = product;
      } else {
        _handleError('Error ${response.statusCode}');
      }
    } catch (e) {
      _handleError('Error in request: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = product;
    } else {
      filteredProducts = product
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Cart management methods
  Future<void> toggleCartStatus(Product product) async {
    final isProductInCart = cartProducts.contains(product);

    try {
      if (isProductInCart) {
        await _removeFromCart(product);
      } else {
        await _addToCart(product);
      }

      notifyListeners();
    } catch (e) {
      _handleError('Error al actualizar estado del carrito: $e');
    }
  }

  // Helper methods
  Future<void> _addToCart(Product product) async {
    await http.post(
      Uri.parse(_cartEndpoint),
      body: jsonEncode({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'images': product.images,
      }),
    );
    cartProducts.add(product);
  }

  Future<void> _removeFromCart(Product product) async {
    await http.delete(
      Uri.parse(_cartEndpoint),
      body: jsonEncode({'id': product.id}),
    );
    cartProducts.remove(product);
  }

  void _handleError(String errorMessage) {
    print(errorMessage);
    product = [];
    filteredProducts = [];
  }
}
