// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/product/application/product_provider.dart';
import 'package:full_scale_shop_app/src/features/product/application/products_controller.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/wishlist_provider.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    useEffect(() {
      Future.delayed(const Duration(seconds: 5), () async {
        if (user == null) {
          // If the user is not logged in, show the LoginPage
          context.router.replace(
            const LoginRoute(),
          );
        } else {
          await ref.read(productControllerProvider).fetchProducts(
                ref: ref,
                productsList: ref.read(productsListProvider),
              );
          await ref.read(cartNotifierProvider.notifier).fetchCart(
                ref: ref,
              );
          await ref.read(wishlistProvider.notifier).fetchWishList(
                ref: ref,
              );
          context.router.replace(
            const AppScaffoldRoute(),
          );
        }
        return () {};
      });
      return null;
    }, []);
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/landing/buyfood.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: SpinKitFadingFour(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
