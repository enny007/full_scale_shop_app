import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/cart/repo/cart_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../domain/cart_model.dart';

class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({});
  // void addProductsToCart({
  //   required String productId,
  //   required int quantity,
  // }) {
  //   final items = {...state};
  //   final newItems = CartModel(
  //     id: DateTime.now().toString(),
  //     productId: productId,
  //     quantity: quantity,
  //   );
  //   items.putIfAbsent(productId, () => newItems);
  //   state = items;
  // }
  Future<void> fetchCart({
    required WidgetRef ref,
  }) async {
    final cart = ref.read(cartRepoProvider);
    final items = {...state};
    final result = await cart.fetchToCart(
      ref: ref,
      cartItems: items,
    );
    state = items;
    return result.fold(
      (l) => null,
      (r) => null,
    );
  }

  void reduceQuantityByOne(String productId) {
    final items = {...state};
    items.update(productId, (value) {
      return CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      );
    });
    state = items;
  }

  void increaseQuantityByOne(String productId) {
    final items = {...state};
    items.update(productId, (value) {
      return CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      );
    });
    state = items;
  }

  // void removeOneItem(String productId) {
  //   final items = {...state};
  //   items.remove(productId);
  //   state = items;
  // }
  Future<void> removeFromCart({
    required WidgetRef ref,
    required String productId,
    required String cartId,
    required int quantity,
  }) async {
    final cart = ref.read(cartRepoProvider);
    final items = {...state};
    final result = await cart.removeFromCart(
      ref: ref,
      productId: productId,
      cartId: cartId,
      quantity: quantity,
    );
    items.remove(productId);
    await fetchCart(ref: ref);
    state = items;
    return result.fold(
      (l) => null,
      (r) => showSnackBar(
        ref.context,
        'Item removed from cart',
      ),
    );
  }

  Future<void> clearOnlineCart({required WidgetRef ref}) async {
    final cart = ref.read(cartRepoProvider);
    final items = {...state};
    final result = await cart.clearOnlineCart(
      ref: ref,
    );
    items.clear();
    state = items;
    return result.fold(
      (l) => null,
      (r) => showSnackBar(
        ref.context,
        'Your cart has been cleared',
      ),
    );
  }

  // void clearCart() {
  //   final items = {...state};
  //   items.clear();
  //   state = items;
  // }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) {
  return CartNotifier();
});
