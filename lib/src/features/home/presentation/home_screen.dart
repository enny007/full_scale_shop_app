import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/feed_items.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/home/presentation/on_sale_widget.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offerImages = ref.watch(imageOfferProvider);
    final productsList = ref.watch(productsListProvider);
    final productsOnSale = ref.watch(onSaleProductsProvider);
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    Size size = Utils(context).screenSize;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Center(
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Image.asset(
                      offerImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: offerImages.length,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.red,
                    ),
                  ),
                  autoplay: true,
                ),
              ),
            ),
            const Gap(6),
            TextButton(
              onPressed: () {
                context.router.push(
                  const OnSaleRoute(),
                );
              },
              child: const TextWidget(
                text: 'View all',
                maxLines: 1,
                color: Colors.blue,
                textSize: 20,
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'ON SALE'.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true,
                      ),
                      const Gap(5),
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                const Gap(8),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.33,
                    child: ListView.builder(
                        itemCount: productsOnSale.length < 10
                            ? productsOnSale.length
                            : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return OnSaleWidget(
                            productModel: productsOnSale[i],
                          );
                        }),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Our Products',
                    color: color,
                    textSize: 22,
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(
                        const FeedsRoute(),
                      );
                    },
                    child: const TextWidget(
                      text: 'Browse all',
                      maxLines: 1,
                      color: Colors.blue,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.65),
              children: List.generate(
                  productsList.length < 4 ? productsList.length : 4, (index) {
                return FeedsWidget(
                  productModel: productsList[index],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
