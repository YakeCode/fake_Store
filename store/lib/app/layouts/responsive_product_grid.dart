import 'package:flutter/material.dart';
import 'package:store/app/screens/product/product_card_responsive.dart';

class ResponsiveProductGrid extends StatelessWidget {
  const ResponsiveProductGrid({
    super.key,
    required this.products,
  });

  final List<dynamic> products;

  static const double wrapSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: wrapSpacing,
          children: List.generate(
            products.length,
            (index) => ProductCardResponsive(
              product: products[index],
            ),
          ),
        ),
      ),
    );
  }
}
