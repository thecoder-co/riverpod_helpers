import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_helpers/core/services/services.dart';
import 'package:riverpod_helpers/core/utils/string_exception.dart';
import 'package:riverpod_helpers/features/products/model/products_model.dart';

final productDetailsProvider =
    FutureProvider.family<Product, int>((ref, id) async {
  final service = BackendService(Dio());
  Response response = await service.runCall(
    service.dio.get(
      '/products/$id',
    ),
  );

  final int statusCode = response.statusCode ?? 000;

  if (statusCode >= 200 && statusCode <= 300) {
    return Product.fromJson(response.data);
  }

  throw StringException(
    response.data['message'] ?? 'Something went wrong',
  );
});
