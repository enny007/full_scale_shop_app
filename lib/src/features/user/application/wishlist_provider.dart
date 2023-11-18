import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/wishlist_model.dart';
import 'package:full_scale_shop_app/src/features/user/repository/wishlist_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WishListProvider extends StateNotifier<Map<String, WishListModel>> {
  WishListProvider() : super({});

  Map<String, WishListModel> get getWishListItems => state;
  // Future<void> addAndRemoveProductsToWishList({
  //   required String productId,
  //   required WidgetRef ref,
  // }) async {

  //   final items = {...state};
  //   if (items.containsKey(productId)) {
  //     items.remove(productId);
  //   } else {
  //     items.putIfAbsent(productId, () {
  //       return WishListModel(
  //         id: DateTime.now().toString(),
  //         productId: productId,
  //       );
  //     });
  //   }
  //   state = items;
  // }
  Future<void> addToWishList({
    required String productId,
    required WidgetRef ref,
  }) async {
    final wishlist = ref.read(wishListRepoProvider);
    final items = {...state};
    final result = await wishlist.addToWishList(
      productId: productId,
      ref: ref,
    );
    state = items;
    items.putIfAbsent(productId, () {
      return WishListModel(
        id: DateTime.now().toString(),
        productId: productId,
      );
    });
    result.fold(
      (l) => null,
      (r) => Fluttertoast.showToast(
        msg: "Item has been added to your wishlist",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      ),
    );
  }

  Future<void> fetchWishList({
    required WidgetRef ref,
  }) async {
    final cart = ref.read(wishListRepoProvider);
    final items = {...state};
    final result = await cart.fetchToWishList(
      ref: ref,
      wishItems: items,
    );
    state = items;
    return result.fold(
      (l) => null,
      (r) => null,
    );
  }

  // void removeOneItem(String productId) {
  //   final items = {...state};
  //   items.remove(productId);
  //   state = items;
  // }
  Future<void> removeFromWishList({
    required WidgetRef ref,
    required String wishListId,
    required String productId,
  }) async {
    final cart = ref.read(wishListRepoProvider);
    final items = {...state};
    final result = await cart.removeFromWishList(
      ref: ref,
      wishListId: wishListId,
      productId: productId,
    );
    items.remove(productId);
    await fetchWishList(ref: ref);
    state = items;
    return result.fold(
      (l) => null,
      (r) => showSnackBar(
        ref.context,
        'Item removed from WishList',
      ),
    );
  }

  Future<void> clearOnlineWishList({
    required WidgetRef ref,
  }) async {
    final cart = ref.read(wishListRepoProvider);
    final items = {...state};
    final result = await cart.clearOnlineWishList(
      ref: ref,
    );
    state = items;
    items.clear();
    return result.fold(
      (l) => null,
      (r) => showSnackBar(
        ref.context,
        'Item removed from WishList',
      ),
    );
  }

  // void clearWishlist() {
  //   final items = {...state};
  //   items.clear();
  //   state = items;
  // }
}

final wishlistProvider =
    StateNotifierProvider<WishListProvider, Map<String, WishListModel>>((ref) {
  return WishListProvider();
});
