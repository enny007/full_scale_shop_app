import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/wishlist_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WishListProvider extends StateNotifier<Map<String, WishListModel>> {
  WishListProvider() : super({});

  void addAndRemoveProductsToWishList({required String productId}) {
    final items = {...state};
    if (items.containsKey(productId)) {
      items.remove(productId);
    } else {
      items.putIfAbsent(productId, () {
        return WishListModel(
          id: DateTime.now().toString(),
          productId: productId,
        );
      });
    }
    state = items;
  }

  // void removeOneItem(String productId) {
  //   final items = {...state};
  //   items.remove(productId);
  //   state = items;
  // }

  void clearWishlist() {
    final items = {...state};
    items.clear();
    state = items;
  }
}

final wishlistProvider =
    StateNotifierProvider<WishListProvider, Map<String, WishListModel>>((ref) {
  return WishListProvider();
});
