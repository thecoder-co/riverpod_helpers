import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_helpers/core/utils/extensions/widget_extensions.dart';
import 'package:riverpod_helpers/features/products/presentation/widgets/products_box.dart';
import 'package:riverpod_helpers/features/products/providers/posts_provider.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  @override
  void initState() {
    _storeScrollController.addListener(() {
      if (_storeScrollController.position.pixels ==
          _storeScrollController.position.maxScrollExtent) {
        ref.read(productsProvider.notifier).getProducts(reload: false);
      }
    });
    super.initState();
  }

  final _storeScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    if (products.productsModel == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref.read(productsProvider.notifier).refreshData();
      },
      child: ListView.builder(
        controller: _storeScrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20)
            .copyWith(top: MediaQuery.paddingOf(context).top + 20),
        itemCount: (products.productsModel?.products?.length ?? 0) + 1,
        itemBuilder: (context, index) {
          if (index == products.productsModel?.products?.length) {
            if (products.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const SizedBox.shrink();
            }
          }
          return ProductsBox(
            product: products.productsModel!.products![index],
          ).paddingOnly(b: 20);
        },
      ),
    );
  }
}
