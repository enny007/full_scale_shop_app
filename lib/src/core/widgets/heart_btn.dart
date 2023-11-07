import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeartBTN extends ConsumerWidget {
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
    final wishListProvider = ref.read(wishlistProvider.notifier);
    return GestureDetector(
      onTap: () {
        final auth = ref.watch(authProvider);
        final user = auth.currentUser;
        print('user id is ${user?.uid}');

        if (user == null) {
          GlobalMethods.errorDialog(
            subtitle: 'No user found, please login first',
            context: context,
          );
          return;
        }
        wishListProvider.addAndRemoveProductsToWishList(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color:
            isInWishlist != null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
