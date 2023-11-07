import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/empty_screen.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/viewed_product_provider.dart';
import 'package:full_scale_shop_app/src/features/user/presentation/inner_screens/viewed/viewed_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ViewedRecentlyScreen extends ConsumerWidget {
  const ViewedRecentlyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final viewedRecentlyProvider = ref.watch(viewedProductProvider);
    final viewedItemsList =
        viewedRecentlyProvider.values.toList().reversed.toList();
    return viewedItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your history is Empty',
            subtitle: 'No products has been viewed yet!',
            buttonText: 'Shop now',
            imagePath: 'assets/images/history.png',
            isCartScreen: false,
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                      title: 'Empty your history?',
                      subtitle: 'Are you sure?',
                      fct: () {
                        ref.read(viewedProductProvider.notifier).clearHistory();
                      },
                      context: context,
                    );
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                )
              ],
              elevation: 0,
              centerTitle: true,
              title: TextWidget(
                text: 'History',
                color: color,
                textSize: 24.0,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.builder(
                itemCount: viewedItemsList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 6,
                    ),
                    child: ViewedRecentlyWidget(
                      viewedProductModel: viewedItemsList[index],
                    ),
                  );
                }),
          );
  }
}
