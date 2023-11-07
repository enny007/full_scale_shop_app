import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/empty_product.dart';
import 'package:full_scale_shop_app/src/core/widgets/feed_items.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class InnerCatScreen extends HookConsumerWidget {
  const InnerCatScreen({
    super.key,
    @PathParam('category') required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = Utils(context).screenSize;
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final productsByCat = ref.watch(selectedCatProvider(category));
    final searchTextController = useTextEditingController();
    final searchTextFocusNode = useFocusNode();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: productsByCat.isEmpty
          ? const EmptyProdWidget(
              text: 'No products belong to this category',
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        focusNode: searchTextFocusNode,
                        controller: searchTextController,
                        onChanged: (value) {
                          //
                        },
                        cursorColor: Colors.greenAccent,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.greenAccent,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.greenAccent,
                              width: 1,
                            ),
                          ),
                          hintText: 'What product are you looking for?',
                          prefixIcon: const Icon(Icons.search),
                          suffix: IconButton(
                            onPressed: () {
                              searchTextController.clear();
                              searchTextFocusNode.unfocus();
                            },
                            icon: Icon(
                              Icons.close,
                              color: searchTextFocusNode.hasFocus
                                  ? Colors.red
                                  : color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.65),
                    children: List.generate(productsByCat.length, (index) {
                      return FeedsWidget(
                        productModel: productsByCat[index],
                      );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
