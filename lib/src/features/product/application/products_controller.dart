import 'package:full_scale_shop_app/src/features/product/domain/products_model.dart';
import 'package:full_scale_shop_app/src/features/product/repository/products_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsController {
  final ProductsRepository _productRepository;

  ProductsController({
    required ProductsRepository productRepository,
  }) : _productRepository = productRepository;

  Future<void> fetchProducts({
    required WidgetRef ref,
    required List<ProductModel> productsList,
  }) async {
    final result = await _productRepository.fetchProducts(
      productList: productsList,
    );
    result.fold(
      (l) => null,
      (r) => null,
    );
  }
}

final productControllerProvider = Provider<ProductsController>((ref) {
  return ProductsController(
    productRepository: ref.watch(productsRepositoryProvider),
  );
});
