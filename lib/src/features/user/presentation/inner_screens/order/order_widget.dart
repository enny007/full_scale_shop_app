import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/order_model.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderWidget extends HookConsumerWidget {
  const OrderWidget({
    super.key,
    required this.orderModel,
  });
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final product = ref.watch(productIdProvider(orderModel.productId));
    Size size = Utils(context).screenSize;
    final orderDateTime = useState('');
    useEffect(() {
      final orderDate = orderModel.orderDate.toDate();
      orderDateTime.value =
          '${orderDate.day}/${orderDate.month}/${orderDate.year}';
      return () {};
    });
    return ListTile(
      subtitle:
          Text('Paid: \$${double.parse(orderModel.price).toStringAsFixed(2)}'),
      onTap: () {
        // context.router.push(
        //   ProductsDetailRoute(productId: ''),
        // );
       
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: product.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
        text: '${product.title} x ${orderModel.quantity}',
        color: color,
        textSize: 18,
      ),
      trailing: TextWidget(
        text: orderDateTime.value,
        color: color,
        textSize: 18,
      ),
    );
  }
}
