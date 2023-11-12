import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_scale_shop_app/src/features/cart/repo/cart_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartController {
  final CartRepository _cartRepository;

  CartController({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  Future<void> addToCart({
    required WidgetRef ref,
    required String productId,
    required int quantity,
  }) async {
    final result = await _cartRepository.addToCart(
      productId: productId,
      quantity: quantity,
      ref: ref,
    );
    result.fold(
      (l) => null,
      (r) => Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      ),
    );
  }
}

final cartControllerProvider = Provider<CartController>((ref) {
  return CartController(
    cartRepository: ref.read(cartRepoProvider),
  );
});
