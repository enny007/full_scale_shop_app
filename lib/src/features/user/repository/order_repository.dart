import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/order_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  const OrderRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  FutureVoid setOrderCollection({
    required WidgetRef ref,
    required double total,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    final cartProvider = ref.watch(cartNotifierProvider);
    try {
      final orderId = const Uuid().v4();
      return right(
        cartProvider.forEach(
          (key, value) async {
            //use current user product id here
            final product = ref.watch(productIdProvider(value.productId));
            await _firestore.collection('orders').doc(orderId).set(
              {
                'orderId': orderId,
                'userId': user!.uid,
                'productId': value.productId,
                'price':
                    (product.isOnSale ? product.salePrice : product.price) *
                        value.quantity,
                'totalPrice': total,
                'quantity': value.quantity,
                'imageUrl': product.imageUrl,
                'userName': user.displayName,
                'orderDate': Timestamp.now(),
              },
            );
          },
        ),
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

  FutureVoid fetchOrders({
    required List orderList,
    required WidgetRef ref,
  }) async {
    try {
      final auth = ref.watch(authProvider);
      final user = auth.currentUser;
      return right(
        await _firestore
            .collection('orders')
            .where('userId', isEqualTo: user!.uid)
            .get()
            .then(
          (value) {
            // orderList.clear();
            for (var element in value.docs) {
              orderList.insert(
                0,
                OrderModel(
                  imageUrl: element.get('imageUrl'),
                  quantity: element.get('quantity').toString(),
                  orderId: element.get('orderId'),
                  productId: element.get('productId'),
                  orderDate: element.get('orderDate'),
                  price: element.get('price').toString(),
                  userId: element.get('userId'),
                  userName: element.get('userName'),
                ),
              );
            }
          },
        ),
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

final orderRepoProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(
    firestore: ref.read(fireStoreProvider),
  );
});
