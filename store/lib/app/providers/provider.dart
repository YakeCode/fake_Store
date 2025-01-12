import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store/app/models/model_product.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Product> product = [];
  List<Product> cartProducts = [];

  Future<void> fetchProduct() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.escuelajs.co/api/v1/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        product = (data as List).map((item) => Product.fromJson(item)).toList();
      } else {
        print('Error ${response.statusCode}');
        product = [];
      }
    } catch (e) {
      print('Error in request: $e');
      product = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleCartStatus(Product product) async {
    final isProductInCart = cartProducts.contains(product);

    try {
      final urlCart =
          Uri.parse('https://api.escuelajs.co/api/v1/products/cart');

      // Si el producto está en el carrito, eliminarlo
      if (isProductInCart) {
        await http.delete(
          urlCart,
          body:
              jsonEncode({'id': product.id}), // Enviar solo el id del producto
        );
        cartProducts.remove(product); // Eliminar solo el producto seleccionado
      } else {
        // Si no está en el carrito, añadirlo
        await http.post(
          urlCart,
          body: jsonEncode({
            'id': product.id, // Mandamos el id del producto
            'title': product.title, // Mandamos todos los campos que necesitas
            'price': product.price,
            'description': product.description,
            'images': product.images, // Mandamos las imágenes si es necesario
          }),
        );
        cartProducts.add(product); // Agregar solo el producto seleccionado
      }
      notifyListeners();
    } catch (e) {
      print('Error al actualizar estado del carrito: $e');
    }
  }
}
