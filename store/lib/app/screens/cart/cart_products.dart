import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/models/model_product.dart';
import 'package:store/app/providers/provider.dart';
import 'package:store/app/screens/product/product_detail.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final cartProducts = productProvider.cartProducts;
          return cartProducts.isEmpty
              ? Center(
                  child: const Text('No products in cart'),
                )
              : ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return ProductInCart(product: product);
                  },
                );
        },
      ),
    );
  }
}

class ProductInCart extends StatelessWidget {
  final Product product;
  const ProductInCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(productData: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            elevation: 4,
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.images.isNotEmpty ? product.images[0] : '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 1,
                          width: 75,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          '\$ ${product.price}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
