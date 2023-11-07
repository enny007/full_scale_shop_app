import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/empty_product.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/home/presentation/on_sale_widget.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class OnSaleScreen extends ConsumerWidget {
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = Utils(context).screenSize;
    // bool isEmpty = false;
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final productsOnSale = ref.watch(onSaleProductsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: TextWidget(
          text: 'Products on Sale',
          color: color,
          textSize: 22,
          isTitle: true,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(
              text: 'No products on sale yet!,\nStay tuned',
            )
          : GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.68),
              children: List.generate(productsOnSale.length, (index) {
                return OnSaleWidget(
                  productModel: productsOnSale[index],
                );
              }),
            ),
    );
  }
}
