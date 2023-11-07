// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/heart_btn.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/domain/products_model.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:full_scale_shop_app/src/core/widgets/price_widget.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';

class OnSaleWidget extends ConsumerWidget {
  const OnSaleWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = Utils(context).screenSize;
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final cartProvider = ref.read(cartNotifierProvider.notifier);
    bool? isInCart =
        ref.watch(cartNotifierProvider).containsKey(productModel.id);
    bool? isInWishList =
        ref.watch(wishlistProvider).containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.router.push(
              ProductsDetailRoute(productId: productModel.id),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.width * 0.30,
                      width: size.width * 0.24,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: productModel.isPiece ? '1Piece' : '1KG',
                          color: color,
                          textSize: 18,
                          isTitle: true,
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                final auth = ref.watch(authProvider);
                                final user = auth.currentUser;
   

                                if (user == null) {
                                  GlobalMethods.errorDialog(
                                    subtitle:
                                        'No user found, please login first',
                                    context: context,
                                  );
                                  return;
                                }
                                cartProvider.addProductsToCart(
                                  productId: productModel.id,
                                  quantity: 1,
                                );
                              },
                              child: Icon(
                                isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 22,
                                color: isInCart ? Colors.green : color,
                              ),
                            ),
                            HeartBTN(
                              color: color,
                              productId: productModel.id,
                              isInWishlist: isInWishList,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                PriceWidget(
                  isOnSale: true,
                  price: productModel.price,
                  textPrice: '1',
                  salePrice: productModel.salePrice,
                ),
                const Gap(5),
                TextWidget(
                  text: productModel.title,
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
                const Gap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
