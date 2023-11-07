import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/heart_btn.dart';
import 'package:full_scale_shop_app/src/core/widgets/price_widget.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/domain/products_model.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeedsWidget extends HookConsumerWidget {
  const FeedsWidget({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = Utils(context).screenSize;
    final color = 
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final cartProvider = ref.watch(cartNotifierProvider.notifier);
    //To get whether an item is in the cart, we use the id to track this
    bool? isInCart =
        ref.watch(cartNotifierProvider).containsKey(productModel.id);
    bool? isInWishList =
        ref.watch(wishlistProvider).containsKey(productModel.id);
    final quantityController = useTextEditingController(text: '1');
    useListenable(quantityController);

    //THis listenable is to trigger the initial state build for the controller upon being built
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.router
                .push(ProductsDetailRoute(productId: productModel.id));
          },
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width * 0.25,
                width: size.width * 0.15,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productModel.title,
                        color: color,
                        textSize: 18,
                        maxLines: 1,
                        isTitle: true,
                      ),
                    ),
                    HeartBTN(
                      color: color,
                      productId: productModel.id,
                      isInWishlist: isInWishList,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: PriceWidget(
                        isOnSale: productModel.isOnSale,
                        price: productModel.price,
                        textPrice: quantityController.value.text,
                        salePrice: productModel.salePrice,
                      ),
                    ),
                    const Gap(8),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          FittedBox(
                            child: TextWidget(
                              text: productModel.isPiece ? 'Piece' : 'Kg',
                              color: color,
                              textSize: 16,
                              isTitle: true,
                            ),
                          ),
                          const Gap(5),
                          Flexible(
                            child: TextFormField(
                              controller: quantityController,
                              key: const ValueKey('10'),
                              style: TextStyle(
                                color: color,
                                fontSize: 18,
                              ),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.green,
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 17,
                child: TextButton(
                  //to disable this button from pressing if an item is in cart
                  onPressed: isInCart
                      ? null
                      : () {
                          final auth = ref.watch(authProvider);
                          final user = auth.currentUser;

                          if (user == null) {
                            GlobalMethods.errorDialog(
                              subtitle: 'No user found, please login first',
                              context: context,
                            );
                            return;
                          }
                          cartProvider.addProductsToCart(
                            productId: productModel.id,
                            quantity: int.parse(quantityController.text),
                          );
                        },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    text: isInCart ? 'In Cart' : 'Add to cart',
                    color: color,
                    textSize: 20,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
