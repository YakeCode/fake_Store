import 'package:flutter/material.dart';
import 'package:store/app/screens/cart/cart_products.dart';
import 'package:store/app/screens/home/home.dart';
import 'package:store/app/screens/product/product_search_input.dart';

class FakeStoreDesktop extends StatelessWidget {
  const FakeStoreDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          toolbarHeight: 74.0,
          title: Row(
            children: [
              const Text(
                'Fake Store',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'roboto',
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 30),
              const Expanded(child: SearchInput()),
              const SizedBox(width: 30),
              Flexible(
                child: TabBar(
                  indicatorWeight: 4,
                  indicatorColor: Colors.teal,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: 'Home'),
                    Tab(icon: Icon(Icons.shopping_cart_sharp), text: 'Cart'),
                    Tab(
                        icon: Icon(Icons.document_scanner_sharp),
                        text: 'My Orders'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [HomeScreen(), CartProducts()],
        ),
      ),
    );
  }
}
