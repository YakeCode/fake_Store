import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/models/model_product.dart';
import 'package:store/app/providers/provider.dart';

class ProductDetail extends StatefulWidget {
  final Product productData;

  const ProductDetail({super.key, required this.productData});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isProductInCart = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isProductInCart = Provider.of<ProductProvider>(context, listen: false)
        .cartProducts
        .contains(widget.productData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<ProductProvider>(context, listen: false)
                  .toggleCartStatus(widget.productData);
              setState(() {
                isProductInCart = !isProductInCart;
              });
            },
            icon: Icon(
              isProductInCart
                  ? Icons.shopping_cart_sharp
                  : Icons.add_shopping_cart_sharp,
              color: isProductInCart ? Colors.teal : Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(widget.productData.images[0]),
              ),
              const SizedBox(height: 8),
              Text(
                widget.productData.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$ ${widget.productData.price}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.productData.description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
