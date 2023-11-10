import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/features/cart/application/cart_notifier.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AppScaffoldScreen extends ConsumerStatefulWidget {
  const AppScaffoldScreen({
    super.key,
  });

  @override
  ConsumerState<AppScaffoldScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends ConsumerState<AppScaffoldScreen> {
  // final List<Map<String, dynamic>> _pages = [
  //   {
  //     'page': const HomeScreen(),
  //     'title': 'Home Screen',
  //   },
  //   {
  //     'page': CategoriesScreen(),
  //     'title': 'Categories Screen',
  //   },
  //   {
  //     'page': const CartScreen(),
  //     'title': 'Cart Screen',
  //   },
  //   {
  //     'page': const UserScreen(),
  //     'title': 'User Screen',
  //   },
  // ];
  
  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(themeNotifierProvider);
    final cartProvider = ref.watch(cartNotifierProvider);
    return AutoTabsScaffold(
      // appBarBuilder: (_, tabsRouter) => AppBar(
      //   backgroundColor: Colors.indigo,
      //   title: const Text('Flutter'),
      //   centerTitle: true,
      // ),
      routes: [
        const HomeRoute(),
        CategoriesRoute(),
        const CartRoute(),
        const UserRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor:
              darkMode ? Theme.of(context).cardColor : Colors.white,
          unselectedItemColor: darkMode ? Colors.white : Colors.black12,
          selectedItemColor:
              darkMode ? Colors.lightBlue.shade200 : Colors.black87,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: tabsRouter.activeIndex == 0
                  ? const Icon(IconlyBold.home)
                  : const Icon(
                      IconlyLight.home,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: tabsRouter.activeIndex == 1
                  ? const Icon(IconlyBold.category)
                  : const Icon(
                      IconlyLight.category,
                    ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text(
                  cartProvider.length.toString(),
                ),
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                child: tabsRouter.activeIndex == 2
                    ? const Icon(IconlyBold.buy)
                    : const Icon(
                        IconlyLight.buy,
                      ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: tabsRouter.activeIndex == 3
                  ? const Icon(IconlyBold.user2)
                  : const Icon(
                      IconlyLight.user2,
                    ),
              label: 'User',
            ),
          ],
        );
      },
    );
  }
}
