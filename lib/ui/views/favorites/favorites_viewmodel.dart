import 'package:asyltas/app/app.locator.dart';
import 'package:asyltas/app/app.router.dart';
import 'package:asyltas/models/product.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritesViewModel extends BaseViewModel {
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

  Future goToProductPage({
    required ProductModel product,
    required List<ProductModel> categoryProducts,
  }) async {
    await _routerService.navigateTo(
      ProductViewRoute(
        product: product,
        categoryProducts: categoryProducts,
      ),
    );
  }

  Future goToProfilePage() async {
    await _routerService.navigateTo(const ProfileViewRoute());
  }

  Future goToCartPage() async {
    await _routerService.navigateTo(const CartViewRoute());
  }

  Future goToPaymentPage(String price) async {
    await _routerService.navigateTo(
      PaymentViewRoute(
        price: price,
      ),
    );
  }

  Future goToMenu() async {
    await _routerService.navigateTo(const MenuViewRoute());
  }
}
