// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/features/product/application/products_controller.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    // final productsController = ref.watch(productFutureProvider(ref));
    final mounted = useIsMounted();
    useEffect(() {
      Future.delayed(const Duration(seconds: 5), () async {
        if (mounted()) {
          if (user != null) {
            await ref.read(productControllerProvider).fetchProducts(ref: ref);
            context.router.replace(
              const AppScaffoldRoute(),
            );
          } else {
            context.router.replace(
              const LoginRoute(),
            );
          }
          return () {};
        }
      });
      return null;
    });
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/landing/buyfood.jpg',
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

fetchProducts(WidgetRef ref) {
  return ref.read(productControllerProvider).fetchProducts(
        ref: ref,
      );
}