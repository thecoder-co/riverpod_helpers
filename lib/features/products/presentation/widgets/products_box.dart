import 'package:flutter/material.dart';
import 'package:riverpod_helpers/core/utils/extensions/widget_extensions.dart';
import 'package:riverpod_helpers/features/products/model/products_model.dart';
import 'package:riverpod_helpers/features/products/presentation/products_details_page.dart';
import 'package:riverpod_helpers/router/route/app_routes.dart';

class ProductsBox extends StatelessWidget {
  final Product product;
  const ProductsBox({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(
          context,
          ProductsDetailsPage(id: product.id!),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                product.thumbnail ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(),
                Text(
                  product.title ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(product.description ?? ''),
              ],
            ).paddingOnly(l: 5, r: 5, b: 0, t: 20),
          ],
        ),
      ),
    );
  }
}
