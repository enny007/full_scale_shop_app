import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/loader.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeartBTN extends HookConsumerWidget {
  const HeartBTN({
    super.key,
    required this.color,
    required this.productId,
    this.isInWishlist = false,
  });

  final Color color;
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishListProvider = ref.watch(wishlistProvider.notifier);
    final getCurrentProduct = ref.watch(productIdProvider(productId));
    final wishlistLoader = useState(false);
    return GestureDetector(
      onTap: () async {
        final auth = ref.watch(authProvider);
        final user = auth.currentUser;
        print('user id is ${user?.uid}');
        wishlistLoader.value = true;
        if (user == null) {
          GlobalMethods.errorDialog(
            subtitle: 'No user found, please login first',
            context: context,
          );
          return;
        }
        if (isInWishlist == false && isInWishlist != null) {
          await wishListProvider.addToWishList(
            productId: productId,
            ref: ref,
          );
        } else {
          await wishListProvider.removeFromWishList(
            ref: ref,
            wishListId:
                wishListProvider.getWishListItems[getCurrentProduct.id]!.id,
            productId: productId,
          );
        }
        await wishListProvider.fetchWishList(
          ref: ref,
        );
        wishlistLoader.value = false;
      },
      child: wishlistLoader.value
          ? const Loader(
              size: 22,
            )
          : Icon(
              isInWishlist != null && isInWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 22,
              color: isInWishlist != null && isInWishlist == true
                  ? Colors.red
                  : color,
            ),
    );
  }
}
