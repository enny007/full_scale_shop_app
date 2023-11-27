import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:full_scale_shop_app/src/features/cart/domain/cart_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class CartRepository {
  final FirebaseFirestore _firestore;
  CartRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;


  //To add an entity to the cart in firebase
  FutureVoid addToCart({
    required String productId,
    required int quantity,
    required WidgetRef ref,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    final cartId = const Uuid().v4();
    try {
      return right(await _firestore.collection('users').doc(user!.uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      }));
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
  // To get the entity and formulate our ui
  FutureVoid fetchToCart({
    required WidgetRef ref,
    required Map<String, CartModel> cartItems,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    try {
      return right(
        await _firestore.collection('users').doc(user!.uid).get().then(
          (value) {
            for (var cartItemData in value.get('userCart')) {
              String productId = cartItemData['productId'];
              cartItems.putIfAbsent(
                productId,
                () {
                  return CartModel(
                    id: cartItemData['cartId'],
                    productId: productId,
                    quantity: cartItemData['quantity'],
                  );
                },
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

  FutureVoid removeFromCart(
      {required String productId,
      required int quantity,
      required WidgetRef ref,
      required String cartId}) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    // final cartId = const Uuid().v4();
    try {
      return right(await _firestore.collection('users').doc(user!.uid).update({
        'userCart': FieldValue.arrayRemove([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      }));
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

  FutureVoid clearOnlineCart({
    required WidgetRef ref,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    // final cartId = const Uuid().v4();
    try {
      return right(await _firestore.collection('users').doc(user!.uid).update({
        'userCart': [],
      }));
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

final cartRepoProvider = Provider<CartRepository>((ref) {
  return CartRepository(
    firestore: ref.read(fireStoreProvider),
  );
});
