import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/heart_btn.dart';
import 'package:full_scale_shop_app/src/core/widgets/quantity_controller.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_controller.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/viewed_product_provider.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProductsDetailScreen extends HookConsumerWidget {
  const ProductsDetailScreen({
    super.key,
    @PathParam('id') required this.productId,
  });
  final String productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final product = ref.watch(productIdProvider(productId));
    final cartProvider = ref.read(cartNotifierProvider.notifier);
    bool? isInCart = ref.watch(cartNotifierProvider).containsKey(product.id);
    bool? isInWishList = ref.watch(wishlistProvider).containsKey(product.id);
    Size size = Utils(context).screenSize;
    final quantityController = useTextEditingController(text: '1');

    useListenable(quantityController);
    //**To show a price for when the product is on sale and when it is not on sale;;;
    double usedPrice = product.isOnSale ? product.salePrice : product.price;
    double totalPrice = usedPrice * int.parse(quantityController.text);
    return WillPopScope(
      onWillPop: () async {
        ref
            .read(viewedProductProvider.notifier)
            .addProductsToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: product.imageUrl,
                width: size.width,
                boxFit: BoxFit.fill,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: product.title,
                              color: color,
                              textSize: 25,
                              isTitle: true,
                            ),
                          ),
                          HeartBTN(
                            color: color,
                            productId: product.id,
                            isInWishlist: isInWishList,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: '\$${usedPrice.toStringAsFixed(2)}/',
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: product.isPiece ? 'Piece' : '/Kg',
                            color: color,
                            textSize: 12,
                            isTitle: false,
                          ),
                          const Gap(10),
                          Visibility(
                            visible: product.isOnSale ? true : false,
                            child: Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: color,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Material(
                            color: const Color.fromRGBO(63, 200, 100, 1),
                            borderRadius: BorderRadius.circular(5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextWidget(
                                text: 'Free Delivery',
                                color: color,
                                textSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuantityController(
                          fct: () {
                            if (quantityController.text == '1') {
                              return;
                            } else {
                              quantityController.text =
                                  (int.parse(quantityController.text) - 1)
                                      .toString();
                            }
                          },
                          icon: CupertinoIcons.minus_square,
                          color: Colors.red,
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value.isEmpty || value == '1') {
                                quantityController.text = '1';
                              } else {
                                quantityController.text = value;
                              }
                            },
                          ),
                        ),
                        const Gap(5),
                        QuantityController(
                          fct: () {
                            quantityController.text =
                                (int.parse(quantityController.text) + 1)
                                    .toString();
                          },
                          icon: CupertinoIcons.plus_square,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Total',
                                  color: Colors.red.shade200,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                                const Gap(5),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            '\$${totalPrice.toStringAsFixed(2)}/',
                                        color: color,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                        text: '1Kg',
                                        color: color,
                                        textSize: 16,
                                        isTitle: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Gap(8),
                          Flexible(
                            child: Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: isInCart
                                    ? null
                                    : () {
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
                                        ref
                                            .read(cartControllerProvider)
                                            .addToCart(
                                              ref: ref,
                                              productId: product.id,
                                              quantity: int.parse(
                                                quantityController.text,
                                              ),
                                            );
                                        // cartProvider.addProductsToCart(
                                        //   productId: product.id,
                                        //   quantity: int.parse(
                                        //       quantityController.text),
                                        // );
                                      },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                    text: isInCart ? 'In Cart' : 'Add to cart',
                                    color: color,
                                    textSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
