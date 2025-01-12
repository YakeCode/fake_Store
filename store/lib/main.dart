import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/providers/provider.dart';
import 'package:store/app/screens/fake_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fake Store',
          home: FakeStore(),
        ));
  }
}
