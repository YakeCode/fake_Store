import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/providers/provider.dart';
import 'package:store/app/screens/cart/card_in_cart.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final cartProducts = productProvider.cartProducts;
          final double totalPrice =
              cartProducts.fold(0, (sum, product) => sum + product.price);
          return Column(
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? const Center(
                        child: Text('No products in cart'),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final product = cartProducts[index];
                          return ProductCardInCart(product: product);
                        },
                      ),
              ),
              Container(
                color: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total to pay:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Total Products: ",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                            children: [
                              TextSpan(
                                text: "${cartProducts.length}",
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$ ${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 140,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(color: Colors.teal),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
