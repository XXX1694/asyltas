import 'package:asyltas/app/app.locator.dart';
import 'package:asyltas/app/app.router.dart';
import 'package:asyltas/models/product.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductViewmodel extends BaseViewModel {
  final ProductModel product;
  final _routerService = locator<RouterService>();
  Future goToMainPage() async {
    await _routerService.navigateTo(const HomeViewRoute());
  }

  Future goToLoginPage() async {
    await _routerService.navigateTo(const LoginViewRoute());
  }

  Future goToRegistrationPage() async {
    await _routerService.navigateTo(const RegistrationViewRoute());
  }

  Future goToCatalogPage() async {
    await _routerService.navigateTo(const CatalogViewRoute());
  }

  Future goToProductPage({required ProductModel product}) async {
    await _routerService.navigateTo(ProductViewRoute(product: product));
  }

  Future goToProfilePage() async {
    await _routerService.navigateTo(const ProfileViewRoute());
  }

  Future goToCartPage() async {
    await _routerService.navigateTo(const CartViewRoute());
  }

  Future goToMenu() async {
    await _routerService.navigateTo(const MenuViewRoute());
  }

  ProductViewmodel({required this.product});
}
