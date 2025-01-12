import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/providers/provider.dart';
import 'package:store/app/screens/product/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productsProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productsProvider.fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.product.isEmpty) {
              return const Center(child: Text('No products found'));
            } else {
              return ListView.builder(
                itemCount: provider.product.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: provider.product[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
