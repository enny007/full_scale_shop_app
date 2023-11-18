import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/wishlist_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class WishListRepository {
  final FirebaseFirestore _firestore;
  WishListRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  FutureVoid addToWishList({
    required String productId,
    required WidgetRef ref,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    final wishListId = const Uuid().v4();
    try {
      return right(await _firestore.collection('users').doc(user!.uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishListId': wishListId,
            'productId': productId,
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

  FutureVoid fetchToWishList({
    required WidgetRef ref,
    required Map<String, WishListModel> wishItems,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    try {
      return right(
        await _firestore.collection('users').doc(user!.uid).get().then(
          (value) {
            for (var cartItemData in value.get('userWish')) {
              String productId = cartItemData['productId'];
              wishItems.putIfAbsent(
                productId,
                () {
                  return WishListModel(
                    id: cartItemData['wishListId'],
                    productId: productId,
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

  FutureVoid removeFromWishList({
    required String productId,
    required WidgetRef ref,
    required String wishListId,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    try {
      return right(await _firestore.collection('users').doc(user!.uid).update({
        'userWish': FieldValue.arrayRemove([
          {
            'wishListId': wishListId,
            'productId': productId,
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

  FutureVoid clearOnlineWishList({
    required WidgetRef ref,
  }) async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    // final cartId = const Uuid().v4();
    try {
      return right(await _firestore.collection('users').doc(user!.uid).update({
        'userWish': [],
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

final wishListRepoProvider = Provider<WishListRepository>((ref) {
  return WishListRepository(
    firestore: ref.watch(fireStoreProvider),
  );
});
