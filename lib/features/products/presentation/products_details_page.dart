import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_helpers/core/utils/extensions/widget_extensions.dart';
import 'package:riverpod_helpers/features/products/providers/posts_details_provider.dart';

class ProductsDetailsPage extends ConsumerWidget {
  final int id;
  const ProductsDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailsProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text(product.when(
          data: (product) => product.title ?? '',
          loading: () => 'Loading...',
          error: (error, stackTrace) => 'Error',
        )),
      ),
      body: product.when(
        data: (product) => ListView(
          padding: const EdgeInsets.all(20)
              .copyWith(top: MediaQuery.paddingOf(context).top + 20),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                product.thumbnail ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            20.spacingH,
            Text(
              '\$${product.price}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            20.spacingH,
            Text(product.description ?? ''),
            10.spacingH,
            Text(product.brand ?? ''),
            10.spacingH,
            Text(product.category ?? ''),
            10.spacingH,
            Text('${product.rating ?? ''}'),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
