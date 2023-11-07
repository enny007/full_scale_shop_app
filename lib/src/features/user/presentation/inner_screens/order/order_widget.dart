import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderWidget extends ConsumerWidget {
  const OrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    // final productModel = ref.watch(productModelProvider);
    Size size = Utils(context).screenSize;
    return ListTile(
      subtitle: const Text('Paid: \$12.8'),
      onTap: () {
        context.router.push(
          ProductsDetailRoute(productId: ''),
        );
        //TODO:
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
        text: 'Title x12',
        color: color,
        textSize: 18,
      ),
      trailing: TextWidget(
        text: '03/08/2022',
        color: color,
        textSize: 18,
      ),
    );
  }
}
