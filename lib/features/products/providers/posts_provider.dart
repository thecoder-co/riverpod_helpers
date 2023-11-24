import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_helpers/core/services/services.dart';
import 'package:riverpod_helpers/features/products/model/products_model.dart';

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsService>((ref) {
  return ProductsNotifier(ref, ProductsService());
});

class ProductsNotifier extends StateNotifier<ProductsService> {
  final Ref ref;
  final ProductsService repo;
  ProductsNotifier(this.ref, this.repo) : super(ProductsService()) {
    refreshData();
  }

  void refreshData() async {
    getProducts(reload: true);
  }

  Future<void> getProducts({
    required bool reload,
  }) async {
    state = state.copyWith(loading: true);
    final res = await state.getAllProducts(
      skip: reload ? 0 : state.nextPage * 5,
    );
    state = state.copyWith(loading: false);

    if (!mounted) return;
    if (res.valid) {
      if (reload) {
        state = state.copyWith(
          products: res.data,
          nextPage: 2,
        );
        return;
      }
      if (res.data?.products?.isEmpty ?? true) {
        return;
      }
      final newdata = state.productsModel == null
          ? res.data
          : state.productsModel!.copyWith(
              products: [
                ...state.productsModel!.products!,
                ...res.data!.products!,
              ],
            );
      state = state.copyWith(
        products: newdata,
        nextPage: state.nextPage + 1,
      );
    }
  }
}

class ProductsService {
  ProductsModel? productsModel;
  int nextPage;
  bool loading;
  ProductsService({
    this.productsModel,
    this.nextPage = 1,
    this.loading = false,
  });

  final BackendService _apiService = BackendService(Dio());

  //copyWith
  ProductsService copyWith({
    ProductsModel? products,
    int? nextPage,
    bool? loading,
  }) {
    return ProductsService(
      productsModel: products ?? productsModel,
      nextPage: nextPage ?? this.nextPage,
      loading: loading ?? this.loading,
    );
  }

  Future<ResponseModel<ProductsModel>> getAllProducts({
    int skip = 0,
    int limit = 5,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '/products',
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel<ProductsModel>(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ProductsModel.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data),
      statusCode: statusCode,
      message: response.data['message'],
    );
  }
}
