import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/empty_screen.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:full_scale_shop_app/src/features/user/presentation/inner_screens/wishlist/wishlist_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

@RoutePage()
class WishListScreen extends ConsumerWidget {
  const WishListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    // Size size = Utils(context).screenSize;
    final wishListProvider = ref.watch(wishlistProvider);
    final wishlistItemsList =
        wishListProvider.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your Wishlist is Empty',
            subtitle: 'Explore more and shortlist some items',
            buttonText: 'Add a wish',
            imagePath: 'assets/images/wishlist.png',
            isCartScreen: false,
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: TextWidget(
                text: 'WishList (${wishlistItemsList.length})',
                color: color,
                isTitle: true,
                textSize: 22,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                      context: context,
                      title: 'Empty your wishList',
                      subtitle: 'Are you sure?',
                      fct: () {
                        ref.read(wishlistProvider.notifier).clearWishlist();
                      },
                    );
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 4,
              // crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return WishListWidget(
                  wishListModel: wishlistItemsList[index],
                );
              },
            ),
          );
  }
}
