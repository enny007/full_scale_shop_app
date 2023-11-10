import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/heart_btn.dart';
import 'package:full_scale_shop_app/src/core/widgets/quantity_controller.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/cart/domain/cart_model.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartWidget extends HookConsumerWidget {
  const CartWidget({
    super.key,
    required this.cartModel,
    required this.q,
  });
  final CartModel cartModel;
  final int q;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //dependencies with riverpod
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final product = ref.watch(productIdProvider(cartModel.productId));
    final cartProvider = ref.read(cartNotifierProvider.notifier);
    bool? isInWishList = ref.watch(wishlistProvider).containsKey(product.id);
    //size Mediaquery extension
    Size size = Utils(context).screenSize;
    //hooks for forms
    final quantityTextController = useTextEditingController(
      text: q.toString(),
    );
    useListenable(quantityTextController);
    // usedPrice variation based on a condition
    double usedPrice = product.isOnSale ? product.salePrice : product.price;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.router.push(
                        ProductsDetailRoute(productId: cartModel.productId),
                      );
                    },
                    child: Container(
                      height: size.width * 0.40,
                      width: size.width * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: product.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: product.title,
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const Gap(16),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Row(
                          children: [
                            QuantityController(
                              fct: () {
                                if (quantityTextController.text == '1') {
                                  return;
                                } else {
                                  cartProvider
                                      .reduceQuantityByOne(cartModel.productId);
                                  quantityTextController.text =
                                      (int.parse(quantityTextController.text) -
                                              1)
                                          .toString();
                                }
                              },
                              color: Colors.red,
                              icon: CupertinoIcons.minus,
                            ),
                            const Gap(10),
                            Text(
                              q.toString(),
                            ),
                            const Gap(10),
                            QuantityController(
                              fct: () {
                                cartProvider
                                    .increaseQuantityByOne(cartModel.productId);
                                quantityTextController.text =
                                    (int.parse(quantityTextController.text) + 1)
                                        .toString();
                              },
                              color: Colors.green,
                              icon: CupertinoIcons.plus,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cartProvider.removeOneItem(cartModel.productId);
                          },
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const Gap(5),
                        HeartBTN(
                          color: color,
                          productId: product.id,
                          isInWishlist: isInWishList,
                        ),
                        TextWidget(
                          text: '\$${usedPrice.toStringAsFixed(2)}',
                          color: color,
                          textSize: 18,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const Gap(5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
