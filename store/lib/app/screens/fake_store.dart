import 'package:flutter/material.dart';
import 'package:store/app/screens/cart/cart_products.dart';
import 'package:store/app/screens/home/home.dart';
import 'package:store/app/screens/product/product_search_input.dart';

class FakeStore extends StatelessWidget {
  const FakeStore({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Row(
            children: [
              const Text(
                'Fake Store',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'roboto',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              const SearchInput(),
            ],
          ),
          bottom: const TabBar(
            indicatorWeight: 4,
            indicatorColor: Colors.teal,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.shopping_cart_sharp), text: 'Shopping Cart'),
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
