import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_controller.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/order_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckOut extends HookConsumerWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    Size size = Utils(context).screenSize;
    final cartProvider = ref.watch(cartNotifierProvider);
    double total = 0.0;
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    final orderProvider = ref.read(orderControllerProvider);
    cartProvider.forEach((key, value) {
      final product = ref.watch(productIdProvider(value.productId));
      total += (product.isOnSale ? product.salePrice : product.price) *
          value.quantity;
    });

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  await ref.read(cartControllerProvider).initpayment(
                        email: user!.email ?? '',
                        amount: total,
                        ref: ref,
                      );
                  orderProvider.setOrder(
                    ref: ref,
                    total: total,
                  );
                  //When the order is about to be successful the cart should be cleared
                  await ref.read(cartNotifierProvider.notifier).clearOnlineCart(
                        ref: ref,
                      );
                  ref.read(cartNotifierProvider.notifier).clearCart();
                  await orderProvider.fetchOrders(
                    ref: ref,
                    orderList: ref.read(ordersListProvider),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Order Now',
                    color: color,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: TextWidget(
                text: 'Total: \$${total.toStringAsFixed(2)}',
                color: color,
                textSize: 18,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
