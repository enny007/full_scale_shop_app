import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class CartRepository {
  final FirebaseFirestore _firestore;
  CartRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

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
}

final cartRepoProvider = Provider<CartRepository>((ref) {
  return CartRepository(
    firestore: ref.read(fireStoreProvider),
  );
});
