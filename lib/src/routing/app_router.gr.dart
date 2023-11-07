// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/cupertino.dart' as _i18;
import 'package:flutter/material.dart' as _i17;
import 'package:full_scale_shop_app/src/core/presentation/bottom_nav.dart'
    as _i1;
import 'package:full_scale_shop_app/src/features/auth/presentation/forget_password.dart'
    as _i2;
import 'package:full_scale_shop_app/src/features/auth/presentation/login.dart'
    as _i3;
import 'package:full_scale_shop_app/src/features/auth/presentation/register.dart'
    as _i4;
import 'package:full_scale_shop_app/src/features/cart/presentation/cart.dart'
    as _i5;
import 'package:full_scale_shop_app/src/features/category/presentation/categories.dart'
    as _i6;
import 'package:full_scale_shop_app/src/features/category/presentation/inner_cat_screen.dart'
    as _i7;
import 'package:full_scale_shop_app/src/features/home/presentation/feeds_screen.dart'
    as _i8;
import 'package:full_scale_shop_app/src/features/home/presentation/home_screen.dart'
    as _i9;
import 'package:full_scale_shop_app/src/features/home/presentation/on_sale_screen.dart'
    as _i10;
import 'package:full_scale_shop_app/src/features/product/presentation/product_detail_screen.dart'
    as _i11;
import 'package:full_scale_shop_app/src/features/user/presentation/inner_screens/order/order_screen.dart'
    as _i12;
import 'package:full_scale_shop_app/src/features/user/presentation/inner_screens/viewed/viewed_screen.dart'
    as _i13;
import 'package:full_scale_shop_app/src/features/user/presentation/inner_screens/wishlist/wishlist_screen.dart'
    as _i14;
import 'package:full_scale_shop_app/src/features/user/presentation/user.dart'
    as _i15;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AppScaffoldRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppScaffoldScreen(),
      );
    },
    ForgetPasswordRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ForgetPasswordScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CartScreen(),
      );
    },
    CategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<CategoriesRouteArgs>(
          orElse: () => const CategoriesRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CategoriesScreen(key: args.key),
      );
    },
    InnerCatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<InnerCatRouteArgs>(
          orElse: () =>
              InnerCatRouteArgs(category: pathParams.getString('category')));
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.InnerCatScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    FeedsRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.FeedsScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeScreen(),
      );
    },
    OnSaleRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.OnSaleScreen(),
      );
    },
    ProductsDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductsDetailRouteArgs>(
          orElse: () =>
              ProductsDetailRouteArgs(productId: pathParams.getString('id')));
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ProductsDetailScreen(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    OrderRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.OrderScreen(),
      );
    },
    ViewedRecentlyRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ViewedRecentlyScreen(),
      );
    },
    WishListRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.WishListScreen(),
      );
    },
    UserRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.UserScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppScaffoldScreen]
class AppScaffoldRoute extends _i16.PageRouteInfo<void> {
  const AppScaffoldRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AppScaffoldRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppScaffoldRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ForgetPasswordScreen]
class ForgetPasswordRoute extends _i16.PageRouteInfo<void> {
  const ForgetPasswordRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ForgetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RegisterScreen]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CartScreen]
class CartRoute extends _i16.PageRouteInfo<void> {
  const CartRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CategoriesScreen]
class CategoriesRoute extends _i16.PageRouteInfo<CategoriesRouteArgs> {
  CategoriesRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          CategoriesRoute.name,
          args: CategoriesRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const _i16.PageInfo<CategoriesRouteArgs> page =
      _i16.PageInfo<CategoriesRouteArgs>(name);
}

class CategoriesRouteArgs {
  const CategoriesRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'CategoriesRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.InnerCatScreen]
class InnerCatRoute extends _i16.PageRouteInfo<InnerCatRouteArgs> {
  InnerCatRoute({
    _i17.Key? key,
    required String category,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          InnerCatRoute.name,
          args: InnerCatRouteArgs(
            key: key,
            category: category,
          ),
          rawPathParams: {'category': category},
          initialChildren: children,
        );

  static const String name = 'InnerCatRoute';

  static const _i16.PageInfo<InnerCatRouteArgs> page =
      _i16.PageInfo<InnerCatRouteArgs>(name);
}

class InnerCatRouteArgs {
  const InnerCatRouteArgs({
    this.key,
    required this.category,
  });

  final _i17.Key? key;

  final String category;

  @override
  String toString() {
    return 'InnerCatRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i8.FeedsScreen]
class FeedsRoute extends _i16.PageRouteInfo<void> {
  const FeedsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          FeedsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedsRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomeScreen]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OnSaleScreen]
class OnSaleRoute extends _i16.PageRouteInfo<void> {
  const OnSaleRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnSaleRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnSaleRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ProductsDetailScreen]
class ProductsDetailRoute extends _i16.PageRouteInfo<ProductsDetailRouteArgs> {
  ProductsDetailRoute({
    _i18.Key? key,
    required String productId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ProductsDetailRoute.name,
          args: ProductsDetailRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'ProductsDetailRoute';

  static const _i16.PageInfo<ProductsDetailRouteArgs> page =
      _i16.PageInfo<ProductsDetailRouteArgs>(name);
}

class ProductsDetailRouteArgs {
  const ProductsDetailRouteArgs({
    this.key,
    required this.productId,
  });

  final _i18.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductsDetailRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i12.OrderScreen]
class OrderRoute extends _i16.PageRouteInfo<void> {
  const OrderRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ViewedRecentlyScreen]
class ViewedRecentlyRoute extends _i16.PageRouteInfo<void> {
  const ViewedRecentlyRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ViewedRecentlyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewedRecentlyRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.WishListScreen]
class WishListRoute extends _i16.PageRouteInfo<void> {
  const WishListRoute({List<_i16.PageRouteInfo>? children})
      : super(
          WishListRoute.name,
          initialChildren: children,
        );

  static const String name = 'WishListRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i15.UserScreen]
class UserRoute extends _i16.PageRouteInfo<void> {
  const UserRoute({List<_i16.PageRouteInfo>? children})
      : super(
          UserRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
