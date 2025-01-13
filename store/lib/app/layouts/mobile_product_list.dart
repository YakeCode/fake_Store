import 'package:flutter/material.dart';
import 'package:store/app/screens/product/product_card_mobile.dart';

class MobileProductList extends StatelessWidget {
  const MobileProductList({
    super.key,
    required this.products,
  });

  final List<dynamic> products;

  static const double mobileSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: mobileSpacing),
          child: ProductCardMobile(
            product: products[index],
          ),
        );
      },
    );
  }
}
