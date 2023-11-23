import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/widgets/empty_screen.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/order_provider.dart';
import 'package:full_scale_shop_app/src/features/user/presentation/inner_screens/order/order_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});
  // final ProductModel productModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final ordersList = ref.watch(ordersListProvider);
    return ordersList.isEmpty
        ? const EmptyScreen(
            title: 'You dont have any order yet',
            subtitle: 'Order something in just a click',
            buttonText: 'Shop now',
            imagePath: 'assets/images/cart.png',
            isCartScreen: false,
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: TextWidget(
                text: 'Order (${ordersList.length})',
                color: color,
                isTitle: true,
                textSize: 22,
              ),
            ),
            body: ListView.separated(
              itemCount: ordersList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 6,
                  ),
                  child: OrderWidget(
                    orderModel: ordersList[index],
                  ),
                );
              },
              separatorBuilder: (_, index) => Divider(
                color: color,
                thickness: 1,
              ),
            ),
          );
  }
}
