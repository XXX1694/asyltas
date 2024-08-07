// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:stacked/stacked.dart' as _i8;
import 'package:stacked_services/stacked_services.dart' as _i7;

import '../models/product.dart' as _i10;
import '../ui/views/catalog/catalog_view.dart' as _i4;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/login/login_view.dart' as _i2;
import '../ui/views/product/product_view.dart' as _i5;
import '../ui/views/registration/registration_view.dart' as _i3;
import '../ui/views/unknown/unknown_view.dart' as _i6;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i7.StackedService.navigatorKey);

class StackedRouterWeb extends _i8.RootStackRouter {
  StackedRouterWeb({_i9.GlobalKey<_i9.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegistrationViewRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.RegistrationView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CatalogViewRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.CatalogView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProductViewArgs>();
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.ProductView(
          key: args.key,
          product: args.product,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownViewRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.UnknownView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'home',
          fullMatch: true,
        ),
        _i8.RouteConfig(
          HomeViewRoute.name,
          path: 'home',
        ),
        _i8.RouteConfig(
          LoginViewRoute.name,
          path: 'login',
        ),
        _i8.RouteConfig(
          RegistrationViewRoute.name,
          path: 'registration',
        ),
        _i8.RouteConfig(
          CatalogViewRoute.name,
          path: 'catalog',
        ),
        _i8.RouteConfig(
          ProductViewRoute.name,
          path: 'catalog/:productId',
        ),
        _i8.RouteConfig(
          UnknownViewRoute.name,
          path: '/404',
        ),
        _i8.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/404',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i8.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: 'home',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.LoginView]
class LoginViewRoute extends _i8.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: 'login',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i3.RegistrationView]
class RegistrationViewRoute extends _i8.PageRouteInfo<void> {
  const RegistrationViewRoute()
      : super(
          RegistrationViewRoute.name,
          path: 'registration',
        );

  static const String name = 'RegistrationView';
}

/// generated route for
/// [_i4.CatalogView]
class CatalogViewRoute extends _i8.PageRouteInfo<void> {
  const CatalogViewRoute()
      : super(
          CatalogViewRoute.name,
          path: 'catalog',
        );

  static const String name = 'CatalogView';
}

/// generated route for
/// [_i5.ProductView]
class ProductViewRoute extends _i8.PageRouteInfo<ProductViewArgs> {
  ProductViewRoute({
    _i9.Key? key,
    required _i10.ProductModel product,
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

  final _i9.Key? key;

  final _i10.ProductModel product;

  @override
  String toString() {
    return 'ProductViewArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i6.UnknownView]
class UnknownViewRoute extends _i8.PageRouteInfo<void> {
  const UnknownViewRoute()
      : super(
          UnknownViewRoute.name,
          path: '/404',
        );

  static const String name = 'UnknownView';
}

extension RouterStateExtension on _i7.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToRegistrationView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const RegistrationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCatalogView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CatalogViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProductView({
    _i9.Key? key,
    required _i10.ProductModel product,
    void Function(_i8.NavigationFailure)? onFailure,
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
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithRegistrationView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const RegistrationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCatalogView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CatalogViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProductView({
    _i9.Key? key,
    required _i10.ProductModel product,
    void Function(_i8.NavigationFailure)? onFailure,
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
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }
}
