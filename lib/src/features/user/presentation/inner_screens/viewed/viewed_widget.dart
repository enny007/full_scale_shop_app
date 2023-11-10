import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/quantity_controller.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/viewed_model.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewedRecentlyWidget extends ConsumerWidget {
  const ViewedRecentlyWidget({
    super.key,
    required this.viewedProductModel,
  });

  final ViewedProductModel viewedProductModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final cartProvider = ref.watch(cartNotifierProvider.notifier);
    final product = ref.watch(productIdProvider(viewedProductModel.productId));
    bool? isInCart = ref.watch(cartNotifierProvider).containsKey(product.id);
    double usedPrice = product.isOnSale ? product.salePrice : product.price;
    Size size = Utils(context).screenSize;
    return GestureDetector(
      onTap: () {
        context.router.push(
          ProductsDetailRoute(productId: viewedProductModel.productId),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FancyShimmerImage(
            width: size.width * 0.27,
            height: size.width * 0.25,
            imageUrl: product.imageUrl,
            boxFit: BoxFit.fill,
          ),
          const Gap(12),
          Column(
            children: [
              TextWidget(
                text: product.title,
                color: color,
                textSize: 24,
                isTitle: true,
              ),
              const Gap(12),
              TextWidget(
                text: '\$${usedPrice.toStringAsFixed(2)}',
                color: color,
                textSize: 20,
                isTitle: false,
              ),
            ],
          ),
          const Spacer(),
          QuantityController(
            fct: isInCart
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
                      productId: product.id,
                      quantity: 1,
                    );
                  },
            icon: isInCart ? Icons.check : IconlyBold.plus,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
