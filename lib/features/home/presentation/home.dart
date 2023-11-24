import 'package:flutter/material.dart';
import 'package:riverpod_helpers/features/products/presentation/products_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductsPage(),
    );
  }
}
