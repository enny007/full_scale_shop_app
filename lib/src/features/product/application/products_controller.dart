import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/product/repository/products_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsController {
  final ProductsRepository _productRepository;

  ProductsController({
    required ProductsRepository productRepository,
  }) : _productRepository = productRepository;

  Future<void> fetchProducts({required WidgetRef ref}) async {
    final productsList = ref.watch(productsListProvider);
    final result = await _productRepository.fetchProducts(
      productList: productsList,
    );
    result.fold(
      (l) => null,
      (r) => showSnackBar(
        ref.context,
        'Products Gotten successfully',
      ),
    );
  }
}

final productControllerProvider = Provider<ProductsController>((ref) {
  return ProductsController(
    productRepository: ref.watch(productsRepositoryProvider),
  );
});
