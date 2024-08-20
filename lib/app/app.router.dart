// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i15;
import 'package:stacked/stacked.dart' as _i14;
import 'package:stacked_services/stacked_services.dart' as _i13;

import '../models/product.dart' as _i16;
import '../ui/views/cart/cart_view.dart' as _i5;
import '../ui/views/catalog/catalog_view.dart' as _i4;
import '../ui/views/category/category_view.dart' as _i9;
import '../ui/views/contacts/contacts_view.dart' as _i10;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/login/login_view.dart' as _i2;
import '../ui/views/menu/menu_view.dart' as _i8;
import '../ui/views/payment/payment_view.dart' as _i7;
import '../ui/views/product/product_view.dart' as _i11;
import '../ui/views/profile/profile_view.dart' as _i6;
import '../ui/views/registration/registration_view.dart' as _i3;
import '../ui/views/unknown/unknown_view.dart' as _i12;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i13.StackedService.navigatorKey);

class StackedRouterWeb extends _i14.RootStackRouter {
  StackedRouterWeb({_i15.GlobalKey<_i15.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegistrationViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.RegistrationView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CatalogViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.CatalogView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CartViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.CartView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentViewRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentViewArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.PaymentView(
          key: args.key,
          price: args.price,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MenuViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.MenuView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CategoryViewRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryViewArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.CategoryView(
          key: args.key,
          categoryId: args.categoryId,
          categoryName: args.categoryName,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ContactsViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i10.ContactsView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProductViewArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.ProductView(
          key: args.key,
          product: args.product,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i12.UnknownView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          HomeViewRoute.name,
          path: '/home',
        ),
        _i14.RouteConfig(
          LoginViewRoute.name,
          path: '/login',
        ),
        _i14.RouteConfig(
          RegistrationViewRoute.name,
          path: '/registration',
        ),
        _i14.RouteConfig(
          CatalogViewRoute.name,
          path: '/catalog',
        ),
        _i14.RouteConfig(
          CartViewRoute.name,
          path: '/cart',
        ),
        _i14.RouteConfig(
          ProfileViewRoute.name,
          path: '/profile',
        ),
        _i14.RouteConfig(
          PaymentViewRoute.name,
          path: '/payment',
        ),
        _i14.RouteConfig(
          MenuViewRoute.name,
          path: '/menu',
        ),
        _i14.RouteConfig(
          CategoryViewRoute.name,
          path: '/category',
        ),
        _i14.RouteConfig(
          ContactsViewRoute.name,
          path: '/contacts',
        ),
        _i14.RouteConfig(
          ProductViewRoute.name,
          path: 'catalog/:productId',
        ),
        _i14.RouteConfig(
          UnknownViewRoute.name,
          path: '/404',
        ),
        _i14.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/home',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i14.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.LoginView]
class LoginViewRoute extends _i14.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i3.RegistrationView]
class RegistrationViewRoute extends _i14.PageRouteInfo<void> {
  const RegistrationViewRoute()
      : super(
          RegistrationViewRoute.name,
          path: '/registration',
        );

  static const String name = 'RegistrationView';
}

/// generated route for
/// [_i4.CatalogView]
class CatalogViewRoute extends _i14.PageRouteInfo<void> {
  const CatalogViewRoute()
      : super(
          CatalogViewRoute.name,
          path: '/catalog',
        );

  static const String name = 'CatalogView';
}

/// generated route for
/// [_i5.CartView]
class CartViewRoute extends _i14.PageRouteInfo<void> {
  const CartViewRoute()
      : super(
          CartViewRoute.name,
          path: '/cart',
        );

  static const String name = 'CartView';
}

/// generated route for
/// [_i6.ProfileView]
class ProfileViewRoute extends _i14.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: '/profile',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i7.PaymentView]
class PaymentViewRoute extends _i14.PageRouteInfo<PaymentViewArgs> {
  PaymentViewRoute({
    _i15.Key? key,
    required String price,
  }) : super(
          PaymentViewRoute.name,
          path: '/payment',
          args: PaymentViewArgs(
            key: key,
            price: price,
          ),
        );

  static const String name = 'PaymentView';
}

class PaymentViewArgs {
  const PaymentViewArgs({
    this.key,
    required this.price,
  });

  final _i15.Key? key;

  final String price;

  @override
  String toString() {
    return 'PaymentViewArgs{key: $key, price: $price}';
  }
}

/// generated route for
/// [_i8.MenuView]
class MenuViewRoute extends _i14.PageRouteInfo<void> {
  const MenuViewRoute()
      : super(
          MenuViewRoute.name,
          path: '/menu',
        );

  static const String name = 'MenuView';
}

/// generated route for
/// [_i9.CategoryView]
class CategoryViewRoute extends _i14.PageRouteInfo<CategoryViewArgs> {
  CategoryViewRoute({
    _i15.Key? key,
    required String categoryId,
    required String categoryName,
  }) : super(
          CategoryViewRoute.name,
          path: '/category',
          args: CategoryViewArgs(
            key: key,
            categoryId: categoryId,
            categoryName: categoryName,
          ),
        );

  static const String name = 'CategoryView';
}

class CategoryViewArgs {
  const CategoryViewArgs({
    this.key,
    required this.categoryId,
    required this.categoryName,
  });

  final _i15.Key? key;

  final String categoryId;

  final String categoryName;

  @override
  String toString() {
    return 'CategoryViewArgs{key: $key, categoryId: $categoryId, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i10.ContactsView]
class ContactsViewRoute extends _i14.PageRouteInfo<void> {
  const ContactsViewRoute()
      : super(
          ContactsViewRoute.name,
          path: '/contacts',
        );

  static const String name = 'ContactsView';
}

/// generated route for
/// [_i11.ProductView]
class ProductViewRoute extends _i14.PageRouteInfo<ProductViewArgs> {
  ProductViewRoute({
    _i15.Key? key,
    required _i16.ProductModel product,
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

  final _i15.Key? key;

  final _i16.ProductModel product;

  @override
  String toString() {
    return 'ProductViewArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i12.UnknownView]
class UnknownViewRoute extends _i14.PageRouteInfo<void> {
  const UnknownViewRoute()
      : super(
          UnknownViewRoute.name,
          path: '/404',
        );

  static const String name = 'UnknownView';
}

extension RouterStateExtension on _i13.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToRegistrationView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const RegistrationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCatalogView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CatalogViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCartView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CartViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToPaymentView({
    _i15.Key? key,
    required String price,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      PaymentViewRoute(
        key: key,
        price: price,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMenuView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const MenuViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCategoryView({
    _i15.Key? key,
    required String categoryId,
    required String categoryName,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      CategoryViewRoute(
        key: key,
        categoryId: categoryId,
        categoryName: categoryName,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToContactsView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ContactsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProductView({
    _i15.Key? key,
    required _i16.ProductModel product,
    void Function(_i14.NavigationFailure)? onFailure,
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
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithRegistrationView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const RegistrationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCatalogView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CatalogViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCartView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CartViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithPaymentView({
    _i15.Key? key,
    required String price,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      PaymentViewRoute(
        key: key,
        price: price,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMenuView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const MenuViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCategoryView({
    _i15.Key? key,
    required String categoryId,
    required String categoryName,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      CategoryViewRoute(
        key: key,
        categoryId: categoryId,
        categoryName: categoryName,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithContactsView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ContactsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProductView({
    _i15.Key? key,
    required _i16.ProductModel product,
    void Function(_i14.NavigationFailure)? onFailure,
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
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }
}
