import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  FutureVoid updateShippingAddress(
      {required String uid, required String address}) async {
    try {
      return right(
        await _firestore.collection('users').doc(uid).update(
          {
            'shipping-address': address,
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

final userRepoProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    firestore: ref.watch(fireStoreProvider),
  );
});
