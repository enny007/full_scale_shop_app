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

  void removeOneItem(String productId) {
    final items = {...state};
    items.remove(productId);
    state = items;
  }

  void clearCart() {
    final items = {...state};
    items.clear();
    state = items;
  }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) {
  return CartNotifier();
});
