import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/widgets/check_out.dart';
import 'package:full_scale_shop_app/src/core/widgets/empty_screen.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/cart/presentation/cart_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final cartProvider = ref.watch(cartNotifierProvider);
    final cartItemsList = cartProvider.values.toList().reversed.toList();

    return cartItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your Cart is Empty',
            subtitle: 'Add something to your cart',
            buttonText: 'Shop now',
            imagePath: 'assets/images/cart.png',
            isCartScreen: true,
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: 'Cart (${cartItemsList.length})',
                color: color,
                isTitle: true,
                textSize: 22,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                      context: context,
                      title: 'Empty your cart',
                      subtitle: 'Are you Sure?',
                      fct: () {
                        ref.read(cartNotifierProvider.notifier).clearCart();
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
            body: Column(
              children: [
                const CheckOut(),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemsList.length,
                    itemBuilder: (context, index) {
                      // print(cartItemsList[index].quantity);
                      return CartWidget(
                        cartModel: cartItemsList[index],
                        q: cartItemsList[index].quantity,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
