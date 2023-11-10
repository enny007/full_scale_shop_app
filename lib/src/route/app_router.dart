import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_router.gr.dart';

// enum AppRoute {
//   onSaleScreen,
//   feedsScreen,
//   productDetails,
//   wishlistScreen,
//   ordersScreen,
//   viewedRecentlyScreen,
//   registerScreen,
//   loginScreen,
//   forgetPasswordScreen,
//   categoryScreen,
//   home,
// }

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          path: '/splashPage',
          page: SplashRoute.page,
        ),
        AutoRoute(
          // initial: true,
          path: '/appScaffold',
          page: AppScaffoldRoute.page,
          children: [
            AutoRoute(
              path: 'home',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'categories',
              page: CategoriesRoute.page,
            ),
            AutoRoute(
              path: 'cart',
              page: CartRoute.page,
            ),
            AutoRoute(
              path: 'user',
              page: UserRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/onSale',
          page: OnSaleRoute.page,
        ),
        AutoRoute(
          path: '/feeds',
          page: FeedsRoute.page,
        ),
        AutoRoute(
          path: '/productDetails/:id',
          page: ProductsDetailRoute.page,
        ),
        AutoRoute(
          path: '/wishList',
          page: WishListRoute.page,
        ),
        AutoRoute(
          path: '/order',
          page: OrderRoute.page,
        ),
        AutoRoute(
          path: '/viewedRecently',
          page: ViewedRecentlyRoute.page,
        ),
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: '/register',
          page: RegisterRoute.page,
        ),
        AutoRoute(
          path: '/forgetPassword',
          page: ForgetPasswordRoute.page,
        ),
        AutoRoute(
          path: '/innerCategories/:category',
          page: InnerCatRoute.page,
        ),
      ];
}

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
