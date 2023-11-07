import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'Order (2)',
          color: color,
          isTitle: true,
          textSize: 22,
        ),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 6,
            ),
            child: OrderWidget(),
          );
        },
        separatorBuilder: (_, index) => Divider(
          color: color,
          thickness: 1,
        ),
        itemCount: 10,
      ),
    );
  }
}
