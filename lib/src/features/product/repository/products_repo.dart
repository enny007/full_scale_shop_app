import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:full_scale_shop_app/src/features/product/domain/products_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsRepository {
  final FirebaseFirestore _firestore;
  ProductsRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  //Get products from the products collection
  FutureVoid fetchProducts({
    required Map<String, ProductModel> productMap,
  }) async {
    try {
      return right(
        await _firestore.collection('products').get().then((value) {
          for (var element in value.docs) {
            final productId = element.get('id');

            productMap[productId] = ProductModel(
              id: productId,
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(element.get('price')),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              isPiece: element.get('isPiece'),
            );
          }
        }),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepository(
    firestore: ref.watch(fireStoreProvider),
  );
});
