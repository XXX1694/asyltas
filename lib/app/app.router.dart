// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i12;
import 'package:stacked/stacked.dart' as _i11;
import 'package:stacked_services/stacked_services.dart' as _i10;

import '../models/product.dart' as _i13;
import '../ui/views/cart/cart_view.dart' as _i6;
import '../ui/views/catalog/catalog_view.dart' as _i5;
import '../ui/views/home/home_view.dart' as _i2;
import '../ui/views/login/login_view.dart' as _i3;
import '../ui/views/product/product_view.dart' as _i8;
import '../ui/views/profile/profile_view.dart' as _i7;
import '../ui/views/registration/registration_view.dart' as _i4;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/unknown/unknown_view.dart' as _i9;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i10.StackedService.navigatorKey);

class StackedRouterWeb extends _i11.RootStackRouter {
  StackedRouterWeb({_i12.GlobalKey<_i12.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegistrationViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.RegistrationView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CatalogViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.CatalogView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CartViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.CartView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProductViewArgs>();
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.ProductView(
          key: args.key,
          product: args.product,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.UnknownView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          HomeViewRoute.name,
          path: 'home',
        ),
        _i11.RouteConfig(
          LoginViewRoute.name,
          path: 'login',
        ),
        _i11.RouteConfig(
          RegistrationViewRoute.name,
          path: 'registration',
        ),
        _i11.RouteConfig(
          CatalogViewRoute.name,
          path: 'catalog',
        ),
        _i11.RouteConfig(
          CartViewRoute.name,
          path: 'cart',
        ),
        _i11.RouteConfig(
          ProfileViewRoute.name,
          path: 'profile',
        ),
        _i11.RouteConfig(
          ProductViewRoute.name,
          path: 'catalog/:productId',
        ),
        _i11.RouteConfig(
          UnknownViewRoute.name,
          path: '/404',
        ),
        _i11.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/404',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i11.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i11.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: 'home',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i3.LoginView]
class LoginViewRoute extends _i11.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: 'login',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i4.RegistrationView]
class RegistrationViewRoute extends _i11.PageRouteInfo<void> {
  const RegistrationViewRoute()
      : super(
          RegistrationViewRoute.name,
          path: 'registration',
        );

  static const String name = 'RegistrationView';
}

/// generated route for
/// [_i5.CatalogView]
class CatalogViewRoute extends _i11.PageRouteInfo<void> {
  const CatalogViewRoute()
      : super(
          CatalogViewRoute.name,
          path: 'catalog',
        );

  static const String name = 'CatalogView';
}

/// generated route for
/// [_i6.CartView]
class CartViewRoute extends _i11.PageRouteInfo<void> {
  const CartViewRoute()
      : super(
          CartViewRoute.name,
          path: 'cart',
        );

  static const String name = 'CartView';
}

/// generated route for
/// [_i7.ProfileView]
class ProfileViewRoute extends _i11.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i8.ProductView]
class ProductViewRoute extends _i11.PageRouteInfo<ProductViewArgs> {
  ProductViewRoute({
    _i12.Key? key,
    required _i13.ProductModel product,
  }) : super(
          ProductViewRoute.name,
          path: 'catalog/:productId',
          args: ProductViewArgs(
            key: key,
            product: product,
          ),
        );

  static const String name = 'ProductView';
}

class ProductViewArgs {
  const ProductViewArgs({
    this.key,
    required this.product,
  });

  final _i12.Key? key;

  final _i13.ProductModel product;

  @override
  String toString() {
    return 'ProductViewArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i9.UnknownView]
class UnknownViewRoute extends _i11.PageRouteInfo<void> {
  const UnknownViewRoute()
      : super(
          UnknownViewRoute.name,
          path: '/404',
        );

  static const String name = 'UnknownView';
}

extension RouterStateExtension on _i10.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToHomeView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToRegistrationView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const RegistrationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCatalogView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CatalogViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCartView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CartViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProductView({
    _i12.Key? key,
    required _i13.ProductModel product,
    void Function(_i11.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      ProductViewRoute(
        key: key,
        product: product,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToUnknownView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithRegistrationView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const RegistrationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCatalogView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CatalogViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCartView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CartViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProductView({
    _i12.Key? key,
    required _i13.ProductModel product,
    void Function(_i11.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      ProductViewRoute(
        key: key,
        product: product,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithUnknownView(
      {void Function(_i11.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }
}
