import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/providers/provider.dart';
import 'package:store/app/screens/product/product_card_mobile.dart';
import 'package:store/app/screens/product/product_card_responsive.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.filteredProducts.isEmpty) {
              return const Center(child: Text('No products found'));
            } else {
              if (screenWidth >= 548) {
                return SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      //spacing: 20, // Espacio horizontal entre cards
                      runSpacing: 20, // Espacio vertical entre filas
                      children: List.generate(
                        provider.filteredProducts.length,
                        (index) => ProductCardResponsive(
                          product: provider.filteredProducts[index],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: provider.filteredProducts.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ProductCardMobile(
                          product: provider.filteredProducts[index],
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
